package com.great.kindergarten.commons.entity;

/**
 * 监控区域表实体信息类
 */
public class TblMonitor {
    private Integer monitorid;
    private String monitorname;
    private String monitorimgurl;
    private String monitormvurl;
    private String monitormvname;
    private String monitormvtime;
    private Integer kid;
    private Integer kinderid;
    private String kindername;


    public TblMonitor() {
    }

    public TblMonitor(Integer monitorid, String monitorname, String monitorimgurl, String monitormvurl, String monitormvname, String monitormvtime, Integer kid, Integer kinderid, String kindername) {
        this.monitorid = monitorid;
        this.monitorname = monitorname;
        this.monitorimgurl = monitorimgurl;
        this.monitormvurl = monitormvurl;
        this.monitormvname = monitormvname;
        this.monitormvtime = monitormvtime;
        this.kid = kid;
        this.kinderid = kinderid;
        this.kindername = kindername;
    }

    public Integer getMonitorid() {
        return monitorid;
    }

    public void setMonitorid(Integer monitorid) {
        this.monitorid = monitorid;
    }

    public String getMonitorname() {
        return monitorname;
    }

    public void setMonitorname(String monitorname) {
        this.monitorname = monitorname;
    }

    public String getMonitorimgurl() {
        return monitorimgurl;
    }

    public void setMonitorimgurl(String monitorimgurl) {
        this.monitorimgurl = monitorimgurl;
    }

    public String getMonitormvurl() {
        return monitormvurl;
    }

    public void setMonitormvurl(String monitormvurl) {
        this.monitormvurl = monitormvurl;
    }

    public String getMonitormvname() {
        return monitormvname;
    }

    public void setMonitormvname(String monitormvname) {
        this.monitormvname = monitormvname;
    }

    public String getMonitormvtime() {
        return monitormvtime;
    }

    public void setMonitormvtime(String monitormvtime) {
        this.monitormvtime = monitormvtime;
    }

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
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

    @Override
    public String toString() {
        return "TblMonitor{" +
                "monitorid=" + monitorid +
                ", monitorname='" + monitorname + '\'' +
                ", monitorimgurl='" + monitorimgurl + '\'' +
                ", monitormvurl='" + monitormvurl + '\'' +
                ", monitormvname='" + monitormvname + '\'' +
                ", monitormvtime='" + monitormvtime + '\'' +
                ", kid=" + kid +
                ", kinderid=" + kinderid +
                ", kindername='" + kindername + '\'' +
                '}';
    }
}
