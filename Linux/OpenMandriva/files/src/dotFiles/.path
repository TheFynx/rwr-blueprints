#!/usr/bin/env bash

if [ -d "/usr/share/bcc/tools" ]; then
  export PATH=/usr/share/bcc/tools:${PATH}
fi

if [ -d "{{ .User.home }}/go/bin" ]; then
  export PATH={{ .User.home }}/go/bin:${PATH}
fi

if [ -d "/usr/local/bin" ]; then
  export PATH=/usr/local/bin:${PATH}
fi

if [ -d "{{ .User.home }}/.cargo/bin" ]; then
  export PATH={{ .User.home }}/.cargo/bin:${PATH}
fi

if [ -d "/sbin" ]; then
  export PATH="/sbin:${PATH}"
fi

if [ -d "/usr/sbin" ]; then
  export PATH="/usr/sbin:${PATH}"
fi

if [ -d "{{ .User.home }}/.pulumi/bin" ]; then
  export PATH=$PATH:{{ .User.home }}/.pulumi/bin
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin/" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -d "{{ .User.home }}/.nodenv" ]; then
  PATH="{{ .User.home }}/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

if [ -d "{{ .User.home }}/.pyenv" ]; then
  PATH="{{ .User.home }}/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

if [ -d "{{ .User.home }}/.goenv" ]; then
  PATH="{{ .User.home }}/.goenv/bin:$PATH"
  eval "$(goenv init -)"
fi

if [ -d "{{ .User.home }}/.local/bin" ]; then
  export PATH="{{ .User.home }}/.local/bin:${PATH}"
fi

if [ -d "{{ .User.home }}/.cargo/bin" ]; then
  export PATH="{{ .User.home }}/.cargo/bin:${PATH}"
fi

if [ -n "$(command -v mcfly)" ]; then
  eval "$(mcfly init bash)"
fi

if [ -d "{{ .User.home }}/.nix-profile/share/" ]; then
  export XDG_DATA_DIRS="{{ .User.home }}/.local/share/:{{ .User.home }}/.nix-profile/share/:/usr/local/share:/usr/share"
fi

if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [ -d "{{ .User.home }}/.local/share/JetBrains/Toolbox/scripts" ]; then
  export PATH="$PATH:{{ .User.home }}/.local/share/JetBrains/Toolbox/scripts"
fi