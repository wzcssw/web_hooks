# 生成日志文件
mkdir -p ~/web_hooks_log
touch ~/web_hooks_log/web_hooks_deploy.txt || exit
echo "------------------ 部署事件 ------------------" >> ~/web_hooks_log/web_hooks_deploy.txt
echo "部署时间:  `date '+%Y-%m-%d %H:%M:%S'`" >> ~/web_hooks_log/web_hooks_deploy.txt
echo "部署项目:  static_files" >> ~/web_hooks_log/web_hooks_deploy.txt

###
rm -rf /home/statics_server/public  >> ~/web_hooks_log/web_hooks_deploy.txt
mkdir /home/statics_server/public
cd /home/static_files

git checkout -b temp_branch >> ~/web_hooks_log/web_hooks_deploy.txt
git branch -D master >> ~/web_hooks_log/web_hooks_deploy.txt
git fetch origin master:master >> ~/web_hooks_log/web_hooks_deploy.txt
git checkout master >> ~/web_hooks_log/web_hooks_deploy.txt
git branch -D temp_branch >> ~/web_hooks_log/web_hooks_deploy.txt

cp -R /home/static_files/* /home/statics_server/public  >> ~/web_hooks_log/web_hooks_deploy.txt
rm -rf /home/statics_server/public/.git
cd /home/statics_server  >> ~/web_hooks_log/web_hooks_deploy.txt
git add .  >> ~/web_hooks_log/web_hooks_deploy.txt
git commit -m 'deploy static_files' >> ~/web_hooks_log/web_hooks_deploy.txt
npm install >> ~/web_hooks_log/web_hooks_deploy.txt
pm2 restart app.js --name statics_server >> ~/web_hooks_log/web_hooks_deploy.txt
###

echo "---------------------------------------------"
# 打印空格
emp = "\n"
for i in {1..4}
do
    echo $emp >> ~/web_hooks_log/web_hooks_deploy.txt
done
