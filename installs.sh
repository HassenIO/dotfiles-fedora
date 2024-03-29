#!/bin/sh

sudo dnf upgrade
sudo dnf update -y

if ! command -v -- chsh > /dev/null 2>&1; then
	sudo dnf install -y util-linux-user
fi

if ! command -v -- zsh > /dev/null 2>&1; then
	sudo dnf install -y zsh
	# Install Oh My ZSH
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

if ! command -v -- tig > /dev/null 2>&1; then
	sudo dnf install -y tig
fi

if ! command -v -- rg > /dev/null 2>&1; then
	sudo dnf install -y ripgrep
fi

# Manual install of AWS CLI
if ! command -v -- aws > /dev/null 2>&1; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$HOME/Downloads/awscliv2.zip"
	unzip $HOME/Downloads/awscliv2.zip
	sudo $(pwd)/aws/install
	rm $HOME/Downloads/awscliv2.zip
	rm -r $(pwd)/aws
fi

# Install VSCode for Fedora
if ! command -v -- code > /dev/null 2>&1; then
	# Source: https://linuxiac.com/how-to-install-vs-code-on-fedora-linux/
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	sudo dnf update -y
	sudo dnf install -y code
fi

# Install and configure asdf
if ! command -v -- asdf > /dev/null 2>&1; then
	# Source: https://asdf-vm.com/guide/getting-started.html
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
        # NOTA: I'm using the asdf plugin for OhMyZSH to setup asdf
fi

#
#   ONE TIME INSTALLS
#
#   Tu install Ruby through asdf, we need first to install some dev libraries.
#
#   sudo dnf group install "Development Tools"
#   sudo dnf install -y openssl-devel libyaml-devel readline-devel zlib-devel libffi-devel
#   asdf install ruby 3.2.2
#
