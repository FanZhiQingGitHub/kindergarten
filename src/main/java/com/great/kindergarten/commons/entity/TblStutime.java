package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 学生考勤信息实体类
 */
public class TblStutime {
    private Integer stutimeid;
    private Date stutimes;
    private Date stutimedate;
    private String stutimeperiod;
    private Integer sid;

    public TblStutime() {
    }

    public TblStutime(Integer stutimeid, Date stutimes, Date stutimedate, String stutimeperiod, Integer sid) {
        this.stutimeid = stutimeid;
        this.stutimes = stutimes;
        this.stutimedate = stutimedate;
        this.stutimeperiod = stutimeperiod;
        this.sid = sid;
    }

    public Integer getStutimeid() {
        return stutimeid;
    }

    public void setStutimeid(Integer stutimeid) {
        this.stutimeid = stutimeid;
    }

    public Date getStutimes() {
        return stutimes;
    }

    public void setStutimes(Date stutimes) {
        this.stutimes = stutimes;
    }

    public Date getStutimedate() {
        return stutimedate;
    }

    public void setStutimedate(Date stutimedate) {
        this.stutimedate = stutimedate;
    }

    public String getStutimeperiod() {
        return stutimeperiod;
    }

    public void setStutimeperiod(String stutimeperiod) {
        this.stutimeperiod = stutimeperiod;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    @Override
    public String toString() {
        return "TblStutime{" +
                "stutimeid=" + stutimeid +
                ", stutimes=" + stutimes +
                ", stutimedate=" + stutimedate +
                ", stutimeperiod='" + stutimeperiod + '\'' +
                ", sid=" + sid +
                '}';
    }
}
