# 生成日志文件
mkdir -p ~/php_project_log
touch ~/php_project_log/php_project_deploy.txt || exit
echo "------------------ 部署事件 ------------------" >> ~/php_project_log/php_project_deploy.txt
echo "部署时间:  `date '+%Y-%m-%d %H:%M:%S'`" >> ~/php_project_log/php_project_deploy.txt
echo "部署项目:  php_project" >> ~/php_project_log/php_project_deploy.txt

# 输入位置
cd /home/php_project

git checkout -b temp_branch >> ~/php_project_log/php_project_deploy.txt
git branch -D master >> ~/php_project_log/php_project_deploy.txt
git fetch origin master:master >> ~/php_project_log/php_project_deploy.txt
git checkout master >> ~/php_project_log/php_project_deploy.txt
git branch -D temp_branch >> ~/php_project_log/php_project_deploy.txt

echo "---------------------------------------------"
# 打印空格
emp = "\n"
for i in {1..4}
do
    echo $emp >> ~/php_project_log/php_project_deploy.txt
done
