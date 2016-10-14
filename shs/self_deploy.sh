# 生成日志文件
mkdir -p ~/web_hooks_log
touch ~/web_hooks_log/web_hooks_deploy.txt || exit
echo "------------------ 部署事件 ------------------" >> ~/web_hooks_log/web_hooks_deploy.txt
echo "部署时间:  `date '+%Y-%m-%d %H:%M:%S'`" >> ~/web_hooks_log/web_hooks_deploy.txt
echo "部署项目:  web_hooks(本应用)" >> ~/web_hooks_log/web_hooks_deploy.txt

# 输入位置
git checkout -b temp_branch >> ~/web_hooks_log/web_hooks_deploy.txt
git branch -D master >> ~/web_hooks_log/web_hooks_deploy.txt
git fetch origin master:master >> ~/web_hooks_log/web_hooks_deploy.txt
git checkout master >> ~/web_hooks_log/web_hooks_deploy.txt
git branch -D temp_branch >> ~/web_hooks_log/web_hooks_deploy.txt
npm install >> ~/web_hooks_log/web_hooks_deploy.txt
pm2 delete app.js --name web_hooks >> ~/web_hooks_log/web_hooks_deploy.txt
pm2 start app.js --name web_hooks >> ~/web_hooks_log/web_hooks_deploy.txt

echo "---------------------------------------------"
# 打印空格
emp = "\n"
for i in {1..4}
do
    echo $emp >> ~/web_hooks_log/web_hooks_deploy.txt
done
