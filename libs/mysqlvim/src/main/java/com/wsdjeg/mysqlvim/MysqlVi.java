package com.wsdjeg.mysqlvim;
public class MysqlVi {
    public static void main(String[] args) {
        switch (args[0]) {
            case MVRequest.LOGIN:
                if (args.length==3) {
                    try {
                        //TODO
                    } catch(Exception e){
                        e.printStackTrace();
                    }
                }else{
                    //TODO
                }
                break;
            case MVRequest.LOGOUT:
                break;
            case MVRequest.USE:
                break;
        }
    }
}
