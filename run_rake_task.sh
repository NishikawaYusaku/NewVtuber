#!/bin/bash

# RAILS_ENV が production かどうかで環境を判定
if [[ "$RAILS_ENV" == "production" ]]; then
  echo "[INFO] 本番環境モードで実行します (RAILS_ENV=production)"

  # rbenv のパスを通す（本番サーバのインストール場所に合わせる）
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # 本番アプリのディレクトリへ移動（Fly.ioの場合は /app が標準）
  cd /app || exit 1

else
  echo "[INFO] 開発環境モードで実行します (RAILS_ENV=$RAILS_ENV)"

  # macOS Homebrew + rbenv のパス設定
  export PATH="/opt/homebrew/bin:$HOME/.rbenv/bin:$PATH"
  eval "$(/opt/homebrew/bin/rbenv init -)"

  # ローカル開発ディレクトリへ移動
  cd /Users/saku/workspace/runteq/NewVtuber || exit 1
fi

# Rake タスク実行
bundle exec rake vtuber_youtube:update