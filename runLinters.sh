#!/bin/bash
git fetch origin master:refs/remotes/origin/master

files_diff=$(git diff --diff-filter=ACMRTUXB --name-only origin/master... | xargs | sed "s/\\n/\\s/")

bundle exec rubocop --force-exclusion $files_diff
bundle exec reek -c .reek.yml --force-exclusion $files_diff
