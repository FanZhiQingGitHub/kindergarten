package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 阅读管理表实体类
 */
public class TblReadmag {
    private Integer readmagid;
    private String readmagname;
    private String readmagurl;
    private String readmagdetail;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date readmagtime;
    private Integer readmagpage;
    private String photourl;
    private String time1;
    private String time2;

    public TblReadmag() {
    }

    public TblReadmag(Integer readmagid, String readmagname, String readmagurl, String readmagdetail, Date readmagtime) {
        this.readmagid = readmagid;
        this.readmagname = readmagname;
        this.readmagurl = readmagurl;
        this.readmagdetail = readmagdetail;
        this.readmagtime = readmagtime;
    }

    public Integer getReadmagid() {
        return readmagid;
    }

    public void setReadmagid(Integer readmagid) {
        this.readmagid = readmagid;
    }

    public String getReadmagname() {
        return readmagname;
    }

    public void setReadmagname(String readmagname) {
        this.readmagname = readmagname;
    }

    public String getReadmagurl() {
        return readmagurl;
    }

    public void setReadmagurl(String readmagurl) {
        this.readmagurl = readmagurl;
    }

    public String getReadmagdetail() {
        return readmagdetail;
    }

    public void setReadmagdetail(String readmagdetail) {
        this.readmagdetail = readmagdetail;
    }

    public Date getReadmagtime() {
        return readmagtime;
    }

    public void setReadmagtime(Date readmagtime) {
        this.readmagtime = readmagtime;
    }

    public String getTime1()
    {
        return time1;
    }

    public void setTime1(String time1)
    {
        this.time1 = time1;
    }

    public String getTime2()
    {
        return time2;
    }

    public void setTime2(String time2)
    {
        this.time2 = time2;
    }

    public Integer getReadmagpage()
    {
        return readmagpage;
    }

    public void setReadmagpage(Integer readmagpage)
    {
        this.readmagpage = readmagpage;
    }

    public String getPhotourl()
    {
        return photourl;
    }

    public void setPhotourl(String photourl)
    {
        this.photourl = photourl;
    }

    @Override
    public String toString()
    {
        return "TblReadmag{" + "readmagid=" + readmagid + ", readmagname='" + readmagname + '\'' + ", readmagurl='" + readmagurl + '\'' + ", readmagdetail='" + readmagdetail + '\'' + ", readmagtime=" + readmagtime + ", readmagpage=" + readmagpage + ", photourl='" + photourl + '\'' + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + '}';
    }
}
