git branch --merged | grep -v '^[* ] master$' | xargs git branch -d
