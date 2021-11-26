#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

fancy_echo() {
  local fmt="$1"; shift

  printf "\\n$fmt\\n" "$@"
}

get() {
  curl -fLO $1 --create-dirs $2
}

if [ "$CODESPACES" == "true" ]; then
        fancy_echo "In codespaces! Installing apt-get packages"
        apt-get -y install fish fzf ripgrep git kitty

        # fancy_echo "Installing asdf"
        # git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
        fancy_echo "Installing Starship"
        sh -c "$(curl -fsSL https://starship.rs/install.sh)"



        fancy_echo "Installing dotfiles"
        mv $HOME/.gitconfig $HOME/.gitconfig.old

        locals=("fish" "vim" "starship.toml")
        for i in "${locals[@]}"
        do
                ln -sf $(pwd -P)/.config/$i "$HOME/dotfiles"
        done
 
        fancy_echo "Switching to fish"
        chsh -s $(which fish)

        fancy_echo "Installing vim plugins"
        if [ -e "$HOME"/.vim/autoload/plug.vim ]; then
                vim -E -s +PlugUpgrade +qa
        else
                curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
        mkdir ~/.vim-tmp # add vim backup directory to prevent errors like https://stackoverflow.com/questions/8428210/cannot-create-backup-fileadd-to-overwrite
        vim +PlugUpdate +PlugClean! +qa

        fancy_echo "All done"
else
        fancy_echo "Not running in a codespace"

fi

