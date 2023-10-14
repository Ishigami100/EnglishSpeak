#!/bin/sh

# 既存のPumaプロセスを停止
if [ -f tmp/pids/server.pid ]; then
  echo "Stopping existing Puma server..."
  kill -s QUIT $(cat tmp/pids/server.pid)
  rm -f tmp/pids/server.pid
fi

# 新しいPumaサーバーを起動
echo "Starting Puma server..."
rails server
