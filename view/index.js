"use strict"
module.exports = function (data) {
  return `
  <html>
    <head>
      <title>web_hooks</title>
      <style>
        table{
          width: 100%;
           border-spacing:0px 5px;
        }
        td{
          width: 50%;
        }
        tr{
          width: 100%;
        }
        a{
          font-size: 18px;
          margin-right: 15px;
        }
        .container{
          margin: 0 auto;
          width: 800px;
        }
        h1{
          font-size:60px;
        }
      </style>
    <head>
    <body style="margin:0 auto;">
      <div class="container">
        <h1>Shell Files</h1>
        <a href='/log'></a>
          <table>
          `+ items(data)  +`
        </table>
      <div>
    <script>
      function go_href(method,param){
        var url = "";
        if(method=='delete'){
          url = "/delete?file_name="+param;
        }else if(method=='run'){
          url = "/run?file_name="+param;
        }
        if( confirm("Are you sure?") ){
          window.location.href = url;
        }
      }
    </script>
    </body>
  </html>
  `
}

function items(data) {
  var str = ""
  data.forEach(function(s,i){
    var t = `<tr style='background-color:${i%2==0?'#EAF2FE':'#F6F8FB'}'>
                <td>${s}</td>
                <td>
                  <a href='/detail?file_name=${s}'>detail</a>
                  <a href='#' onclick="go_href('run','${s}')">run</a>
                  <a href="#" onclick="go_href('delete','${s}')">del</a>
                </td>
              <tr/>`
    str += t
  });
  return str
}
