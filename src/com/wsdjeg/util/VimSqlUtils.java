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

            }
            else if (args[0].equals("createdatabase")&&args.length==4){
                System.out.println(createDatabase(args[1],args[2],args[3]));

            }
            else if (args[0].equals("dropdatabase")&&args.length==4){
                System.out.println(dropDatabase(args[1],args[2],args[3]));
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
    public static boolean useDatabase(String databaseName,String username,String password)throws IOException,SQLException,ClassNotFoundException{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/information_schema",username,password);
        String sql = "SELECT SCHEMA_NAME from SCHEMATA where schema_name = '" + databaseName + "';";
        Statement s=conn.createStatement();
        ResultSet resultSet=s.executeQuery(sql);
        if (resultSet.next()){
            conn.close();
            resultSet.close();
            return true;
        }
        conn.close();
        resultSet.close();
        return false;
    }
    public static boolean createDatabase(String databaseName,String username,String password)throws SQLException,IOException,ClassNotFoundException{
        String sql = "CREATE DATABASE IF NOT EXISTS `" + databaseName + "` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci";
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/?user="+username+"&password="+password);
        Statement s=conn.createStatement();
        s.executeUpdate(sql);
        conn.close();
        return useDatabase(databaseName,username,password);
    }
    public static boolean dropDatabase(String databaseName,String username,String password)throws SQLException,IOException,ClassNotFoundException{
        String sql = "drop database `" + databaseName + "`";
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/?user="+username+"&password="+password);
        Statement s=conn.createStatement();
        s.executeUpdate(sql);
        conn.close();
        return !useDatabase(databaseName,username,password);

    }
}
