git checkout -b temp_branch
git branch -D master
git fetch origin master:master
git checkout master
git branch -D temp_branch
pm2 restart app.js
echo "some data for the file" >> 'log/deploy.txt'
