package com.lyh.project_1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;


@WebServlet(name = "Receive", value = "/Receive")
public class Receive extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");  // 获取表单数据
        String password = request.getParameter("password");
        String rem = request.getParameter("rem");
        PrintWriter out = response.getWriter();

        System.out.println(username);

        Cookie cookie = null;
        Cookie[] cookies = request.getCookies();  // 获取请求相关的cookie
        if (cookies != null) {
            for (int i= 0; i< cookies.length; i++) {
                if (cookies[i].getName().equals("cook")) {  // 判断是否已经有此Cookie
                    cookie = cookies[i];
                }
            }
        }
        if (cookie == null) {  // 没有就new一个
            cookie = new Cookie("cook", username + "-" + password);  // 构造Cookie对象
        }

        //  验证用户和密码分别是否为该同学的姓名和学号
        boolean flag = false;  // 判断用户是否登陆成功
        boolean again = false;  // 判断用户是否重复登陆
        Database db = new Database();
        db.Connect();
        String sql = " SELECT * FROM user WHERE username = '" + username + "' and pwd = '" + password + "'";
        ResultSet res = db.Query(sql);  // 执行查询语句
        try {
            if (res.next()) {                           // 如果WHERE中的条件满足，返回true，否则返回false
                flag = true;
                String nameList = (String) request.getServletContext().getAttribute("nameList"); // 获取已经登陆过的用户名
                if (nameList == null) {
                    nameList = username;
                    request.getServletContext().setAttribute("nameList", nameList);
                } else {
                    String[] arrName = nameList.split("-");
                    for (int j = 0; j < arrName.length; ++j) {
                        if (arrName[j].equals(username)) {  // ！！！！！注意不能直接==，java里面字符串直接相等比较比较的是地址！！
//                            response.sendRedirect("loginAgain.html");  // 不可取，重定向后后面的代码会接着执行，直接设置flag参数就好
                            flag = false;  // 用户重复登陆，登陆失败
                            again = true;
                            break;
                        }
                    }
                    if (again != true) {
                        nameList = nameList + "-" + username;
                        request.getServletContext().setAttribute("nameList", nameList);
                    }
                }
                if (rem != null) {
                    cookie.setMaxAge(30 * 24 * 60 * 60);  // 设置过期时间(一个月)
                } else {
                    cookie.setMaxAge(0);
                }
                response.addCookie(cookie);  // 保存cookie
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        db.DB_close(res);

        if (flag) {
            request.getSession().invalidate();  // 打开页面登录的时候，session就会创建，要先把原来的销毁，创建一个新的，监听程序才能执行
            HttpSession s = request.getSession();
            s.setAttribute("sessions", username);  // 将用户名保存到session中(服务器端);
            response.sendRedirect("LoginSuccess.jsp");  // 重定向到相关页面
        } else {
            if (again) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert(\"该用户已登录，不可重复登陆！\");");
                out.println("</script>");
//                response.sendRedirect("index.jsp");
                response.setHeader("refresh", "1;URL=index.jsp");
            } else {
                response.sendRedirect("LoginFail.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
