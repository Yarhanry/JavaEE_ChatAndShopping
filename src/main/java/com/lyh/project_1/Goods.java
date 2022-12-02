package com.lyh.project_1;


import java.sql.ResultSet;
import java.sql.SQLException;


public class Goods {
    private String item = "";
    private String price = "";

    public void Select(int id) {
        Database db = new Database();
        db.Connect();
        String sql = "SELECT item,price FROM goods WHERE id = '" + id + "'" ;
        ResultSet res = null;
        try {
            res = db.Query(sql);
            while (res.next()) {
                item = res.getString("item");
                price = res.getString("price");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            db.DB_close(res);
        }
    }

    public String GetName() {
        return item;
    }

    public String GetPrice() {
        return price;
    }
}