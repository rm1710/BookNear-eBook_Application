package com.DB;

import java.sql.*;

public class DBconnect {

    private static Connection conn;

    public static Connection getconn() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebook-app", "root", "pass123");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

}
