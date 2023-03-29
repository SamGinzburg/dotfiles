mkdir -p ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim
cp init.vim ~/.vimrc
cp .tmux.conf ~/.tmux.conf

# install vim-plug
# nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install fonts
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/JetBrainsMono
./install.sh JetBrainsMono
cd ..

# Install doom emacs
# emacs-28+ must be installed first
rm -rf ~/.config/emacs
rm -rf ~/.config/doom
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
yes | ~/.config/emacs/bin/doom install

# copy the config
mkdir -p ~/.config/doom/
cp doom-emacs/* ~/.config/doom/

# doom sync
~/.config/emacs/bin/doom sync
echo 'export PATH=$HOME/.config/emacs/bin:$PATH' >> ~/.zshrc
echo 'export PATH=$HOME/.config/emacs/bin:$PATH' >> ~/.bashrc
