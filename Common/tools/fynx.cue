scripts: [{
	action: "run"
	exec:   "bash"
	name:   "build-fynx"
	content: """
		set -euo pipefail
		project="$HOME/git/thefynx/cli"
		if [[ ! -f "$project/build.sh" ]]; then
			echo "fynx: no CLI checkout at $project - skipping build (fynx aliases will no-op)" >&2
			exit 0
		fi
		bash "$project/build.sh"
		echo "fynx:"
		fynx --version
		"""
}]