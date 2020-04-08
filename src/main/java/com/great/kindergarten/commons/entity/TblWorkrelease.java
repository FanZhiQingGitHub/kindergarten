package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 教师作业发布表实体类
 */
public class TblWorkrelease {
    private Integer workreleaseid;
    private String workreleasedetail;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date workreleasetime;
    private Integer cid;

    public TblWorkrelease() {
    }

    public TblWorkrelease(Integer workreleaseid, String workreleasedetail, Date workreleasetime, Integer cid) {
        this.workreleaseid = workreleaseid;
        this.workreleasedetail = workreleasedetail;
        this.workreleasetime = workreleasetime;
        this.cid = cid;
    }

    public Integer getWorkreleaseid() {
        return workreleaseid;
    }

    public void setWorkreleaseid(Integer workreleaseid) {
        this.workreleaseid = workreleaseid;
    }

    public String getWorkreleasedetail() {
        return workreleasedetail;
    }

    public void setWorkreleasedetail(String workreleasedetail) {
        this.workreleasedetail = workreleasedetail;
    }

    public Date getWorkreleasetime() {
        return workreleasetime;
    }

    public void setWorkreleasetime(Date workreleasetime) {
        this.workreleasetime = workreleasetime;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblWorkrelease{" +
                "workreleaseid=" + workreleaseid +
                ", workreleasedetail='" + workreleasedetail + '\'' +
                ", workreleasetime=" + workreleasetime +
                ", cid=" + cid +
                '}';
    }
}
