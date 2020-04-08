package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 教师考勤信息表实体类
 */
public class TblTertime {
    private Integer tertimeid;
    private Date tertime;
    private String tertimedate;
    private String tertimeperiod;
    private Integer tid;

    public TblTertime() {
    }

    public TblTertime(Integer tertimeid, Date tertime, String tertimedate, String tertimeperiod, Integer tid) {
        this.tertimeid = tertimeid;
        this.tertime = tertime;
        this.tertimedate = tertimedate;
        this.tertimeperiod = tertimeperiod;
        this.tid = tid;
    }

    public Integer getTertimeid() {
        return tertimeid;
    }

    public void setTertimeid(Integer tertimeid) {
        this.tertimeid = tertimeid;
    }

    public Date getTertime() {
        return tertime;
    }

    public void setTertime(Date tertime) {
        this.tertime = tertime;
    }

    public String getTertimedate() {
        return tertimedate;
    }

    public void setTertimedate(String tertimedate) {
        this.tertimedate = tertimedate;
    }

    public String getTertimeperiod() {
        return tertimeperiod;
    }

    public void setTertimeperiod(String tertimeperiod) {
        this.tertimeperiod = tertimeperiod;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    @Override
    public String toString() {
        return "TblTertime{" +
                "tertimeid=" + tertimeid +
                ", tertime=" + tertime +
                ", tertimedate='" + tertimedate + '\'' +
                ", tertimeperiod='" + tertimeperiod + '\'' +
                ", tid=" + tid +
                '}';
    }
}
