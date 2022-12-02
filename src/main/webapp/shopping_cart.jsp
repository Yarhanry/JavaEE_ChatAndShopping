<%--
  Created by IntelliJ IDEA.
  User: hua'wei
  Date: 2022/11/16
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>


<jsp:useBean id="Goods" class="com.lyh.project_1.Goods" />
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
    String name = "";
    List lis = new ArrayList();  // 用来迭代的对象
    float price = 0;
    float sum = 0;
    int num = 0;
    boolean flag = false;  // 判断是否选购商品
    String[] nums = request.getParameterValues("buy");

    for (int i = 0; i < nums.length; i++) {
        if (!nums[i].equals("0")) {
            Goods.Select(i);  // 注意数据库中id要从0开始！！
            name = Goods.GetName();
            num = Integer.parseInt(nums[i]);
            price = Float.parseFloat(Goods.GetPrice());
            sum += num * price;
            flag = true;
            String[] liss = {name, Integer.toString(num), Float.toString(price), Float.toString(num*price)};
            lis.add(liss);
        }
    }
    request.setAttribute("lis", lis);  // ！！！！！很关键！！！调试了很久发现是忘记加这一步！！
    if (flag == false) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert(\"未选购商品！请重新选购！\");");
        out.println("</script>");
        response.setHeader("refresh", "1;URL=shopping.jsp");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>民大购物</title>
    <link href="css/shopping_cart.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="box">
    <svg t="1669710754655" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2664" width="200" height="200"><path d="M358.3 576m-240.4 0a240.4 240.4 0 1 0 480.8 0 240.4 240.4 0 1 0-480.8 0Z" fill="#106F4F" opacity=".3" p-id="2665"></path><path d="M883.1 552.8H325.8c-23.9 0-43.4-19.3-43.4-43v-311c0-11 9-20 20-20h3.2c1.3 0 2.6 0.1 3.9 0.4l33.1 6.5 549.1 108.8c20.3 3.9 35 21.7 35 42.2v173.1c-0.1 23.7-19.6 43-43.6 43zM322.3 222.5v287.3c0 1.6 1.6 3 3.4 3H883c1.9 0 3.5-1.4 3.5-3V336.6c0-1.4-1.1-2.6-2.6-2.9h-0.1l-549-108.8-12.5-2.4z" fill="#F75C3E" p-id="2666"></path><path d="M302.3 625.1c-11 0-20-9-20-20v-95.3c0-11 9-20 20-20s20 9 20 20v95.3c0 11-8.9 20-20 20z" fill="#F75C3E" p-id="2667"></path><path d="M302.3 626.4c-11 0-19.9-8.9-20-19.9-0.1-11 8.9-20 19.9-20.1l604.3-2.8h0.1c11 0 19.9 8.9 20 19.9 0.1 11-8.9 20-19.9 20.1l-604.4 2.8zM305.5 218.7c-1.6 0-3.1-0.2-4.7-0.6l-41-9.9c-10.7-2.6-17.3-13.4-14.8-24.1 2.6-10.7 13.4-17.3 24.1-14.8l41 9.9c10.7 2.6 17.3 13.4 14.8 24.1a19.92 19.92 0 0 1-19.4 15.4z" fill="#F75C3E" p-id="2668"></path><path d="M264.5 208.8h-0.4l-68-1.4c-11-0.2-19.8-9.4-19.6-20.4 0.2-10.9 9.1-19.6 20-19.6h0.4l68 1.4c11 0.2 19.8 9.4 19.6 20.4-0.3 10.9-9.2 19.6-20 19.6zM416.2 761.9c-37.7 0-68.3-30.6-68.3-68.3 0-37.7 30.6-68.3 68.3-68.3 37.7 0 68.3 30.6 68.3 68.3 0 37.6-30.6 68.3-68.3 68.3z m0-96.6c-15.6 0-28.3 12.7-28.3 28.3 0 15.6 12.7 28.3 28.3 28.3 15.6 0 28.3-12.7 28.3-28.3 0-15.6-12.7-28.3-28.3-28.3zM769.4 760.9c-3.4 0-6.8-0.2-10.2-0.8-37.2-5.6-63-40.4-57.4-77.7 2.7-18 12.3-33.9 27-44.8 14.7-10.8 32.7-15.3 50.7-12.6 18 2.7 33.9 12.3 44.8 27 10.8 14.7 15.3 32.7 12.6 50.7-5.1 33.8-34.3 58.2-67.5 58.2z m-0.1-96.6c-6 0-11.8 1.9-16.8 5.5-6.1 4.5-10 11.1-11.2 18.6-2.3 15.4 8.3 29.9 23.8 32.2 15.4 2.3 29.9-8.3 32.2-23.8 2.3-15.4-8.3-29.9-23.8-32.2-1.3-0.2-2.8-0.3-4.2-0.3z m47.8 35.5z" fill="#F75C3E" p-id="2669"></path></svg>
    <table align="center" class="imagetable">
        <thead>
            <tr>
                <th>商品名</th>
                <th>数量</th>
                <th>单价</th>
                <th>总价</th>
            </tr>
        </thead>
        <tbody>
    <c:forEach items="${lis}" var="li">
        <tr>
            <td>${li[0]}</td>
            <td>${li[1]}</td>
            <td>${li[2]}</td>
            <td>${li[3]}</td>
        </tr>
    </c:forEach>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td><%=sum%></td>
        </tr>
        </tbody>
    </table>
    <br>
    <botton class="button1"><a class="link"href="shopping.jsp">重新选购</a></botton>
    <br>
    <botton class="button2"><a class="link" href="LoginSuccess.jsp">返回系统首页</a></botton>
</div>
</body>

</html>

