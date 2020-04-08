package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 体检信息实体类
 */
public class TblExamination {
    private Integer examinationid;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date examinationtime;
    private String skin;
    private String height;
    private String weight;
    private String vision;
    private String temperature;
    private String healthstatus;
    private Integer sid;

    private TblStudent tblStudent;
    private Integer studentid;
    private String studentname;

    public TblExamination() {
    }

    public TblExamination(Integer examinationid, Date examinationtime, String skin, String height, String weight, String vision, String temperature, String healthstatus, Integer sid) {
        this.examinationid = examinationid;
        this.examinationtime = examinationtime;
        this.skin = skin;
        this.height = height;
        this.weight = weight;
        this.vision = vision;
        this.temperature = temperature;
        this.healthstatus = healthstatus;
        this.sid = sid;
    }

    public Integer getExaminationid() {
        return examinationid;
    }

    public void setExaminationid(Integer examinationid) {
        this.examinationid = examinationid;
    }

    public Date getExaminationtime() {
        return examinationtime;
    }

    public void setExaminationtime(Date examinationtime) {
        this.examinationtime = examinationtime;
    }

    public String getSkin() {
        return skin;
    }

    public void setSkin(String skin) {
        this.skin = skin;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getVision() {
        return vision;
    }

    public void setVision(String vision) {
        this.vision = vision;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getHealthstatus() {
        return healthstatus;
    }

    public void setHealthstatus(String healthstatus) {
        this.healthstatus = healthstatus;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }


    public TblStudent getTblStudent() {
        return tblStudent;
    }

    public void setTblStudent(TblStudent tblStudent) {
        this.tblStudent = tblStudent;
    }

    public Integer getStudentid() {
        return studentid;
    }

    public void setStudentid(Integer studentid) {
        this.studentid = studentid;
    }

    public String getStudentname() {
        return studentname;
    }

    public void setStudentname(String studentname) {
        this.studentname = studentname;
    }

    @Override
    public String toString() {
        return "TblExamination{" +
                "examinationid=" + examinationid +
                ", examinationtime=" + examinationtime +
                ", skin='" + skin + '\'' +
                ", height='" + height + '\'' +
                ", weight='" + weight + '\'' +
                ", vision='" + vision + '\'' +
                ", temperature='" + temperature + '\'' +
                ", healthstatus='" + healthstatus + '\'' +
                ", sid=" + sid +
                ", tblStudent=" + tblStudent +
                ", studentid=" + studentid +
                ", studentname='" + studentname + '\'' +
                '}';
    }
}
