package com.wsdjeg.util;

import java.lang.reflect.Method;

/**本类为java方法测试类,使用前需将需要测试的源文件编译成class文件,之后运行
 * java -cp [制定classpath,包括本测试类 以及源文件的] com.wsdjeg.util.TestMethod [待测试类全类名] [待测试方法名]
 *
 *
 */
public class TestMethod{
    public static void main(String[] args) {
        if(args.length == 2){
            testSpecifiedMethod(args[0],args[1]);
        }else if (args.length == 1) {
            testAllMethods(args[0]);
        }else if (args.length > 2){
            testMethods(args);
        }
    }
    public static void testAllMethods(String className){
        Class<?> clazz = null;
        try {
            clazz = Class.forName(className);
        } catch(Exception e){
            e.printStackTrace();
        }
        Method[] mds = clazz.getMethods();
        for (int i = 1; i < mds.length; i++) {
            if (mds[i].getName().startsWith("test")) {
                testSpecifiedMethod(className,mds[i].getName());
            }
        }
    }
    public static void testMethods(String[] args) {
        for (int i = 1; i < args.length; i++) {
            testSpecifiedMethod(args[0],args[i]);
        }
    }
    @SuppressWarnings("unchecked")
    public static void testSpecifiedMethod(String className,String methodName){
        try{
            System.out.println("startting : className:" + className + " methodName :"+ methodName + "()" );
            System.out.println("result:");
            Class<?> clazz = Class.forName(className);
            clazz.getMethod(methodName).invoke(clazz.newInstance());
            System.out.println("success!");
        }catch(Exception e){
            System.out.println("fail!");
            e.printStackTrace();
        }
    }
}
