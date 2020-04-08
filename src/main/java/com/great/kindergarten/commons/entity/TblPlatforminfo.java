package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 平台资讯信息实体类
 */
public class TblPlatforminfo {
    private Integer platforminfoid;
    private String platforminfoname;
    private Date platforminfotime;
    private String platforminfodetail;
    private Integer itid;

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

    @Override
    public String toString() {
        return "TblPlatforminfo{" +
                "platforminfoid=" + platforminfoid +
                ", platforminfoname='" + platforminfoname + '\'' +
                ", platforminfotime=" + platforminfotime +
                ", platforminfodetail='" + platforminfodetail + '\'' +
                ", itid=" + itid +
                '}';
    }
}
