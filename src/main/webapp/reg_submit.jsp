<%--
  Created by IntelliJ IDEA.
  User: hua'wei
  Date: 2022/11/16
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.lyh.project_1.Database" %>
<%@ page import="java.io.PrintWriter" %>


<jsp:useBean id="DB" class="com.lyh.project_1.Database" />
<%
    request.setCharacterEncoding("UTF-8");  // ！！！！！！否则传回给数据库的会是乱码
    String username = request.getParameter("username");  // 获取表单数据
    String password = request.getParameter("password");

    Database db = new Database();
    db.Connect();
    String sql = "SELECT * FROM user WHERE username = '" + username + "'";
    ResultSet res = db.Query(sql);
    try {
        if (!res.next()) {                           // 如果WHERE中的条件满足，返回true，否则返回false,先判断用户是否存在
            String sql2 = "INSERT INTO user values(null,'" + username + "'," + "'" + password + "'" +");";  // 第一列属性值为null,因为我设置第一列属性为自增
            int num = db.Update(sql2);  // 执行插入语句，返回的是修改的行数
            out.println("<script type=\"text/javascript\">");
            out.println("alert(\"注册成功！\");");
            out.println("</script>");
            response.setHeader("refresh", "1;URL=index.jsp");
//            response.sendRedirect("index.jsp");    //  不会有弹框出现
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert(\"用户名已存在！请重新注册！\");");
            out.println("</script>");
            response.setHeader("refresh", "1;URL=register.jsp");
//            response.sendRedirect("register.jsp");
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    db.DB_close(res);

%>

