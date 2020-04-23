package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 安保员信息实体类
 */
public class TblSecurity {

    private Integer securityid;
    private String securityname;
    private String securitypwd;
    private String securitysex;
    private Integer securityage;
    private String securityadd;
    private String securityphone;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date securityregtime;
    private String securitystatus;
    private Integer rid;
    private Integer kid;

    private String code;
    private String time1;
    private String time2;

    public TblSecurity() {
    }

    public TblSecurity(Integer securityid, String securityname, String securitypwd, String securitysex, Integer securityage, String securityadd, String securityphone, Date securityregtime, String securitystatus, Integer rid, Integer kid) {
        this.securityid = securityid;
        this.securityname = securityname;
        this.securitypwd = securitypwd;
        this.securitysex = securitysex;
        this.securityage = securityage;
        this.securityadd = securityadd;
        this.securityphone = securityphone;
        this.securityregtime = securityregtime;
        this.securitystatus = securitystatus;
        this.rid = rid;
        this.kid = kid;
    }

    public Integer getSecurityid() {
        return securityid;
    }

    public void setSecurityid(Integer securityid) {
        this.securityid = securityid;
    }

    public String getSecurityname() {
        return securityname;
    }

    public void setSecurityname(String securityname) {
        this.securityname = securityname;
    }

    public String getSecuritypwd() {
        return securitypwd;
    }

    public void setSecuritypwd(String securitypwd) {
        this.securitypwd = securitypwd;
    }

    public String getSecuritysex() {
        return securitysex;
    }

    public void setSecuritysex(String securitysex) {
        this.securitysex = securitysex;
    }

    public Integer getSecurityage() {
        return securityage;
    }

    public void setSecurityage(Integer securityage) {
        this.securityage = securityage;
    }

    public String getSecurityadd() {
        return securityadd;
    }

    public void setSecurityadd(String securityadd) {
        this.securityadd = securityadd;
    }

    public String getSecurityphone() {
        return securityphone;
    }

    public void setSecurityphone(String securityphone) {
        this.securityphone = securityphone;
    }

    public Date getSecurityregtime() {
        return securityregtime;
    }

    public void setSecurityregtime(Date securityregtime) {
        this.securityregtime = securityregtime;
    }

    public String getSecuritystatus() {
        return securitystatus;
    }

    public void setSecuritystatus(String securitystatus) {
        this.securitystatus = securitystatus;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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
        return "TblSecurity{" +
                "securityid=" + securityid +
                ", securityname='" + securityname + '\'' +
                ", securitypwd='" + securitypwd + '\'' +
                ", securitysex='" + securitysex + '\'' +
                ", securityage=" + securityage +
                ", securityadd='" + securityadd + '\'' +
                ", securityphone='" + securityphone + '\'' +
                ", securityregtime=" + securityregtime +
                ", securitystatus='" + securitystatus + '\'' +
                ", rid=" + rid +
                ", kid=" + kid +
                ", code='" + code + '\'' +
                ", time1='" + time1 + '\'' +
                ", time2='" + time2 + '\'' +
                '}';
    }
}
