#!/bin/sh

set -Ceu


echo "> Synchronizing repository index..."
doas xbps-install -S
printf "\n"


# lua
echo "> Installing/updating lua dependencies..."
doas xbps-install -yu luarocks-lua53 lua53-devel lua-language-server
printf "\n"

## markdown
echo "> Installing/updating markdown dependencies..."
wget https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 -O ~/.local/bin/marksman && \
    chmod +x ~/.local/bin/marksman
printf "\n"

## c/c++
echo "> Installing/updating c/c++ dependencies..."
doas xbps-install -yu clang-tools-extra Bear
printf "\n"

## go
echo "> Installing/updating go dependencies..."
doas xbps-install -yu gopls golangci-lint
go install github.com/nametake/golangci-lint-langserver@latest
printf "\n"

## rust
echo "> Installing/updating rust dependencies..."
doas xbps-install -yu rust-analyzer rust-src
printf "\n"


echo "> Done."
