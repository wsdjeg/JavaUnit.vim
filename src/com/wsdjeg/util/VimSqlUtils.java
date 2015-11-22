package com.wsdjeg.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class VimSqlUtils {
    public static void main(String[] args) {
        try {
            if(args[0].equals("getconnection")&&args.length==3){
                System.out.println(getConnection(args[1],args[2]));
            }
            else if (args[0].equals("usedatabase")&&args.length==4){
                System.out.println(useDatabase(args[1],args[2],args[3]));
            }else{
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }
    public static boolean getConnection(String username,String password) throws IOException,SQLException,ClassNotFoundException{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/information_schema",username,password);
        return conn != null;
    }
    public static void test() throws IOException,SQLException,ClassNotFoundException{
        System.out.println(getConnection("root","1234"));
    }
    public static boolean useDatabase(String databaseName,String username,String password)throws IOException,SQLException,ClassNotFoundException{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/information_schema",username,password);
        String sql = "SELECT SCHEMA_NAME from SCHEMATA where schema_name = '" + databaseName + "';";
        Statement s=conn.createStatement();
        ResultSet resultSet=s.executeQuery(sql);
        return resultSet.next();
    }
}
