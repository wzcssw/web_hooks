git checkout -b temp_branch
git branch -D master
git fetch origin master:master
git checkout master
git branch -D temp_branch
echo "some data for the file" >> '~/log/web_hooks_deploy.txt'
pm2 restart app.js
