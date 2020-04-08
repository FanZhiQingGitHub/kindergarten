package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 系统日志信息实体类
 */
public class TblSyslog {
    private Integer syslogid;
    private String uuid;
    private String operateor;
    private String operatetype;
    private String operatedetail;
    private Date operatetime;
    private String operateresult;
    private String operateip;

    public TblSyslog() {
    }

    public TblSyslog(Integer syslogid, String uuid, String operateor, String operatetype, String operatedetail, Date operatetime, String operateresult, String operateip) {
        this.syslogid = syslogid;
        this.uuid = uuid;
        this.operateor = operateor;
        this.operatetype = operatetype;
        this.operatedetail = operatedetail;
        this.operatetime = operatetime;
        this.operateresult = operateresult;
        this.operateip = operateip;
    }

    public Integer getSyslogid() {
        return syslogid;
    }

    public void setSyslogid(Integer syslogid) {
        this.syslogid = syslogid;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getOperateor() {
        return operateor;
    }

    public void setOperateor(String operateor) {
        this.operateor = operateor;
    }

    public String getOperatetype() {
        return operatetype;
    }

    public void setOperatetype(String operatetype) {
        this.operatetype = operatetype;
    }

    public String getOperatedetail() {
        return operatedetail;
    }

    public void setOperatedetail(String operatedetail) {
        this.operatedetail = operatedetail;
    }

    public Date getOperatetime() {
        return operatetime;
    }

    public void setOperatetime(Date operatetime) {
        this.operatetime = operatetime;
    }

    public String getOperateresult() {
        return operateresult;
    }

    public void setOperateresult(String operateresult) {
        this.operateresult = operateresult;
    }

    public String getOperateip() {
        return operateip;
    }

    public void setOperateip(String operateip) {
        this.operateip = operateip;
    }

    @Override
    public String toString() {
        return "TblSyslog{" +
                "syslogid=" + syslogid +
                ", uuid='" + uuid + '\'' +
                ", operateor='" + operateor + '\'' +
                ", operatetype='" + operatetype + '\'' +
                ", operatedetail='" + operatedetail + '\'' +
                ", operatetime=" + operatetime +
                ", operateresult='" + operateresult + '\'' +
                ", operateip='" + operateip + '\'' +
                '}';
    }
}
