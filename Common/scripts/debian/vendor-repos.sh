#!/usr/bin/env bash
# Third-party apt repositories + their packages for Debian/Ubuntu, one vendor
# at a time. Elevated; idempotent - repos are added only when missing and
# packages skip when already installed. Runs before the language installer so
# apt state is settled first.
set -euo pipefail

. /etc/os-release
ID="${ID:-debian}"
CODENAME="${VERSION_CODENAME:-}"
ARCH="$(dpkg --print-architecture)"

repo() {
	local name="$1" key_url="$2" line="$3"
	local keyring="/usr/share/keyrings/${name}-archive-keyring.gpg"
	local list="/etc/apt/sources.list.d/${name}.list"
	if [ ! -s "$keyring" ]; then
		curl -fsSL "$key_url" | gpg --dearmor -o "$keyring"
	fi
	if [ ! -s "$list" ]; then
		echo "deb [signed-by=$keyring arch=${ARCH}] $line" > "$list"
		echo "repo added: ${name}"
	fi
}

have() { dpkg -s "$1" >/dev/null 2>&1; }

# ---- docker (ce stack replaces docker.io; gives buildx + compose v2) ----
if ! have docker-ce; then
	repo docker "https://download.docker.com/linux/${ID}/gpg" \
		"https://download.docker.com/linux/${ID} ${CODENAME} stable"
	apt-get update -qq
	apt-get install -y docker-ce docker-ce-cli containerd.io \
		docker-buildx-plugin docker-compose-plugin
fi

# ---- ghostty ----
if ! have ghostty; then
	repo ghostty "https://pkg.ghostty.org/linux/ghostty-keyring.gpg" \
		"https://pkg.ghostty.org/linux ${CODENAME} main" || true
	apt-get update -qq || true
	apt-get install -y ghostty || echo "ghostty: repo install failed, skipping" >&2
fi

# ---- mise ----
if ! have mise; then
	repo mise "https://mise.jdx.dev/gpg-key.pub" \
		"https://mise.jdx.dev/deb stable main"
	apt-get update -qq
	apt-get install -y mise
fi

# ---- vscode ----
if ! have code; then
	repo microsoft "https://packages.microsoft.com/keys/microsoft.asc" \
		"https://packages.microsoft.com/${ID} ${CODENAME} main"
	apt-get update -qq
	apt-get install -y code
fi

# ---- dbeaver ----
if ! have dbeaver-ce; then
	repo dbeaver "https://dbeaver.io/debs/dbeaver.gpg.key" \
		"https://dbeaver.io/debs/dbeaver-ce ${CODENAME} /"
	apt-get update -qq
	apt-get install -y dbeaver-ce
fi

# ---- tailscale (official installer manages its own repo) ----
if ! have tailscale; then
	curl -fsSL https://tailscale.com/install.sh | bash
fi

# ---- starship (official installer, binary to /usr/local/bin) ----
if ! command -v starship >/dev/null 2>&1; then
	curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
fi

# ---- fastfetch: trixie has it in apt, noble needs the github deb ----
if ! have fastfetch; then
	if [ "$ID" = "debian" ]; then
		apt-get install -y fastfetch
	else
		url="$(curl -fsSL https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest \
			| grep -oP '"browser_download_url":\s*"\K[^"]*linux-amd64\.deb' | head -1)"
		[ -n "$url" ] && curl -fsSL "$url" -o /tmp/fastfetch.deb && \
			dpkg -i /tmp/fastfetch.deb >/dev/null 2>&1 || apt-get install -fy
	fi
fi

# ---- claude-code (global npm; nodejs/npm come from the apt base) ----
if ! command -v claude >/dev/null 2>&1; then
	npm install -g @anthropic-ai/claude-code
fi

echo "vendor repos + packages settled"
