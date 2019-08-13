#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
export CI=true
export TRAVIS=true
export CONTINUOUS_INTEGRATION=true
export USER=travis
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RAILS_ENV=test
export RACK_ENV=test
export MERB_ENV=test
export JRUBY_OPTS="--server -Dcext.enabled=false -Xcompile.invokedynamic=false"
apt-get update && apt-get install -y tzdata
gem install bundler -v 2.0.1
apt-get install chromium-chromedriver
# before_install
gem install bundler
# install
bundle install --jobs=3 --retry=3
# before_script
bundle exec rake alchemy:spec:prepare
export PATH=$PATH:/usr/lib/chromium-browser/
# script
bundle exec rspec
