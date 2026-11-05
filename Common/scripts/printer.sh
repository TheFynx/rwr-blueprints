#!/usr/bin/env bash
# CUPS printer setup. Runs elevated. Idempotent: re-running converges the
# queue instead of adding a second copy.
#
# Why a script and not the GNOME printer panel: the panel adds a queue with
# whatever driver it picks for the discovered URI, and for this printer the
# two obvious choices are both wrong in a way that is hard to diagnose:
#
#   * The "driverless"/IPP-Everywhere PPD paired with a socket://9100
#     device-uri. The PPD declares application/pdf as its output, so CUPS
#     sends raw PDF to a port that expects PJL/PCL. The printer receives
#     bytes that are not a print job and renders whatever it can, which is
#     how you get a page full of nonsense.
#
#   * The cups-filters "driverless" PPD, whose raster filter chain fails on
#     this printer and leaves jobs stuck in "pdftopdf stopped with status 1".
#
# The fix is to pair a driver with the transport it was written for:
#
#   * Brother's own filter (brother_lpdwrapper_mfcl3780cdw) speaks PJL/PCL,
#     so it belongs on the raw port, socket://<host>:9100.
#   * CUPS's own "everywhere" (IPP Everywhere) PPD speaks PDF over IPP, so
#     it belongs on ipp://<host>:631/ipp/print.
#
# Either pairing works; this installs both so a print works whichever
# transport is reachable. The raw-port queue is the default because it is
# the one that does not depend on the printer's IPP stack behaving.
set -euo pipefail

# The printer's IPv4 address. DHCP will move it eventually; the mDNS name
# (BRW4C82A99405A0.local) only resolves to a link-local IPv6 address here,
# so the address is used for the raw port and the IPP URI. Override with
# PRINTER_IP to point at a different unit.
PRINTER_IP="${PRINTER_IP:-192.168.216.138}"
PRINTER_NAME="Brother-MFC-L3780CDW"
PRINTER_MODEL="Brother MFC-L3780CDW series"
BROTHER_PPD="/usr/share/cups/model/brother_mfcl3780cdw_printer_en.ppd"

# The paper actually loaded in the tray. The printer reports media-ready as
# na_letter_8.5x11in; asking for A4 makes the job sit pending forever
# waiting for media that will never arrive.
PRINTER_MEDIA="${PRINTER_MEDIA:-na_letter_8.5x11in}"

log() { echo "printer: $*"; }
warn() { echo "printer: $*" >&2; }

# CUPS has to be running before lpadmin will talk to it.
if ! systemctl is-active --quiet cups; then
	log "starting cups"
	systemctl enable --now cups
fi

# Wait for the printer to answer. A printer that is mid-print or asleep
# refuses connections on both the raw port and IPP, and lpadmin against a
# dead host produces a queue that silently never prints.
wait_for_printer() {
	local tries="${1:-30}" i
	for i in $(seq 1 "$tries"); do
		if timeout 2 bash -c "cat < /dev/null > /dev/tcp/${PRINTER_IP}/9100" 2>/dev/null; then
			return 0
		fi
		sleep 2
	done
	return 1
}

if ! wait_for_printer 15; then
	warn "printer ${PRINTER_IP} not answering on 9100 - skipping queue setup"
	warn "power-cycle the printer, then re-run to finish the setup"
	exit 0
fi

log "printer reachable at ${PRINTER_IP}"

# Remove stale queues before recreating them. A queue left over from a
# previous run with a broken PPD keeps its old PPD, so recreating is only
# safe after the old one is gone.
for q in "$PRINTER_NAME" "${PRINTER_NAME}-IPP"; do
	if lpstat -p "$q" >/dev/null 2>&1; then
		log "removing existing queue ${q}"
		lpadmin -x "$q" 2>/dev/null || true
	fi
done

# Any other queue pointing at this host is stale too (the printer panel adds
# one under a mangled name like Brother_MFC-L3780CDW_series); drop it so it
# cannot shadow the real queue. Match on the device URI, not the name: the
# panel's name varies, the address does not.
while read -r q; do
	[ -n "$q" ] || continue
	case "$q" in
		"$PRINTER_NAME"|"${PRINTER_NAME}-IPP") continue ;;
	esac
	uri="$(lpstat -v "$q" 2>/dev/null | head -1 | sed 's/.*device for [^:]*: //')"
	case "$uri" in
		*"${PRINTER_IP}"*)
			log "removing stale queue ${q} (${uri})"
			lpadmin -x "$q" 2>/dev/null || true
			;;
	esac
done < <(lpstat -v 2>/dev/null | sed -n 's/^device for \(.*\): .*/\1/p')

# Queue 1: Brother's proprietary driver over the raw PJL/PCL port.
if [ -f "$BROTHER_PPD" ]; then
	log "adding raw-port queue (Brother PJL/PCL driver)"
	lpadmin -p "$PRINTER_NAME" -E \
		-v "socket://${PRINTER_IP}:9100" \
		-P "$BROTHER_PPD" \
		-D "$PRINTER_MODEL" \
		-L "Office"
else
	warn "Brother PPD missing at ${BROTHER_PPD} - installing only the IPP queue"
fi

# Queue 2: CUPS's own IPP Everywhere driver over IPP.
log "adding IPP queue (CUPS IPP Everywhere driver)"
lpadmin -p "${PRINTER_NAME}-IPP" -E \
	-v "ipp://${PRINTER_IP}:631/ipp/print" \
	-m everywhere \
	-D "$PRINTER_MODEL" \
	-L "Office"

# Defaults that match the printer rather than CUPS's guesswork: colour
# (the printer is a colour MFC), the media the tray actually holds, and
# single-sided. lpadmin -o writes these as server-side printer defaults, so
# they apply to every user's jobs - a job from a desktop app that sends no
# options of its own still lands on Letter in colour.
for q in "$PRINTER_NAME" "${PRINTER_NAME}-IPP"; do
	lpstat -p "$q" >/dev/null 2>&1 || continue
	lpadmin -p "$q" \
		-o "media=${PRINTER_MEDIA}" \
		-o "print-color-mode=color" \
		-o "print-quality=normal" \
		-o "sides=one-sided"
done

# The raw-port queue is the default: it does not depend on the printer's
# IPP stack, which is what wedged the queue in the first place.
if lpstat -p "$PRINTER_NAME" >/dev/null 2>&1; then
	lpadmin -d "$PRINTER_NAME"
elif lpstat -p "${PRINTER_NAME}-IPP" >/dev/null 2>&1; then
	lpadmin -d "${PRINTER_NAME}-IPP"
fi

log "queues:"
lpstat -t 2>&1 | sed 's/^/printer:   /'
log "done"
