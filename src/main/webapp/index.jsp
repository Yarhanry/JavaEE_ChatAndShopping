<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String username = "";
    String password = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals("cook")) {  // 检查是否为指定cookie
                username = cookies[i].getValue().split("-")[0];  // 保存用户输入的用户名
                password = cookies[i].getValue().split("-")[1];  // 保存用户输入的密码
                request.setAttribute("name", username);
                request.setAttribute("pwd", password);
            }
        }
    }
%>

<script type="text/javascript">
    function sub() {
        var username = loginCheck.username.value;
        var password = loginCheck.password.value;

        if (username == "") {
            alert("用户名不能为空！");
            return false;
        }
        else if (password == "") {
            alert("密码不能为空！");
            return false;
        }
        else
            return true;
    }
</script>

<!DOCTYPE html>
<html>

<head>
    <title>聊天购物系统</title>
    <link href="css/index.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="loginDiv">
<form name="loginCheck" action="Receive" method="post" onsubmit="return sub()">
    <h1 style="text-align: center;color: aliceblue; margin-top: 10px;">登&nbsp;&nbsp;陆</h1>
    <div>
        <p>用户名 :
            <input class="input0" type="text" placeholder="请输入用户名" name="username" value="${name}" />
        </p>
        <p>密&nbsp;&nbsp;&nbsp;码 :
            <input class="input0" type="password" placeholder="请输入密码" name="password" value="${pwd}" />
        </p>
        <div class="checkbox">
            <input type="checkbox" name="rem">&nbsp;&nbsp;记住密码1个月
        </div>
        <div>
            <input type="submit" value="登录" class="button1">
        </div>
        <div>
            <input type="reset" value="重置" class="button2">
        </div>
        <br>
        <div class="link">
            <a href="register.jsp" >
                &nbsp;&nbsp;---->用户注册
            </a>
        </div>
    </div>
</form>
</div>
</body>

</html>
