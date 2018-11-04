package com.wbg.logistics.util;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jmx.snmp.Timestamp;

import java.io.IOException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class DBUtil {
    public static String toJson(Object obj){
        String reuqest=null;
        //对象映射
        ObjectMapper mapper=new ObjectMapper();
        //设置时间格式
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        mapper.setDateFormat(dateFormat);
        try {
            reuqest=mapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return reuqest;
    }
    public static String toJsonyMd(Object obj){
        String reuqest=null;
        //对象映射
        ObjectMapper mapper=new ObjectMapper();
        //设置时间格式
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        mapper.setDateFormat(dateFormat);
        try {
            reuqest=mapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return reuqest;
    }
    public static <T> T toObject(String src,Class<T> valueType){
        T request=null;
        //对象反射
        ObjectMapper mapper=new ObjectMapper();
        try {
            request=mapper.readValue(src, valueType);
        } catch (JsonParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (JsonMappingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return request;
    }
    public static Timestamp date(String date_str) {
        try {
            Calendar zcal = Calendar.getInstance();//日期类
            Timestamp timestampnow = new Timestamp(zcal.getTimeInMillis());//转换成正常的日期格式
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");//改为需要的东西
            ParsePosition pos = new ParsePosition(0);
            java.util.Date current = formatter.parse(date_str, pos);
            timestampnow = new Timestamp(current.getTime());
            return timestampnow;
        }
        catch (NullPointerException e) {
            return null;
        }
    }
}
