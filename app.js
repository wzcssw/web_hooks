"use strict"
let app = require('koa')()
let execProcess = require("./exec_process.js");
let body = require('koa-body')
let path = require('path')
let fs = require("fs")
let config = require('./config')
let view = require('./view')

//  2017-07-11

// 处理post参数(this.request.body)
app.use(body({formidable:{uploadDir: __dirname}}));

app.use(function *(next){// for Github post api
  if(this.request.method=="POST"&& this.path == '/'){
    var file_name = this.query.file_name
    if(this.request.body.ref == 'refs/heads/master'){ //master分支时
      exec_sh(file_name)        // 执行脚本
      this.body = "OK"
    }else if(this.query.file_name == "php_project_deploy.sh"){
      exec_sh(file_name)  
      this.body = "php_project_deploy.sh 部署"
    }else{
      this.body = "看看代码吧"
    }
  }else{
    yield next
  }
});

app.use(function *(next){//
  if(this.request.method == "GET" && this.path == '/'){
    var shs = fs.readdirSync('shs') // 脚本文件列表
    this.body = view(shs)
  }else if(this.request.method == "GET" && this.path == '/run'){//  执行脚本
    var file_name = this.query.file_name
    exec_sh(file_name)    // 执行脚本
    this.body = "start.."
  }else if(this.request.method == "GET" && this.path == '/detail'){// 脚本文件详情
    this.body = fs.readFileSync('shs/'+this.query.file_name).toString()
  }else if(this.request.method == "GET" && this.path == '/log'){// 脚本文件详情
    this.body = fs.readFileSync('/root/web_hooks_log/web_hooks_deploy.txt').toString()
  }else if(this.request.method == "GET" && this.path == '/delete'){// 删除脚本文件
    fs.unlinkSync('shs/'+this.query.file_name)
    var shs = fs.readdirSync('shs') // 脚本文件列表
    this.body = view(shs)
  }else{
    yield next
  }
});

function exec_sh(project) {
  execProcess.result("sh shs/"+project, function(err, response){
    console.log(!err ? response:"--  deploy faild  --");
  });
}

// 启动
app.listen(config.default_port)
