scripts: [{
 action: "run"
 exec: "bash"
 name: "build-fynx"
 content: """
  set -euo pipefail
  project="$HOME/git/thefynx/cli"
  [[ -f "$project/build.sh" ]] || { echo "Place the CLI checkout at $project before provisioning fynx" >&2; exit 1; }
  exec bash "$project/build.sh"
  """
}]
