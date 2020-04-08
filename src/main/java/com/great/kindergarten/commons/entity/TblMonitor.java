package com.great.kindergarten.commons.entity;

/**
 * 监控区域表实体信息类
 */
public class TblMonitor {
    private Integer monitorid;
    private String monitorname;

    public TblMonitor() {
    }

    public TblMonitor(Integer monitorid, String monitorname) {
        this.monitorid = monitorid;
        this.monitorname = monitorname;
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

    @Override
    public String toString() {
        return "TblMonitor{" +
                "monitorid=" + monitorid +
                ", monitorname='" + monitorname + '\'' +
                '}';
    }
}
