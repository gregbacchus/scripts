git fetch --prune

git branch --merged |  grep -v '^\*' | grep -v 'master' | xargs git branch -d
