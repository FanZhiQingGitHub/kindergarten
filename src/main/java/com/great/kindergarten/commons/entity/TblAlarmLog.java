package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 报警日志实体类
 */
public class TblAlarmLog {
    private Integer alarmlogid;
    private String alarmlogname;
    private String alarmlogarea;
    private Date alarmlogtime;
    private Integer sid;
    private Integer studentid;
    private String studentname;

    public TblAlarmLog() {
    }

    public TblAlarmLog(Integer alarmlogid, String alarmlogname, String alarmlogarea, Date alarmlogtime, Integer sid, Integer studentid, String studentname) {
        this.alarmlogid = alarmlogid;
        this.alarmlogname = alarmlogname;
        this.alarmlogarea = alarmlogarea;
        this.alarmlogtime = alarmlogtime;
        this.sid = sid;
        this.studentid = studentid;
        this.studentname = studentname;
    }

    public Integer getAlarmlogid() {
        return alarmlogid;
    }

    public void setAlarmlogid(Integer alarmlogid) {
        this.alarmlogid = alarmlogid;
    }

    public String getAlarmlogname() {
        return alarmlogname;
    }

    public void setAlarmlogname(String alarmlogname) {
        this.alarmlogname = alarmlogname;
    }

    public String getAlarmlogarea() {
        return alarmlogarea;
    }

    public void setAlarmlogarea(String alarmlogarea) {
        this.alarmlogarea = alarmlogarea;
    }

    public Date getAlarmlogtime() {
        return alarmlogtime;
    }

    public void setAlarmlogtime(Date alarmlogtime) {
        this.alarmlogtime = alarmlogtime;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
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
        return "TblAlarmLog{" +
                "alarmlogid=" + alarmlogid +
                ", alarmlogname='" + alarmlogname + '\'' +
                ", alarmlogarea='" + alarmlogarea + '\'' +
                ", alarmlogtime=" + alarmlogtime +
                ", sid=" + sid +
                ", studentid=" + studentid +
                ", studentname='" + studentname + '\'' +
                '}';
    }
}
