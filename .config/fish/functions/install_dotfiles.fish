function install_dotfiles



    echo (set_color yellow) "Installing vim-plug..." (set_color normal)
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo (set_color yellow) "Installing vim plugins..." (set_color normal)
    vim +PlugInstall +qall; and echo Success!

    echo (set_color yellow) "Installing fisherman..." (set_color normal)
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

    echo (set_color yellow) "Installing fisherman plugins..." (set_color normal)
    fisher up

    echo (set_color yellow) "Installing platform-specific git settings..." (set_color normal)
    switch (uname)
    	case Linux
            ln -s ~/.gitconfig-linux ~/.gitconfig-platform-specific; and echo Success!
        case Darwin
            ln -s ~/.gitconfig-macos ~/.gitconfig-platform-specific; and echo Success!
        case *
            echo "Unknown OS"
    end

    echo (set_color yellow) "Setting Git to ignore untracked dotfiles..." (set_color normal)
    dotf config --local status.showUntrackedFiles no; and echo Success!

end