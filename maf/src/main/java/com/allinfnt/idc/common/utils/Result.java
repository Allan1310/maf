package com.allinfnt.idc.common.utils;

public class Result {

    private boolean success = true;
    private String  errorstr;
    private int     errorcode;

    private Object  data;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getErrorstr() {
        return errorstr;
    }

    public void setErrorstr(String errorstr) {
        this.errorstr = errorstr;
    }

    public int getErrorcode() {
        return errorcode;
    }

    public void setErrorcode(int errorcode) {
        this.errorcode = errorcode;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

}
