package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 园所表实体信息类
 */
@Component(value = "TblKinder")
@Scope("prototype")
public class TblKinder {
    private Integer kinderid;
    private String kindername;
    private String kinderlp;
    private String kinderlpid;
    private String kinderlpadd;
    private String kinderlpphone;
    private String schoolpermit;
    private String healthpermit;
    private String firepermit;
    private String grouppermit;
    private String registrationpermit;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date kinderapptime;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date kinderregtime;
    private String kinderstatus;
    private String kinderacount;
    private String kinderpwd;
    private String kindercode;
    private String kinderscale;//规模
    private String kinderfunds;//注册资金
    private Integer recid;//对应的园长ID外键

    //连表查询用误删
    private TblRector tblRector;
    private Integer rectorid;
    private String rectorname;

    private String time1;
    private String time2;

    public TblKinder() {
    }

    public TblKinder(Integer kinderid, String kindername, String kinderlp, String kinderlpid, String kinderlpadd, String kinderlpphone, String schoolpermit, String healthpermit, String firepermit, String grouppermit, String registrationpermit, Date kinderapptime, Date kinderregtime, String kinderstatus, String kinderacount, String kinderpwd, String kindercode, String kinderscale, String kinderfunds,  String time1, String time2) {
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
        this.kinderacount = kinderacount;
        this.kinderpwd = kinderpwd;
        this.kindercode = kindercode;
        this.kinderscale = kinderscale;
        this.kinderfunds = kinderfunds;
        this.time1 = time1;
        this.time2 = time2;
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

    public String getKinderlpphone() {
        return kinderlpphone;
    }

    public void setKinderlpphone(String kinderlpphone) {
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

    public String getKinderacount() {
        return kinderacount;
    }

    public void setKinderacount(String kinderacount) {
        this.kinderacount = kinderacount;
    }

    public String getKinderpwd() {
        return kinderpwd;
    }

    public void setKinderpwd(String kinderpwd) {
        this.kinderpwd = kinderpwd;
    }

    public String getKindercode() {
        return kindercode;
    }

    public void setKindercode(String kindercode) {
        this.kindercode = kindercode;
    }

    public String getKinderscale() {
        return kinderscale;
    }

    public void setKinderscale(String kinderscale) {
        this.kinderscale = kinderscale;
    }

    public String getKinderfunds() {
        return kinderfunds;
    }

    public void setKinderfunds(String kinderfunds) {
        this.kinderfunds = kinderfunds;
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

    public Integer getRecid()
    {
        return recid;
    }

    public void setRecid(Integer recid)
    {
        this.recid = recid;
    }

    public TblRector getTblRector()
    {
        return tblRector;
    }

    public void setTblRector(TblRector tblRector)
    {
        this.tblRector = tblRector;
    }

    public Integer getRectorid()
    {
        return rectorid;
    }

    public void setRectorid(Integer rectorid)
    {
        this.rectorid = rectorid;
    }

    public String getRectorname()
    {
        return rectorname;
    }

    public void setRectorname(String rectorname)
    {
        this.rectorname = rectorname;
    }

    @Override
    public String toString() {
        return "TblKinder{" +
                "kinderid=" + kinderid +
                ", kindername='" + kindername + '\'' +
                ", kinderlp='" + kinderlp + '\'' +
                ", kinderlpid='" + kinderlpid + '\'' +
                ", kinderlpadd='" + kinderlpadd + '\'' +
                ", kinderlpphone='" + kinderlpphone + '\'' +
                ", schoolpermit='" + schoolpermit + '\'' +
                ", healthpermit='" + healthpermit + '\'' +
                ", firepermit='" + firepermit + '\'' +
                ", grouppermit='" + grouppermit + '\'' +
                ", registrationpermit='" + registrationpermit + '\'' +
                ", kinderapptime=" + kinderapptime +
                ", kinderregtime=" + kinderregtime +
                ", kinderstatus='" + kinderstatus + '\'' +
                ", kinderacount='" + kinderacount + '\'' +
                ", kinderpwd='" + kinderpwd + '\'' +
                ", kindercode='" + kindercode + '\'' +
                ", kinderscale='" + kinderscale + '\'' +
                ", kinderfunds='" + kinderfunds + '\'' +
                ", time1='" + time1 + '\'' +
                ", time2='" + time2 + '\'' +
                '}';
    }
}
