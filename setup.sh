#!/bin/sh
cd $(dirname $0)
for dotfile in .?*; do
    case $dotfile in
        *.elc)
            continue;;
        ..)
            continue;;
        .git)
            continue;;
        .gitconfig.local)
            continue;;
        .gitignore_gen)
            continue;;
        .gitfiles)
            continue;;
        .gitmodules)
            continue;;
        .ssh)
            continue;;
        .vim)
            continue;;
        .zsh)
            continue;;
        *)
            #ln -Fis "${PWD}/${dotfile}" $HOME
            ln -Fs "${HOME}/.dotfiles/${dotfile}" $HOME
            ;;
    esac
done

if [ ! -f ~/.gitconfig.local ]; then
    cp .gitconfig.local ~/
    echo 'cp .gitconfig.local ~/'
fi

ln -Fs "${PWD}/bin" $HOME

if [ ! -L ~/.oh-my-zsh ]; then
    #ln -Fis "${PWD}/modules/oh-my-zsh" "$HOME/.oh-my-zsh"
    ln -Fs "${HOME}/.dotfiles/modules/oh-my-zsh" "$HOME/.oh-my-zsh"
fi

if [ ! -L ~/.dotfiles ]; then
    ln -Fs ${PWD} "$HOME/.dotfiles"
fi

if [ ! -L ~/.dotfiles/.vim/bundle/neobundle.vim ]; then
    ln -Fs "$HOME/.dotfiles/modules/neobundle.vim" "$HOME/.dotfiles/.vim/bundle/neobundle.vim"
fi

git submodule init
git submodule update

vim -c ':NeoBundleInstall' -c ':q!' -c ':q!'

echo 'please edit ~/.gitconfig.local'
