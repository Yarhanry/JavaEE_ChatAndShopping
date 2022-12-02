package com.lyh.project_1;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class Filter_people implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest Request, ServletResponse Response, FilterChain chain) throws IOException, ServletException {


        // 首先看session是否存在(已登录)，如果存在，便直接doFilter
        // 如果未登录，则看一下请求的资源路径，如果是登陆界面，便doFilter，如果是聊天或购物界面，查看来访路径，如果是来自登陆页面，则doFilter


        HttpServletRequest request = (HttpServletRequest) Request;
        HttpServletResponse response = (HttpServletResponse) Response;
        HttpSession session = request.getSession();
        Object user = session.getAttribute("sessions");
        if (user != null) {
            chain.doFilter(Request,Response);
        } else {
            String requesturi = request.getRequestURI();
            if (requesturi.equals("/project_1_war_exploded/index.jsp") || requesturi.equals("/project_1_war_exploded/")){
                chain.doFilter(Request,Response);
            } else {
                String referer = request.getHeader("Referer");
                if (referer == null) {  // 如果是直接输入url，rederer是null,要单独判断，不然会报错，null不可以用split()
                    response.sendRedirect("index.jsp");
                }
                else if (referer.split("/")[3].equals("project_1_war_exploded")){
                    chain.doFilter(Request,Response);
                }
            }
        }
    }


    public void destroy() {

    }
}
