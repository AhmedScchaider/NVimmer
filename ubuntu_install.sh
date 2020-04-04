#!/bin/bash

echo " _   ___     ___                               "
echo "| \\ | \\ \\   / (_)_ __ ___  _ __ ___   ___ _ __ "
echo "|  \\| |\\ \\ / /| | '_ \` _ \\| '_ \` _ \\ / _ \\ '__|"
echo "| |\\  | \\ V / | | | | | | | | | | | |  __/ |   "
echo "|_| \\_|  \\_/  |_|_| |_| |_|_| |_| |_|\\___|_|"

echo "Welcome to NVimmer, Make your NeoVim/Vim perform as IDE"
echo "Email: devilyouwei@gmail.com"
echo "Waiting for installing, 3 seconds..."

sleep 3

echo "Check snap------------------------------------------------"
(snap --version)
status=$?
if [ "$status" != 0 ]; then
    echo "Install Snap..."
    (sudo apt install snapd)
fi

echo "Check NeoVim----------------------------------------------"
(nvim -v)
status=$?
if [ "$status" -eq 0 ]; then
    echo "NeoVim found, next step..."
else
    echo "Install NeoVim..."
    (sudo snap install --beta nvim --classic)
fi

echo "Check Node.js---------------------------------------------"
(node -v)
status=$?
if [ "$status" -eq 0 ]; then
    echo "NodeJS found, next step..."
else
    echo "Install Node.js..."
    (sudo snap install node --classic)
fi

echo "Install ESLint--------------------------------------------"
(eslint -v)
status=$?
if [ "$status" -eq 0 ]; then
    echo "ESlint found, next step..."
else
    echo "Instal eslint..."
    (npm -g install eslint)
fi
npm -g install neovim

echo "Install Astyle--------------------------------------------"
sudo apt install astyle

echo "Install Ctags---------------------------------------------"
sudo apt install ctags

echo "Install the other formatters------------------------------"
sudo apt install clang-format
sudo snap install shfmt

echo "Copy and Config Your NeoVim-------------------------------"
cp -rf ./nvim ~/.config/
cp ./.eslintrc.json ~/
cp ./.prettierrc.json ~/

echo "Install vim-plug------------------------------------------"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c PlugInstall
