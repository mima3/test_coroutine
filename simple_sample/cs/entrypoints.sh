#!/bin/sh
set -eu

TOOLS=/root/.dotnet/tools

# 初回だけインストール
if [ ! -x "$TOOLS/dotnet-script" ]; then
  dotnet tool install -g dotnet-script
fi

# PATH 通す
export PATH="$PATH:$TOOLS"

# 以降のコマンドに制御を渡す（例: bash）
exec "$@"
