if ! command -v -- chsh > /dev/null 2>&1; then
	sudo dnf install -y util-linux-user
fi

if ! command -v -- flatpak > /dev/null 2>&1; then
	sudo dnf install -y flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

if ! command -v -- nnn > /dev/null 2>&1; then
	sudo dnf install -y nnn
fi

if ! command -v -- nvim > /dev/null 2>&1; then
	sudo dnf install -y neovim
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

if ! command -v -- nvm > /dev/null 2>&1; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

if ! command -v -- rvm > /dev/null 2>&1; then
	sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | sudo bash -s stable
	sudo usermod -a -G rvm $(whoami)
fi

if ! command -v -- gvm > /dev/null 2>&1; then
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi

if ! command -v -- kubectl > /dev/null 2>&1; then
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	rm kubectl
fi

if ! command -v -- kind > /dev/null 2>&1; then
	if command -v -- go > /dev/null 2>&1; then
		go install sigs.k8s.io/kind@v0.18.0
	fi
fi
