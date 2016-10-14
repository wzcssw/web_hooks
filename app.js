"use strict"
let app = require('koa')()
let path = require('path')
let static_cache = require('koa-static-cache')
var execProcess = require("./exec_process.js");
let body = require('koa-body')
let config = require('./config')

// 处理post参数(this.request.body)
app.use(body({formidable:{uploadDir: __dirname}}));
// web-hooks
app.use(function *(next){
  if(this.request.method=="POST" && this.path=="/web_hooks"){
    console.log(this.request.body);
    if(this.request.body.ref == 'refs/heads/master'){ //master分支时
      execProcess.result("sh auto_deploy.sh", function(err, response){
    		if(!err){
    			console.log("部署完毕");
    		}else {
           console.log("脚本执行错误");// error
    		}
    	});
    }
    this.body = "OK"
    return
  }
});
// 默认路径
app.use(function *(next){
  console.log(this.request.method=="POST");
  if(this.path=="/")
    this.path = config.index
  yield next;
});
// 缓存
app.use(static_cache(path.join(__dirname, config.root_dir), {
  maxAge: config.max_storage_age
}))
// 启动
app.listen(config.default_port)
