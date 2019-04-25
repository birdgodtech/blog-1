.DELETE_ON_ERROR:

export BIN := $(shell npm bin)
PATH := $(BIN):$(PATH)
DIST = ./dist
BUILD = ./build
LIB = ./lib
TEST = ./test
MIN = $(DIST)/react-grid-layout.min.js
MIN_MAP = $(DIST)/react-grid-layout.min.js.map

.PHONY: build start deploy


build:
    hugo -t even

start:
    hugo server

deploy:
    # 部署到 github pages 脚本
    # 错误时终止脚本
    set -e

    # 删除打包文件夹
    rm -rf public

    # 打包。even 是主题
    hugo -t even # if using a theme, replace with `hugo -t <YOURTHEME>`

    # 进入打包文件夹
    cd public

    # Add changes to git.

    git init
    git add -A

    # Commit changes.
    msg="building site `date`"
    if [ $# -eq 1 ]
      then msg="$1"
    fi
    git commit -m "$msg"

    # 推送到githu
    # nusr.github.io 只能使用 master分支
    git push git@github.com:nusr/nusr.github.io.git master

    # 回到原文件夹
    cd ..
