mv .git_local .git
git add -A
git commit -m "Publishing to Stage"
git push stage master
mv .git .git_local
