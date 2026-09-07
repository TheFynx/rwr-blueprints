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
			"import": "../../Common/packages/arch/base-pacman.cue"
		},
		{
			"import": "../../Common/packages/arch/desktop-laptop.cue",
			// Declared here, not just inside the imported file: rwr's profile
			// discovery walks only this tree, so profiles that live solely in
			// Common/ are invisible to --profile validation.
			"profiles": ["desktop", "laptop"]
		},
		{
			"import": "../../Common/packages/arch/gpu.cue",
			"profiles": ["radeon", "nvidia"]
		},
		{
			"action": "install",
			"names": [
				"github-cli",
				"git-delta",
				"7zip",
				"tealdeer",
				"protonup-qt",
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
				"pix",
				"xreader",
				"xviewer",
				"xed",
				"maplemono-ttf",
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
				"needrestart",
				"virtualbox",
				"virtualbox-guest-utils",
				"virtualbox-host-dkms",
				"cups",
				"cups-pdf",
				"samba",
				"gvfs-smb",
				"nss-mdns",
				"openssh",
				"fastfetch"
			],
			"package_manager": "pacman"
		}
	]
}
