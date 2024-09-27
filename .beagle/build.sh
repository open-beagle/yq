.language:.beagle/build.sh
#!/bin/bash

set -ex

git config --global --add safe.directory $PWD

mkdir -p tmp

export CGO_ENABLED=0

# 获取当前 Git 提交和描述
export GIT_COMMIT=$(git rev-parse --short HEAD)
export GIT_DESCRIBE=$(git describe --tags --always)

# 设置链接标志
LDFLAGS="-s -w -X main.GitCommit=${GIT_COMMIT} -X main.GitDescribe=${GIT_DESCRIBE}"

export GOARCH=amd64
go build --ldflags "${LDFLAGS}" -o tmp/yq-linux-$GOARCH

export GOARCH=arm64
go build --ldflags "${LDFLAGS}" -o tmp/yq-linux-$GOARCH
