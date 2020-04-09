package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 系统日志信息实体类
 */
public class TblSyslog {
    private Integer syslogid;
    private String operateor;
    private String operatetype;
    private String operatedetail;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date operatetime;
    private String operateresult;
    private String operateip;
    private String time1;
    private String time2;

    public TblSyslog() {
    }

    public TblSyslog(Integer syslogid, String operateor, String operatetype, String operatedetail, Date operatetime, String operateresult, String operateip) {
        this.syslogid = syslogid;
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

    public String getTime1() {
        return time1;
    }

    public void setTime1(String time1) {
        this.time1 = time1;
    }

    public String getTime2() {
        return time2;
    }

    public void setTime2(String time2) {
        this.time2 = time2;
    }

    @Override
    public String toString() {
        return "TblSyslog{" +
                "syslogid=" + syslogid +
                ", operateor='" + operateor + '\'' +
                ", operatetype='" + operatetype + '\'' +
                ", operatedetail='" + operatedetail + '\'' +
                ", operatetime=" + operatetime +
                ", operateresult='" + operateresult + '\'' +
                ", operateip='" + operateip + '\'' +
                ", time1='" + time1 + '\'' +
                ", time2='" + time2 + '\'' +
                '}';
    }
}
