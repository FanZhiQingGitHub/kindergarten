package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 班级信息实体类
 */
public class TblClass {
    private Integer classid;
    private String classname;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date classregtime;
    private String classstatus;

    public TblClass() {
    }

    public TblClass(Integer classid, String classname, Date classregtime, String classstatus) {
        this.classid = classid;
        this.classname = classname;
        this.classregtime = classregtime;
        this.classstatus = classstatus;
    }

    public Integer getClassid() {
        return classid;
    }

    public void setClassid(Integer classid) {
        this.classid = classid;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public Date getClassregtime() {
        return classregtime;
    }

    public void setClassregtime(Date classregtime) {
        this.classregtime = classregtime;
    }

    public String getClassstatus() {
        return classstatus;
    }

    public void setClassstatus(String classstatus) {
        this.classstatus = classstatus;
    }

    @Override
    public String toString() {
        return "TblClass{" +
                "classid=" + classid +
                ", classname='" + classname + '\'' +
                ", classregtime=" + classregtime +
                ", classstatus='" + classstatus + '\'' +
                '}';
    }
}
