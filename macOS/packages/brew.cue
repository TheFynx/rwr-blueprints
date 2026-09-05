{
	"packages": [
		// Core libs and build/system tools
		{
			"action": "install",
			"names": [
				"cmake",
				"curl",
				"ghostscript",
				"gnupg",
				"go",
				"graphviz",
				"libressl",
				"p7zip",
				"parallel",
				"powerline-go",
				"ollama",
				"go",
				"libressl"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"names": [
				"utm"
				"rename",
				"rsync",
				"shfmt",
				"telnet",
				"unzip",
				"zip"
			],
			"package_manager": "brew"
		},
		// macOS is dumb - install the GNU/Linux superior tools
		{
			"action": "install",
			"names": [
				"tree",
				"bash",
				"watch",
				"wget",
				"binutils",
				"diffutils",
				"coreutils",
				"ed",
				"findutils",
				"gawk",
				"gnu-indent",
				"gnu-sed",
				"gnu-tar",
				"gnu-which",
				"grep",
				"gzip",
				"less"
			],
			"package_manager": "brew"
		},
		// Work: cloud, infra, data
		{
			"action": "install",
			"names": [
				"gh",
				"gosec",
				"libpq",
				"opentofu",
				"postgresql@17",
				"pulumi",
				"shellcheck",
				"slackdump",
				"yamllint"
			],
			"package_manager": "brew"
		},
		// Containers: docker CLI + compose; the daemon comes from the orbstack cask
		{
			"action": "install",
			"names": [
				"docker",
				"docker-buildx",
				"docker-compose",
				"lazydocker"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"args": [
				"--cask"
			],
			"names": [
				"git-credential-manager",
				"gcloud-cli"
			],
			"package_manager": "brew"
		},
		// CLI quality of life + editors
		{
			"action": "install",
			"names": [
				"act",
				"actionlint",
				"bats-core",
				"cue",
				"cuetools",
				"dasel",
				"difftastic",
				"fd",
				"gdu",
				"git",
				"git-delta",
				"jp2a",
				"jq",
				"jwt-cli",
				"lazygit",
				"msitools",
				"neovim",
				"ripgrep",
				"vhs",
				"wego",
				"wrkflw",
				"wtfutil"
			],
			"package_manager": "brew"
		},
		// The shell itself. eza, mcfly, and topgrade that Common/fish/config.fish
		// invokes come from cargo.cue, not brew.
		{
			"action": "install",
			"names": [
				"fish",
				"starship",
				"mise"
			],
			"package_manager": "brew"
		},
		// Keyboard remapping - kanata replaced karabiner-elements. Run kanata-tray
		// itself with sudo (kanata needs root for the virtual HID keyboard); the
		// tray then execs kanata directly. Requires the Karabiner-DriverKit-
		// VirtualHIDDevice driver + daemon.
		{
			"action": "install",
			"names": [
				"kanata",
				"kanata-tray"
			],
			"package_manager": "brew"
		},
		// Language toolchains and version managers
		{
			"action": "install",
			"names": [
				"goreleaser",
				"nodenv",
				"pipx",
				"pyenv",
				"python@3.12",
				"python@3.13",
				"rust",
				"yarn"
			],
			"package_manager": "brew"
		},
		// AI tooling
		{
			"action": "install",
			"names": [
				"gemini-cli",
				"ollama"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"args": [
				"--cask"
			],
			"names": [
				"visual-studio-code",
				"dbeaver-community",
				"bruno",
				"orbstack",
				"claude",
				"claude-code"
			],
			"package_manager": "brew"
		},
		// Apps. ghostty replaced alacritty as the terminal. reeve comes from
		// the reeveops/tap repository.
		{
			"action": "install",
			"args": [
				"--cask"
			],
			"names": [
				"google-chrome",
				"brave-browser",
				"firefox",
				"ghostty",
				"alfred",
				"rectangle",
				"keybase",
				"deskpad",
				"dangerzone",
				"libreoffice",
				"nimbalyst",
				"reeve",
				"zoom",
				"vlc",
				"gimp",
				"font-fira-code-nerd-font"
			],
			"package_manager": "brew"
		}
	]
}
