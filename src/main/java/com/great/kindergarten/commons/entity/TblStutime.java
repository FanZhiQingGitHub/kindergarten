package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 学生考勤信息实体类
 */
public class TblStutime {
    private Integer stutimeid;
    private String stutimetype;
    private String stutimemonday;
    private String stutimetuesday;
    private String stutimewednesday;
    private String stutimethursday;
    private String stutimefriday;
    private Integer pickid;

    private TblPickup tblPickup;
    private Integer pickupid;
    private Date mondaydate;//上下周一的日期
    private Date sundaydate;//上下周日的日期
    private Integer sid;


    public TblStutime() {
    }

    public TblStutime(Integer stutimeid, String stutimetype, String stutimemonday, String stutimetuesday, String stutimewednesday, String stutimethursday, String stutimefriday, Integer pickid, Integer pickupid, Date mondaydate, Date sundaydate, Integer sid) {
        this.stutimeid = stutimeid;
        this.stutimetype = stutimetype;
        this.stutimemonday = stutimemonday;
        this.stutimetuesday = stutimetuesday;
        this.stutimewednesday = stutimewednesday;
        this.stutimethursday = stutimethursday;
        this.stutimefriday = stutimefriday;
        this.pickid = pickid;
        this.pickupid = pickupid;
        this.mondaydate = mondaydate;
        this.sundaydate = sundaydate;
        this.sid = sid;
    }

    public Integer getStutimeid() {
        return stutimeid;
    }

    public void setStutimeid(Integer stutimeid) {
        this.stutimeid = stutimeid;
    }

    public String getStutimetype() {
        return stutimetype;
    }

    public void setStutimetype(String stutimetype) {
        this.stutimetype = stutimetype;
    }

    public String getStutimemonday() {
        return stutimemonday;
    }

    public void setStutimemonday(String stutimemonday) {
        this.stutimemonday = stutimemonday;
    }

    public String getStutimetuesday() {
        return stutimetuesday;
    }

    public void setStutimetuesday(String stutimetuesday) {
        this.stutimetuesday = stutimetuesday;
    }

    public String getStutimewednesday() {
        return stutimewednesday;
    }

    public void setStutimewednesday(String stutimewednesday) {
        this.stutimewednesday = stutimewednesday;
    }

    public String getStutimethursday() {
        return stutimethursday;
    }

    public void setStutimethursday(String stutimethursday) {
        this.stutimethursday = stutimethursday;
    }

    public String getStutimefriday() {
        return stutimefriday;
    }

    public void setStutimefriday(String stutimefriday) {
        this.stutimefriday = stutimefriday;
    }

    public Integer getPickid() {
        return pickid;
    }

    public void setPickid(Integer pickid) {
        this.pickid = pickid;
    }

    public TblPickup getTblPickup() {
        return tblPickup;
    }

    public void setTblPickup(TblPickup tblPickup) {
        this.tblPickup = tblPickup;
    }

    public Integer getPickupid() {
        return pickupid;
    }

    public void setPickupid(Integer pickupid) {
        this.pickupid = pickupid;
    }

    public Date getMondaydate() {
        return mondaydate;
    }

    public void setMondaydate(Date mondaydate) {
        this.mondaydate = mondaydate;
    }

    public Date getSundaydate() {
        return sundaydate;
    }

    public void setSundaydate(Date sundaydate) {
        this.sundaydate = sundaydate;
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
                ", stutimetype='" + stutimetype + '\'' +
                ", stutimemonday='" + stutimemonday + '\'' +
                ", stutimetuesday='" + stutimetuesday + '\'' +
                ", stutimewednesday='" + stutimewednesday + '\'' +
                ", stutimethursday='" + stutimethursday + '\'' +
                ", stutimefriday='" + stutimefriday + '\'' +
                ", pickid=" + pickid +
                ", tblPickup=" + tblPickup +
                ", pickupid=" + pickupid +
                ", mondaydate=" + mondaydate +
                ", sundaydate=" + sundaydate +
                ", sid=" + sid +
                '}';
    }
}
