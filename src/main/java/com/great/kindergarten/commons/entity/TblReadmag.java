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

    @Override
    public String toString() {
        return "TblReadmag{" +
                "readmagid=" + readmagid +
                ", readmagname='" + readmagname + '\'' +
                ", readmagurl='" + readmagurl + '\'' +
                ", readmagdetail='" + readmagdetail + '\'' +
                ", readmagtime=" + readmagtime +
                '}';
    }
}
