package com.wsdjeg.mysqlvim;

import com.wsdjeg.mysqlvim.SQLUtils;

public class TestSQLUtils {
    public void testGetConnection(){
        try {
            
            SQLUtils.getConnection("root","1234");
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
