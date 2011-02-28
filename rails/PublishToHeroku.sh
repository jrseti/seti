mv .git_local .git
git add -A
git commit -m "Publishing to Heroku Test"
git push heroku-test master
mv .git .git_local
