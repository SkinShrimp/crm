<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>叩丁狼客户管理系统->用户登录</title>
    <link rel="stylesheet" href="/static/css/core.css" type="text/css" />
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css">
    <script src="/static/js/jquery-2.1.4.min.js"></script>
    <script src="/static/bootstrap/js/bootstrap.js"></script>
    <style type="text/css">
        body{
            background-color:  #FFFFFF;
        }
        .cm-container{
            margin-top: 160px;
        }
        .login {
            width: 360px;
            height: 300px;
            margin: 0px auto;
        }
    </style>


    <script type="text/javascript">
        $(function(){
            $("#btn_submit").click(function () {
                $.post("/login", $("#loginForm").serialize(), function (data) {
                    if(data.success){
                        window.location.href="/department/list";
                    }else{
                        alert(data.msg);
                    }
                })
            })
        });
    </script>

</head>
<body>
<div class="container cm-container">
    <h3 class="text-center"><font style="color: #337ab7;">叩丁狼客户管理系统(系统管理平台)</font></h3>
    <hr />
    <div class="login">
        <form id="loginForm" action="/login" method="post">
            <div class="form-group form-group-lg">
                <div class="input-group">
                    <div class="input-group-addon">用户名</div>
                    <input class="form-control" name="name"  value="admin"/>
                </div>
            </div>
            <div class="form-group form-group-lg">
                <div class="input-group">
                    <div class="input-group-addon">密&emsp;码</div>
                    <input class="form-control" name="password" type="password" value="1"/>
                </div>
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-lg btn-primary btn-block" id="btn_submit">登录</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>