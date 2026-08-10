{
	"packages": [
		{
			"action": "install",
			"names": [
				"gnupg",
				"openssl",
				"graphviz",
				"unzip",
				"zip",
				"rsync",
				"p7zip",
				"shfmt",
				"cmake",
				"pkg-config",
				"freetype",
				"fontconfig",
				"powerline-go",
				"go",
				"libressl"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"names": [
				"utm"
			],
			"package_manager": "brew"
		},
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
				"less",
				"rsync"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"names": [
				"age",
				"argocd",
				"gh",
				"helm",
				"helmfile",
				"ipcalc",
				"shellcheck",
				"sops",
				"yq",
				"pre-commit",
				"commitizen",
				"krew",
				"k9s",
				"kubectl-argo-rollouts",
				"ktail",
				"clamav",
				"tailscale"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"args": [
				"--cask"
			],
			"names": [
				"1password",
				"slack",
				"git-credential-manager",
				"google-cloud-sdk"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"names": [
				"gdu",
				"ripgrep",
				"lazygit",
				"neovim"
			],
			"package_manager": "brew"
		},
		// The shell itself, plus everything Common/fish/config.fish invokes:
		// starship prompt, eza (the ls function), mcfly history, mise, and the
		// topgrade the `cleanup` alias calls.
		{
			"action": "install",
			"names": [
				"fish",
				"starship",
				"eza",
				"mcfly",
				"mise",
				"topgrade"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"names": [
				"nodenv",
				"pyenv",
				"tenv",
				"goreleaser",
				"jq",
				"dasel",
				"difftastic",
				"git-delta",
				"git",
				"tfsec"
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
				"zed",
				"dbeaver-community",
				"bruno"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"names": [
				"vlc",
				"gimp"
			],
			"package_manager": "brew"
		},
		{
			"action": "install",
			"args": [
				"--cask"
			],
			"names": [
				"google-chrome",
				"brave-browser",
				"alacritty",
				"alfred",
				"rectangle",
				"alt-tab",
				"keybase",
				"karabiner-elements"
			],
			"package_manager": "brew"
		}
	]
}
