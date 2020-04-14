package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 平台资讯信息实体类
 */
public class TblPlatforminfo {
    private Integer platforminfoid;
    private String platforminfoname;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date platforminfotime;
    private String platforminfodetail;
    private Integer itid;
    private String platforminfostatus;
    private String time1;
    private String time2;

    public TblPlatforminfo() {
    }

    public TblPlatforminfo(Integer platforminfoid, String platforminfoname, Date platforminfotime, String platforminfodetail, Integer itid) {
        this.platforminfoid = platforminfoid;
        this.platforminfoname = platforminfoname;
        this.platforminfotime = platforminfotime;
        this.platforminfodetail = platforminfodetail;
        this.itid = itid;
    }

    public Integer getPlatforminfoid() {
        return platforminfoid;
    }

    public void setPlatforminfoid(Integer platforminfoid) {
        this.platforminfoid = platforminfoid;
    }

    public String getPlatforminfoname() {
        return platforminfoname;
    }

    public void setPlatforminfoname(String platforminfoname) {
        this.platforminfoname = platforminfoname;
    }

    public Date getPlatforminfotime() {
        return platforminfotime;
    }

    public void setPlatforminfotime(Date platforminfotime) {
        this.platforminfotime = platforminfotime;
    }

    public String getPlatforminfodetail() {
        return platforminfodetail;
    }

    public void setPlatforminfodetail(String platforminfodetail) {
        this.platforminfodetail = platforminfodetail;
    }

    public Integer getItid() {
        return itid;
    }

    public void setItid(Integer itid) {
        this.itid = itid;
    }

    public String getPlatforminfostatus()
    {
        return platforminfostatus;
    }

    public void setPlatforminfostatus(String platforminfostatus)
    {
        this.platforminfostatus = platforminfostatus;
    }

    public String getTime1()
    {
        return time1;
    }

    public void setTime1(String time1)
    {
        this.time1 = time1;
    }

    public String getTime2()
    {
        return time2;
    }

    public void setTime2(String time2)
    {
        this.time2 = time2;
    }

    @Override
    public String toString()
    {
        return "TblPlatforminfo{" + "platforminfoid=" + platforminfoid + ", platforminfoname='" + platforminfoname + '\'' + ", platforminfotime=" + platforminfotime + ", platforminfodetail='" + platforminfodetail + '\'' + ", itid=" + itid + ", platforminfostatus='" + platforminfostatus + '\'' + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + '}';
    }
}
