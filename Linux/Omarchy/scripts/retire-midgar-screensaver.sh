#!/usr/bin/env bash
# Retire the Midgar adaptive screensaver. Every apply removes it again if a
# machine still has the launcher, the levi.idle clone, the branding hook, or
# the theme copy. A machine that is already clean is left unchanged.
set -euo pipefail

config="${HOME}/.config/omarchy"
state="${HOME}/.local/state/omarchy"
branding="${config}/branding/screensaver.txt"
backup="${state}/midgar-mako/branding-before.txt"
logo="${OMARCHY_PATH:-/usr/share/omarchy}/logo.txt"
changed=0

note() {
	printf 'retire-midgar-screensaver: %s\n' "$1"
	changed=1
}

restore_branding() {
	if [[ -f $backup ]]; then
		cp --remove-destination "$backup" "$branding"
		note "restored the screensaver branding saved before Midgar"
	elif [[ -f $logo ]]; then
		cp --remove-destination "$logo" "$branding"
		note "restored the Omarchy logo screensaver"
	elif [[ -e $branding || -L $branding ]]; then
		rm -f "$branding"
		note "removed Midgar screensaver branding"
	fi
}

midgar_art() {
	local candidate
	[[ -f $branding && ! -L $branding ]] || return 1
	for candidate in \
		"${config}/themes/midgar-mako/screensaver/screensaver.txt" \
		"${state}/current/theme/screensaver/screensaver.txt"; do
		[[ -f $candidate ]] || continue
		cmp -s "$branding" "$candidate" && return 0
	done
	return 1
}

if [[ -L $branding ]]; then
	case $(readlink "$branding") in
	*midgar-mako/screensaver/* | *current/theme/screensaver/*)
		restore_branding
		;;
	esac
elif midgar_art; then
	restore_branding
fi

if [[ -e ${config}/screensaver || -L ${config}/screensaver ]]; then
	rm -rf "${config}/screensaver"
	note "removed ~/.config/omarchy/screensaver"
fi

hook="${config}/hooks/theme-set.d/40-midgar-branding"
if [[ -e $hook || -L $hook ]]; then
	rm -f "$hook"
	note "removed the 40-midgar-branding hook"
fi

for dir in \
	"${config}/themes/midgar-mako/screensaver" \
	"${state}/current/theme/screensaver"; do
	if [[ -d $dir ]]; then
		rm -rf "$dir"
		note "removed $dir"
	fi
done

menu="${config}/extensions/omarchy-menu.jsonc"
if [[ -f $menu ]] && grep -q 'screensaver/launch' "$menu"; then
	python3 - "$menu" <<'PY'
import pathlib, re, sys
path = pathlib.Path(sys.argv[1])
text = path.read_text()
new, count = re.subn(
    r'("system\.screensaver"\s*:\s*\{[^}]*"action"\s*:\s*")[^"]*screensaver/launch[^"]*(")',
    r"\1omarchy launch screensaver force\2",
    text,
    count=1,
)
if count:
    path.write_text(new)
PY
	note "pointed the screensaver menu entry at Omarchy"
fi

shell="${config}/shell.json"
plugin="${config}/plugins/levi.idle"
if [[ -e $plugin || -L $plugin ]] && command -v omarchy >/dev/null 2>&1; then
	if omarchy plugin remove levi.idle --yes; then
		note "removed the levi.idle plugin"
	fi
fi

if [[ -f $shell ]] && grep -q '"levi.idle"' "$shell"; then
	tmp=$(mktemp)
	jq '
		.plugins = [(.plugins // [])[] | select(.id != "levi.idle")]
		| .cloneSourceRestores = ((.cloneSourceRestores // []) | map(select(. != "levi.idle")))
		| if .cloneSourceRestores == [] then del(.cloneSourceRestores) else . end
		| .disabledPlugins = ((.disabledPlugins // []) | map(select(. != "omarchy.idle")))
		| if .disabledPlugins == [] then del(.disabledPlugins) else . end
	' "$shell" >"$tmp"
	mv "$tmp" "$shell"
	note "restored the stock idle service in shell.json"
fi

if [[ -e $plugin || -L $plugin ]]; then
	rm -rf "$plugin"
	note "removed the levi.idle plugin directory"
fi

if [[ -n ${HYPRLAND_INSTANCE_SIGNATURE:-} ]] && command -v hyprctl >/dev/null 2>&1; then
	if hyprctl getoption cursor:invisible 2>/dev/null | grep -q 'bool: true'; then
		hyprctl eval 'hl.config({ cursor = { invisible = false } })' >/dev/null 2>&1 || true
		note "cleared a stuck invisible cursor"
	fi
fi

if ((changed)); then
	echo "retire-midgar-screensaver: done"
else
	echo "retire-midgar-screensaver: already clean"
fi
