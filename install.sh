#!/bin/bash

set -e

echo "Creating folder for binaries..."
mkdir -p ~/.local/bin

echo "Setting up symlinks..."

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/aliases ~/.aliases

echo "Installing package managers..."
echo "Installing pixi and uv"
curl -fsSL https://pixi.sh/install.sh | sh
curl -fsSL https://astral.sh/uv/install.sh | sh

echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


echo "Installing packages..."
pixi global install brename croc csvlens csvtk diskus dust jless less naf nvim ouch pqrs quarto ripgrep seqkit sponge xan zet
# Optional: Use package manager
# sudo apt install zsh git curl ...
# or for macOS
# brew install zsh git curl ...

echo "Installing binaries..."



echo "Done!"
