git branch --merged | grep -v '(^\*|master|dev)' | xargs git branch -d
