#!/bin/bash

mkdir -p "$HOME/.config/nvim"
cp ./init.lua "$HOME/.config/nvim"
cp ./lazy-lock.json "$HOME/.config/nvim"
cp -r ./after "$HOME/.config/nvim"
cp -r ./colors "$HOME/.config/nvim"
cp -r ./lua "$HOME/.config/nvim"
cp -r ./plugin "$HOME/.config/nvim"
