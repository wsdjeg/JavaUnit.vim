package com.wsdjeg.mysqlvim;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLUtils {
    public static void getConnection(String username,String password)throws ClassNotFoundException,SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(MVRequest.BASEURL+"information_schema",username,password);
        System.out.println(conn != null);
    }
}
