package com.wbg.logistics.util;
public class R {
    public String toJson(){
        return DBUtil.toJson(this);
    }
    public String toJsonyMd(){
        return DBUtil.toJsonyMd(this);
    }
    private int code;
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public int getCount() {
        return count;
    }
    public void setCount(int count) {
        this.count = count;
    }
    public Object getData() {
        return data;
    }
    public void setData(Object data) {
        this.data = data;
    }
    public R() {
        super();
    }
    public R(int code, String msg, int count, Object data) {
        super();
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }
    @Override
    public String toString() {
        return "R [code=" + code + ", msg=" + msg + ", count=" + count + ", data=" + data + "]";
    }
    private String msg;
    private int count;
    private Object data;
}

