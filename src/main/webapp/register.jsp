<%--
  Created by IntelliJ IDEA.
  User: hua'wei
  Date: 2022/11/16
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    function subb() {
        var username = RegisterCheck.username.value;
        var password = RegisterCheck.password.value;
        var again = RegisterCheck.again.value;

        if (username == "") {
            alert("用户名不能为空！");
            return false;
        }
        else if (password == "") {
            alert("密码不能为空！");
            return false;
        }
        else if (again == "") {
            alert("请确认密码！");
            return false;
        }
        else if (password != again) {
            alert("密码不一致！请重新输入");
            return false;
        }
        else
            return true;
    }
</script>


<!DOCTYPE html>
<html>

<head>
    <title>用户注册</title>
    <link href="css/register.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="registerDiv">
<form name="RegisterCheck" action="reg_submit.jsp" method="post" onsubmit="return subb()">
    <h1 style="text-align: center;color: aliceblue; margin-bottom: 30px;">用户注册</h1>
    <p>用户名 :&nbsp;&nbsp;&nbsp;
        <input class="input0" type="text" placeholder="请输入用户名" name="username"/>
    </p>
    <p>密&nbsp;&nbsp;&nbsp;码 :&nbsp;&nbsp;&nbsp;
        <input class="input0" type="password" placeholder="请输入密码" name="password"/>
    </p>
    <p>密码确认:
        <input class="input0" type="password" placeholder="请再次输入确认密码" name="again"/>
    </p>
    <input name="button" type="submit" value="注册" class="button1">
    <input type="reset" value="重置" class="button2">
</form>
</div>
</body>

</html>
