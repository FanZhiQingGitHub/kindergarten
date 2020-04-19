package com.great.kindergarten.commons.entity;

/**
 * 监控区域表实体信息类
 */
public class TblMonitor {
    private Integer monitorid;
    private String monitorname;
    private String monitorimgurl;
    private String monitormvurl;
    private Integer kid;

    private TblKinder tblKinder;
    private Integer kinderid;
    private String kindername;


    public TblMonitor() {
    }

    public TblMonitor(Integer monitorid, String monitorname, String monitorimgurl, String monitormvurl, Integer kid, Integer kinderid, String kindername) {
        this.monitorid = monitorid;
        this.monitorname = monitorname;
        this.monitorimgurl = monitorimgurl;
        this.monitormvurl = monitormvurl;
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

    @Override
    public String toString() {
        return "TblMonitor{" +
                "monitorid=" + monitorid +
                ", monitorname='" + monitorname + '\'' +
                ", monitorimgurl='" + monitorimgurl + '\'' +
                ", monitormvurl='" + monitormvurl + '\'' +
                ", kid=" + kid +
                ", tblKinder=" + tblKinder +
                ", kinderid=" + kinderid +
                ", kindername='" + kindername + '\'' +
                '}';
    }
}
