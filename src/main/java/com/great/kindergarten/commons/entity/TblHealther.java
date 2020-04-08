package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 *保健员信息实体类
 */
public class TblHealther {

   private Integer healtherid;
   private String healthername;
   private String healtherpwd;
   private String healthersex;
   private Integer healtherage;
   private String healtheradd;
   private String healtherphone;
   @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
   private Date healtherregtime;
   private String healtherstatus;
   private Integer rid;

   private String code;

    public TblHealther() {
    }

    public TblHealther(Integer healtherid, String healthername, String healtherpwd, String healthersex, Integer healtherage, String healtheradd, String healtherphone, Date healtherregtime, String healtherstatus, Integer rid) {
        this.healtherid = healtherid;
        this.healthername = healthername;
        this.healtherpwd = healtherpwd;
        this.healthersex = healthersex;
        this.healtherage = healtherage;
        this.healtheradd = healtheradd;
        this.healtherphone = healtherphone;
        this.healtherregtime = healtherregtime;
        this.healtherstatus = healtherstatus;
        this.rid = rid;
    }

    public Integer getHealtherid() {
        return healtherid;
    }

    public void setHealtherid(Integer healtherid) {
        this.healtherid = healtherid;
    }

    public String getHealthername() {
        return healthername;
    }

    public void setHealthername(String healthername) {
        this.healthername = healthername;
    }

    public String getHealtherpwd() {
        return healtherpwd;
    }

    public void setHealtherpwd(String healtherpwd) {
        this.healtherpwd = healtherpwd;
    }

    public String getHealthersex() {
        return healthersex;
    }

    public void setHealthersex(String healthersex) {
        this.healthersex = healthersex;
    }

    public Integer getHealtherage() {
        return healtherage;
    }

    public void setHealtherage(Integer healtherage) {
        this.healtherage = healtherage;
    }

    public String getHealtheradd() {
        return healtheradd;
    }

    public void setHealtheradd(String healtheradd) {
        this.healtheradd = healtheradd;
    }

    public String getHealtherphone() {
        return healtherphone;
    }

    public void setHealtherphone(String healtherphone) {
        this.healtherphone = healtherphone;
    }

    public Date getHealtherregtime() {
        return healtherregtime;
    }

    public void setHealtherregtime(Date healtherregtime) {
        this.healtherregtime = healtherregtime;
    }

    public String getHealtherstatus() {
        return healtherstatus;
    }

    public void setHealtherstatus(String healtherstatus) {
        this.healtherstatus = healtherstatus;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "TblHealther{" +
                "healtherid=" + healtherid +
                ", healthername='" + healthername + '\'' +
                ", healtherpwd='" + healtherpwd + '\'' +
                ", healthersex='" + healthersex + '\'' +
                ", healtherage=" + healtherage +
                ", healtheradd='" + healtheradd + '\'' +
                ", healtherphone='" + healtherphone + '\'' +
                ", healtherregtime=" + healtherregtime +
                ", healtherstatus='" + healtherstatus + '\'' +
                ", rid=" + rid +
                ", code='" + code + '\'' +
                '}';
    }
}
