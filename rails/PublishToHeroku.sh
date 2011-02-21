mv .git_local .git
git add -A
git commit -m "Publishing to Heroku"
git push heroku master
mv .git .git_local
