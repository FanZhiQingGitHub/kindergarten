package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 班级消息通知表
 */
@Component
public class TblClamsg {
    private Integer clamsgid;
    private String clamsgdetail;
    private Integer cid;

    @JsonFormat( timezone = "GMT+ 8",pattern="yyyy-MM-dd HH:mm")
    @DateTimeFormat( pattern = "yyy-MM-dd" )
    private Date sendmsgtime;

    public TblClamsg() {
    }

    public TblClamsg(Integer clamsgid, String clamsgdetail, Integer cid, Date sendmsgtime)
    {
        this.clamsgid = clamsgid;
        this.clamsgdetail = clamsgdetail;
        this.cid = cid;
        this.sendmsgtime = sendmsgtime;
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
        return "TblClamsg{" + "clamsgid=" + clamsgid + ", clamsgdetail='" + clamsgdetail + '\'' + ", cid=" + cid + ", sendmsgtime=" + sendmsgtime + '}';
    }
}
