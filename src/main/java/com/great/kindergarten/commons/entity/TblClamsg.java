package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 班级消息通知表
 */
public class TblClamsg {
    private Integer clamsgid;
    private String clamsgdetail;
    private Integer cid;
    private Integer teacherid;
    @JsonFormat( timezone = "GMT+ 8",pattern="yyyy-MM-dd HH:mm")
    @DateTimeFormat( pattern = "yyy-MM-dd" )
    private Date sendmsgtime;

    public TblClamsg() {
    }

    public TblClamsg(Integer clamsgid, String clamsgdetail, Integer cid) {
        this.clamsgid = clamsgid;
        this.clamsgdetail = clamsgdetail;
        this.cid = cid;
    }

    public TblClamsg(Integer clamsgid, String clamsgdetail, Integer cid, Integer teacherid, Date sendmsgtime)
    {
        this.clamsgid = clamsgid;
        this.clamsgdetail = clamsgdetail;
        this.cid = cid;
        this.teacherid = teacherid;
        this.sendmsgtime = sendmsgtime;
    }

    public Integer getTeacherid()
    {
        return teacherid;
    }

    public void setTeacherid(Integer teacherid)
    {
        this.teacherid = teacherid;
    }

    public Date getSendmsgtime()
    {
        return sendmsgtime;
    }

    public void setSendmsgtime(Date sendmsgtime)
    {
        this.sendmsgtime = sendmsgtime;
    }

    public Integer getClamsgid() {
        return clamsgid;
    }

    public void setClamsgid(Integer clamsgid) {
        this.clamsgid = clamsgid;
    }

    public String getClamsgdetail() {
        return clamsgdetail;
    }

    public void setClamsgdetail(String clamsgdetail) {
        this.clamsgdetail = clamsgdetail;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString()
    {
        return "TblClamsg{" + "clamsgid=" + clamsgid + ", clamsgdetail='" + clamsgdetail + '\'' + ", cid=" + cid + ", teacherid=" + teacherid + ", sendmsgtime=" + sendmsgtime + '}';
    }
}
