// Workstation pacman packages; base + desktop + gpu come in via Common
// imports (profiles: desktop gates the workstation extras, radeon/nvidia pick
// the GPU vendor, all selected via --profile).
{
	"packages": [
		// Stale defaults (PrismLinux ships firefox/alacritty; nodejs fights
		// bitwarden-cli) are purged by scripts/purge-defaults.sh instead of a
		// packages "remove" entry: rwr's remove errors on absent targets, so
		// those entries turned into permanent per-run failures once converged.
		{
			"import": "../../../Common/packages/arch/base-pacman.cue"
		},
		{
			"import": "../../../Common/packages/arch/desktop-laptop.cue",
			// Declared here, not just inside the imported file: rwr's profile
			// discovery walks only this tree, so profiles that live solely in
			// Common/ are invisible to --profile validation.
			"profiles": ["desktop", "laptop"]
		},
		{
			"import": "../../../Common/packages/arch/gpu.cue",
			"profiles": ["radeon", "nvidia"]
		},
		{
			"action": "install",
			"names": [
				"github-cli",
				"git-delta",
				"7zip",
				"bitwarden-cli",
				"gnome-disk-utility",
				"tailscale",
				"dagger",
				"ttf-dejavu",
				"ttf-liberation",
				"noto-fonts",
				"noto-fonts-emoji",
				"ghostty",
				"ghostty-shell-integration",
				"mediainfo",
				"amf-headers",
				"fish",
				"starship",
				"fzf",
				"mpv",
				"ffmpeg",
				"inkscape",
				"libreoffice-fresh",
				"deepin-calculator",
				"spectacle",
				"gparted",
				"xreader",
				"xviewer",
				"xed",
				"ttf-cascadia-code",
				"ttf-fira-code",
				"ttf-jetbrains-mono",
				"noto-fonts-cjk",
				"noto-fonts-extra",
				"rustup",
				// LTS, not current: bitwarden-cli depends on nodejs-lts-jod,
				// which conflicts with nodejs. Provides: nodejs=22 keeps AUR
				// makedepends happy; per-version dev nodes come from mise.
				"nodejs-lts-jod",
				"gnome-keyring",
				"seahorse",
				"fwupd",
				"ufw",
				"flatpak",
				"virtualbox",
				"virtualbox-host-dkms",
				"cups",
				"cups-pdf",
				// cups-filters is what CUPS's own IPP Everywhere driver
				// needs to rasterise, and cups-browsed is what discovers
				// network printers over mDNS. Both are only useful with a
				// printer, so they ride the printer profile.
				"samba",
				"gvfs-smb",
				"nss-mdns",
				"openssh",
				"fastfetch"
			],
			"package_manager": "pacman"
		},
		{
			"action": "install",
			"profiles": ["printer"],
			"names": [
				"cups-filters",
				"cups-browsed",
				// Brother's own CUPS filter (PJL/PCL for the raw port)
				// plus the model PPD it installs. The vendor driver is the
				// one that speaks the printer's native wire format; the
				// generic CUPS drivers cannot drive this machine over the
				// raw port.
				"brother-mfc-l3780cdw"
			],
			"package_manager": "pacman"
		}
	]
}
