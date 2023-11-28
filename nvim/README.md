# LSP
Here is a list of all LSP dependencies needed to run configured language servers. Optionally, a helper script is available to install/update such dependencies:
```sh
./lsp-setup.sh
```

## lua
```sh
xbps-install luarocks-lua53 lua53-devel lua-language-server
```

## markdown
```sh
wget https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64 -O ~/.local/bin/marksman && \
    chmod +x ~/.local/bin/marksman
```

## c/c++
```sh
xbps-install clang-tools-extra Bear
```

## go
```sh
xbps-install gopls golangci-lint
go install github.com/nametake/golangci-lint-langserver@latest
```

Also, add *GOPATH* to your *PATH* environment variable.

## rust
```sh
xbps-install rust-analyzer rust-src
```
