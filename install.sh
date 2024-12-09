#!/usr/bin/env sh

#
# Auxiliaries
#
print_info() {
    echo "\e[33m o ${1}\e[0m"
}
print_title() {
    echo "\e[34;1m===> ${1}\e[0m"
}
has_command() {
    if ! command -v "$1" 2>&1 >/dev/null
    then
        return 1
    fi
}

parent=$(dirname "$(realpath $0)")
print_info "Dotfile directory: $parent"

print_info 'Updating and upgrading APT'
yes | sudo apt update
yes | sudo apt upgrade

#
# 1. Zsh
#
print_title 'Configuring Zsh'

# install Zsh if not installed
has_command 'zsh'
if [ $? -eq 1 ]
then
    print_info 'Installing Zsh'
    yes | sudo apt install zsh

    print_info 'Switching to Zsh'
    chsh -s $(which zsh)
fi

print_info "Installing 'zsh/.zshrc' to '$HOME/.zshrc'"
ln -s "$parent/zsh/.zshrc" "$HOME/.zshrc"

# print_info "Installing 'zsh/aliases.zsh' to '$HOME/.zim/aliases.zsh'"
# ln -s "$parent/zsh/aliases.zsh" "$HOME/.zim/aliases.zsh"

#
# 2. Zim
#
print_title 'Configuring Zim'

print_info "Installing 'zimfw/.zimrc' to '$HOME/.zimrc'"
ln -s "$parent/zimfw/.zimrc" "$HOME/.zimrc"

#
# 3. NeoVim
#
print_title 'Configuring NeoVim'

# install NeoVim if not installed
has_command 'nvim'
if [ $? -eq 1 ]
then
    print_info 'Downloading NeoVim'
    curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz > "$parent/nvim.tar.gz"

    print_info 'Decompressing NeoVim'
    tar xzvf "$parent/nvim.tar.gz"
    command rm -rf "$parent/nvim.tar.gz"

    print_info "Installing NeoVim to '$HOME/.local/nvim'"
    if [ ! -e "$HOME/.local" ]
    then
        mkdir "$HOME/.local"
    fi
    mv -P "$parent/nvim-linux64" "$HOME/.local/nvim"

    print_info 'Configuring NeoVim'
    if [ ! -e "$HOME/.local/bin" ]
    then
        mkdir "$HOME/.local/bin"
    fi
    ln -s "$HOME/.local/nvim/bin/nvim" "$HOME/.local/bin/nvim"
    ln -s "$HOME/.local/nvim/bin/nvim" "$HOME/.local/bin/nv"
fi

print_info "Installing 'nvim/' to '$HOME/.config/nvim'"
ln -s "$parent/nvim" "$HOME/.config/nvim"

#
# 4. GitHub
#
print_title 'Configuring Git'

# install Git if not installed
has_command 'git'
if [ $? -eq 1 ]
then
    print_info 'Installing Git'
    yes | sudo apt install git
fi

print_info "Installing 'git/.gitconfig' to '$HOME/.gitconfig'"
ln -s "$parent/git/.gitconfig" "$HOME/.gitconfig"

#
# 5. Docker
#
print_title 'Configuring Docker'

print_info "Installing 'docker/config.json' to '$HOME/.docker/config.json'"
if [ ! -e "$HOME/.docker" ]
then
    mkdir "$HOME/.docker"
fi
ln -s "$parent/docker/config.json" "$HOME/.docker/config.json"
