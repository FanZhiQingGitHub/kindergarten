package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

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
   @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
   @DateTimeFormat(pattern ="yyyy-MM-dd")
   private Date healtherregtime;
   private String healtherstatus;
   private Integer rid;

   private Integer kid;

   //连表查询用
   private TblKinder tblKinder;
   private Integer kinderid;
   private String kindername;
   private String code;
   private String time1;
   private String time2;

    public TblHealther() {
    }

    public TblHealther(Integer healtherid, String healthername, String healtherpwd, String healthersex, Integer healtherage, String healtheradd, String healtherphone, Date healtherregtime, String healtherstatus, Integer rid,Integer kid) {
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
        this.kid = kid;
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

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    public TblKinder getTblKinder() {
        return tblKinder;
    }

    public void setTblKinder(TblKinder tblKinder) {
        this.tblKinder = tblKinder;
    }

    public Integer getKinderid() {
        return kinderid;
    }

    public void setKinderid(Integer kinderid) {
        this.kinderid = kinderid;
    }

    public String getKindername() {
        return kindername;
    }

    public void setKindername(String kindername) {
        this.kindername = kindername;
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
                ", kid=" + kid +
                ", tblKinder=" + tblKinder +
                ", kinderid=" + kinderid +
                ", kindername='" + kindername + '\'' +
                ", code='" + code + '\'' +
                ", time1='" + time1 + '\'' +
                ", time2='" + time2 + '\'' +
                '}';
    }
}
