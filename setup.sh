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
        *)
            ln -Fis "${PWD}/${dotfile}" $HOME
            ;;
    esac
done

cp .gitconfig.local ~/
