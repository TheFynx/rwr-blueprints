#!/bin/bash

cd /tmp

# Clone the Nerd Fonts repository
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git

# Change to the cloned directory
cd nerd-fonts

# Install all patched fonts
./install.sh

cd -