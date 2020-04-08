package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 提交作业信息表实体类
 */
public class TblWork {
    private Integer workid;
    private String workname;
    private String workdetail;
    private Date worktime;
    private String workresult;
    private String workeva;

    public TblWork() {
    }

    public TblWork(Integer workid, String workname, String workdetail, Date worktime, String workresult, String workeva) {
        this.workid = workid;
        this.workname = workname;
        this.workdetail = workdetail;
        this.worktime = worktime;
        this.workresult = workresult;
        this.workeva = workeva;
    }

    public Integer getWorkid() {
        return workid;
    }

    public void setWorkid(Integer workid) {
        this.workid = workid;
    }

    public String getWorkname() {
        return workname;
    }

    public void setWorkname(String workname) {
        this.workname = workname;
    }

    public String getWorkdetail() {
        return workdetail;
    }

    public void setWorkdetail(String workdetail) {
        this.workdetail = workdetail;
    }

    public Date getWorktime() {
        return worktime;
    }

    public void setWorktime(Date worktime) {
        this.worktime = worktime;
    }

    public String getWorkresult() {
        return workresult;
    }

    public void setWorkresult(String workresult) {
        this.workresult = workresult;
    }

    public String getWorkeva() {
        return workeva;
    }

    public void setWorkeva(String workeva) {
        this.workeva = workeva;
    }

    @Override
    public String toString() {
        return "TblWork{" +
                "workid=" + workid +
                ", workname='" + workname + '\'' +
                ", workdetail='" + workdetail + '\'' +
                ", worktime=" + worktime +
                ", workresult='" + workresult + '\'' +
                ", workeva='" + workeva + '\'' +
                '}';
    }
}
