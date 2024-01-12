#!/bin/sh

sudo dnf upgrade
sudo dnf update -y

if ! command -v -- chsh > /dev/null 2>&1; then
	sudo dnf install -y util-linux-user
fi

if ! command -v -- nvim > /dev/null 2>&1; then
	sudo dnf install -y neovim
fi

if ! command -v -- nnn > /dev/null 2>&1; then
	sudo dnf install -y nnn
fi

if ! command -v -- fzf > /dev/null 2>&1; then
	sudo dnf install -y fzf
fi

if ! command -v -- rg > /dev/null 2>&1; then
	sudo dnf install -y ripgrep
fi

if ! command -v -- aws > /dev/null 2>&1; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$HOME/Downloads/awscliv2.zip"
	unzip $HOME/Downloads/awscliv2.zip
	sudo $(pwd)/aws/install
	rm $HOME/Downloads/awscliv2.zip
	rm -r $(pwd)/aws
fi

