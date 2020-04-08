package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 园所表实体信息类
 */
public class TblKinder {
    private Integer kinderid;
    private String kindername;
    private String kinderlp;
    private String kinderlpid;
    private String kinderlpadd;
    private Integer kinderlpphone;
    private String schoolpermit;
    private String healthpermit;
    private String firepermit;
    private String grouppermit;
    private String registrationpermit;
    private Date kinderapptime;
    private Date kinderregtime;
    private String kinderstatus;

    public TblKinder() {
    }

    public TblKinder(Integer kinderid, String kindername, String kinderlp, String kinderlpid, String kinderlpadd, Integer kinderlpphone, String schoolpermit, String healthpermit, String firepermit, String grouppermit, String registrationpermit, Date kinderapptime, Date kinderregtime, String kinderstatus) {
        this.kinderid = kinderid;
        this.kindername = kindername;
        this.kinderlp = kinderlp;
        this.kinderlpid = kinderlpid;
        this.kinderlpadd = kinderlpadd;
        this.kinderlpphone = kinderlpphone;
        this.schoolpermit = schoolpermit;
        this.healthpermit = healthpermit;
        this.firepermit = firepermit;
        this.grouppermit = grouppermit;
        this.registrationpermit = registrationpermit;
        this.kinderapptime = kinderapptime;
        this.kinderregtime = kinderregtime;
        this.kinderstatus = kinderstatus;
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

    public String getKinderlp() {
        return kinderlp;
    }

    public void setKinderlp(String kinderlp) {
        this.kinderlp = kinderlp;
    }

    public String getKinderlpid() {
        return kinderlpid;
    }

    public void setKinderlpid(String kinderlpid) {
        this.kinderlpid = kinderlpid;
    }

    public String getKinderlpadd() {
        return kinderlpadd;
    }

    public void setKinderlpadd(String kinderlpadd) {
        this.kinderlpadd = kinderlpadd;
    }

    public Integer getKinderlpphone() {
        return kinderlpphone;
    }

    public void setKinderlpphone(Integer kinderlpphone) {
        this.kinderlpphone = kinderlpphone;
    }

    public String getSchoolpermit() {
        return schoolpermit;
    }

    public void setSchoolpermit(String schoolpermit) {
        this.schoolpermit = schoolpermit;
    }

    public String getHealthpermit() {
        return healthpermit;
    }

    public void setHealthpermit(String healthpermit) {
        this.healthpermit = healthpermit;
    }

    public String getFirepermit() {
        return firepermit;
    }

    public void setFirepermit(String firepermit) {
        this.firepermit = firepermit;
    }

    public String getGrouppermit() {
        return grouppermit;
    }

    public void setGrouppermit(String grouppermit) {
        this.grouppermit = grouppermit;
    }

    public String getRegistrationpermit() {
        return registrationpermit;
    }

    public void setRegistrationpermit(String registrationpermit) {
        this.registrationpermit = registrationpermit;
    }

    public Date getKinderapptime() {
        return kinderapptime;
    }

    public void setKinderapptime(Date kinderapptime) {
        this.kinderapptime = kinderapptime;
    }

    public Date getKinderregtime() {
        return kinderregtime;
    }

    public void setKinderregtime(Date kinderregtime) {
        this.kinderregtime = kinderregtime;
    }

    public String getKinderstatus() {
        return kinderstatus;
    }

    public void setKinderstatus(String kinderstatus) {
        this.kinderstatus = kinderstatus;
    }

    @Override
    public String toString() {
        return "TblKinder{" +
                "kinderid=" + kinderid +
                ", kindername='" + kindername + '\'' +
                ", kinderlp='" + kinderlp + '\'' +
                ", kinderlpid='" + kinderlpid + '\'' +
                ", kinderlpadd='" + kinderlpadd + '\'' +
                ", kinderlpphone=" + kinderlpphone +
                ", schoolpermit='" + schoolpermit + '\'' +
                ", healthpermit='" + healthpermit + '\'' +
                ", firepermit='" + firepermit + '\'' +
                ", grouppermit='" + grouppermit + '\'' +
                ", registrationpermit='" + registrationpermit + '\'' +
                ", kinderapptime=" + kinderapptime +
                ", kinderregtime=" + kinderregtime +
                ", kinderstatus='" + kinderstatus + '\'' +
                '}';
    }
}
