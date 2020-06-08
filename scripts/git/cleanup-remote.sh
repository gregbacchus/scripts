set -e

git checkout master
git pull

git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin

git fetch --prune
