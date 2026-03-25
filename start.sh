#!/bin/bash
# Easy VTA — Start script
export GEM_HOME=~/.rvm/gems/ruby-3.2.2
export GEM_PATH=~/.rvm/gems/ruby-3.2.2
export PATH=~/.rvm/rubies/ruby-3.2.2/bin:~/.rvm/gems/ruby-3.2.2/bin:$PATH

cd "$(dirname "$0")"
bundle exec rails server "$@"
