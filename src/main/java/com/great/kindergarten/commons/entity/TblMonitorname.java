package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 * 监控区域名称表实体类
 */
public class TblMonitorname {
    private Integer monitornameid;
    private String monitorname;

    private List<?> tblMonitornameList;
    private Integer classid;

    public TblMonitorname() {
    }

    public TblMonitorname(Integer monitornameid, String monitorname) {
        this.monitornameid = monitornameid;
        this.monitorname = monitorname;
    }

    public Integer getMonitornameid() {
        return monitornameid;
    }

    public void setMonitornameid(Integer monitornameid) {
        this.monitornameid = monitornameid;
    }

    public String getMonitorname() {
        return monitorname;
    }

    public void setMonitorname(String monitorname) {
        this.monitorname = monitorname;
    }

    public List<?> getTblMonitornameList() {
        return tblMonitornameList;
    }

    public void setTblMonitornameList(List<?> tblMonitornameList) {
        this.tblMonitornameList = tblMonitornameList;
    }

    public Integer getClassid() {
        return classid;
    }

    public void setClassid(Integer classid) {
        this.classid = classid;
    }

    @Override
    public String toString() {
        return "TblMonitorname{" +
                "monitornameid=" + monitornameid +
                ", monitorname='" + monitorname + '\'' +
                ", tblMonitornameList=" + tblMonitornameList +
                ", classid=" + classid +
                '}';
    }
}
