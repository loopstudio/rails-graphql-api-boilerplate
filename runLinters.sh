#!/bin/bash
files_diff=$(git diff --diff-filter=ACMRTUXB --name-only origin/master... | xargs | sed "s/\\n/\\s/")

echo $files_diff

bundle exec rubocop --force-exclusion $files_diff
bundle exec reek --force-exclusion -c .reek.yml $files_diff
