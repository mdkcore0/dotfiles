# LSP

## lua
```shell
xbps-install luarocks-lua53 lua53-devel lua-language-server
```

## markdown
```shell
wget https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux -O ~/.local/bin/marksman && chmod +x ~/.local/bin/marksman
```

## c/c++
```shell
xbps-install clang-tools-extra Bear
```

## go
```sh
xbps-install gopls golangci-lint
go install github.com/nametake/golangci-lint-langserver@latest
```

Also, add *GOPATH* to your *PATH* environment variable.
