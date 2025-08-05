#!/bin/bash

# rbenv のパスを通す
export PATH="/opt/homebrew/bin:$HOME/.rbenv/bin:$PATH"

# rbenv を初期化する
eval "$(/opt/homebrew/bin/rbenv init -)"

# アプリのディレクトリに移動
cd /Users/saku/workspace/runteq/NewVtuber

# Rake タスク実行
bundle exec rake vtuber_youtube:update