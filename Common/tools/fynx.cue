scripts: [{
	action: "run"
	exec:   "bash"
	name:   "build-fynx"
	content: """
		set -euo pipefail
		project="$HOME/git/thefynx/cli"
		if [[ ! -d "$project" ]]; then
			git clone --quiet git@github.com:TheFynx/cli.git "$project"
		elif [[ -d "$project/.git" ]]; then
			# An existing checkout belongs to its user: never mutate it,
			# just surface staleness before building the local state.
			git -C "$project" fetch --quiet origin 2>/dev/null || true
			behind=$(git -C "$project" rev-list --count main..origin/main 2>/dev/null || echo 0)
			if [[ "$behind" != "0" ]]; then
				echo "fynx: checkout is $behind commits behind origin/main - building local state" >&2
			fi
		else
			echo "fynx: $project exists but is not a git checkout - building in place" >&2
		fi
		[[ -f "$project/build.sh" ]] || { echo "fynx: no build.sh at $project - skipping (aliases will no-op)" >&2; exit 0; }
		bash "$project/build.sh"
		echo "fynx:"
		fynx --version
		"""
}]