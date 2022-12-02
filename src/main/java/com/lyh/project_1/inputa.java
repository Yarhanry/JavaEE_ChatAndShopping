package com.lyh.project_1;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "inputa", value = "/inputa")
public class inputa extends HttpServlet {
    public String message = "";  // 存放聊天记录


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // 聊天时间显示
        Date time = new Date();
        SimpleDateFormat Format = new SimpleDateFormat("yy-MM-dd HH:mm");
        String format = "";
        format = Format.format(time);


        String input = request.getParameter("input");
        if (input != "") {
            String user = (String) request.getSession().getAttribute("sessions");   // 获取用户名
            message += user + ":   " + format + "\n     " + input + "\n\n";    // 获取当前聊天记录
            request.getServletContext().setAttribute("messages", message);  // 保存聊天记录
        }
        response.sendRedirect("chat.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}