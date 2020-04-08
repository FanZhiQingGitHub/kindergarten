package com.great.kindergarten.commons.entity;

import java.io.Serializable;

/**
 * @author Administrator
 * @description：操作结果集
 */
public class Result implements Serializable {

    public static final int SUCCESS = 1;
    public static final int FAILURE = -1;

    private static final long serialVersionUID = 5576237395711742681L;

    private boolean success = false;

    private String msg = "";

    private Object data = null;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData()
    {
        return data;
    }

    public void setData(Object data)
    {
        this.data = data;
    }

    @Override
    public String toString()
    {
        return "Result{" + "success=" + success + ", msg='" + msg + '\'' + ", data=" + data + '}';
    }
}
