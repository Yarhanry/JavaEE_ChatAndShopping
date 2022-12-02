package com.lyh.project_1;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.*;



@WebListener()
public class Listener_online implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent e) {
//        System.out.println("有人来了");
        String nameList = (String) e.getSession().getServletContext().getAttribute("nameList"); // 获取已经登陆过的用户名
        if (nameList != null) {
            String[] arrName = nameList.split("-");
            int people = arrName.length;
             String online = String.valueOf(people);
            e.getSession().getServletContext().setAttribute("online", online);
        }
    }


    @Override
        // 防止有用户没有点击退出聊天室而是直接关闭浏览器，设置了session的有效时长
    public void sessionDestroyed (HttpSessionEvent e) {
//        System.out.println("有人走了");
        String nameList = (String) e.getSession().getServletContext().getAttribute("nameList"); // 获取已经登陆过的用户名
        String[] arrName = nameList.split("-");
        int num = arrName.length;
        String online = String.valueOf(num);
        e.getSession().getServletContext().setAttribute("online", online);
    }
}

