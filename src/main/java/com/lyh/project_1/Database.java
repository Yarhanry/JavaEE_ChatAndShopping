package com.lyh.project_1;

import java.sql.*;


public class Database {

    private String url = "jdbc:mysql://localhost:3306/" + "shopping_system";
    private String user = "root"; // 数据库用户名
    private String pwd = "你的数据库密码"; // 数据库密码
    private Connection con = null;
    private ResultSet rs = null;
    private Statement state = null;


    public Connection Connect() {  // 建立数据库的连接
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // 加载驱动
        } catch (ClassNotFoundException e) {
            System.out.println("加载驱动失败");
            System.out.println(e);
        }
        try {
            con = DriverManager.getConnection(url, user, pwd);
        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }


    public ResultSet Query(String sql) {  // 用于表查询
        try {
            Database db = new Database();
            con = db.Connect();
            state = con.createStatement();
            rs = state.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rs;
    }


    public int Update(String sql) {  // 用于表的增删改
        int result = 0;
        try {
            result = state.executeUpdate(sql);
        } catch (SQLException e) {
            System.out.println(e);
        }
        return result;
    }


    public void DB_close(ResultSet Res) {
        if (Res != null) {
            try {
                if (Res != null) {
                    Res.close();
                }
                if (state != null) {
                    state.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }
}