#!/usr/bin/env bash
# Language-level tools that apt does not carry on both distros. Runs UNPRIVILEGED
# as the target user: cargo -> ~/.cargo, go -> ~/go, pipx -> ~/.local (already
# on PATH via the Common .path dotfile).
set -euo pipefail

# ---- rust (apt rustup/cargo from the base list) ----
command -v cargo >/dev/null 2>&1 || { echo "cargo missing; run the base apt apply first" >&2; exit 1; }
command -v go >/dev/null 2>&1 || { echo "go missing; run the base apt apply first" >&2; exit 1; }

cargo_tool() {
	local crate="$1" bin="${2:-$1}"
	command -v "$bin" >/dev/null 2>&1 && { echo "cargo: $bin already present"; return 0; }
	cargo install --locked "$crate" && echo "cargo: installed $crate"
}

go_tool() {
	local pkg="$1" bin="${2:-$1}"
	command -v "$bin" >/dev/null 2>&1 && { echo "go: $bin already present"; return 0; }
	GOBIN="$HOME/go/bin" go install "$pkg" && echo "go: installed $bin"
}

# rust tools apt misses on one distro or the other
cargo_tool du-dust dust
cargo_tool dua-cli dua
cargo_tool difftastic
cargo_tool xh
cargo_tool procs
cargo_tool mcfly
cargo_tool bandwhich
cargo_tool bottom

# go tools
go_tool github.com/jesseduffield/lazygit@latest lazygit
go_tool github.com/securego/gosec/v2/cmd/gosec@latest gosec

# python tools
command -v protonup-qt >/dev/null 2>&1 || pipx install protonup-qt

echo "dev tools settled"
