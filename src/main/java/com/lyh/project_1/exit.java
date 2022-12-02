package com.lyh.project_1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

@WebServlet(name = "exit", value = "/exit")
public class exit extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

//        System.out.println("你被触发了");
        String people = (String) request.getSession().getAttribute("sessions");
        String nameList = (String) request.getServletContext().getAttribute("nameList"); // 获取已经登陆过的用户名
        String[] arrName = nameList.split("-");
        String str = "";  // 千万不能赋值为null,后期也会当作字符串一并连接上的！！！！！！
        for (int i = 0; i < arrName.length; i++) {  // 删除退出的用户
            if ((arrName[i].equals(people))) {
                arrName[i] = arrName[arrName.length - 1];
                arrName = Arrays.copyOf(arrName,arrName.length - 1);
                break;
            }
        }
        for (int i = 0; i < arrName.length; i++) {  // 重新拼接
            str += arrName[i] + "-";
        }
        if (!(str.equals(""))) {
            request.getServletContext().setAttribute("nameList", str.substring(0, str.length() - 1));  // 去掉最后一个“-”
        } else {
            request.getServletContext().setAttribute("nameList", str);
        }
        request.getSession().invalidate();  // 注销Session中的信息
        response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}