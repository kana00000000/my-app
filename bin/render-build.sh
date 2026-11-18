#!/usr/bin/env bash
# エラーが出たらそこで止める
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate
