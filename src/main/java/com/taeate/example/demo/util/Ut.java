package com.taeate.example.demo.util;

public class Ut {

    public static boolean empty(Object obj) {
       if (obj == null ) {
           return true;
       }
       if (obj instanceof String == false ) {
        return false;
        }

        String str = (String)obj;
        return str.trim().length() == 0;
    }

}
