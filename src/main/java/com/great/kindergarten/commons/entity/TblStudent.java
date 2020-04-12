package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 学生信息实体类
 */
@Component(value = "TblStudent")
@Scope("prototype")
public class TblStudent {
    private Integer studentid;
    private String studentname;
    private String studentpwd;
    private String studentsex;
    private String studentbrith;
    private String studentadd;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date studenttime;
    private String studentstatus;
    private Integer cid;
    private Integer pid;
    private Integer kid;
    private Integer rid;



    public TblStudent() {
    }

    public TblStudent(Integer studentid, String studentname, String studentpwd, String studentsex, String studentbrith, String studentadd, Date studenttime, String studentstatus, Integer cid, Integer pid, Integer kid, Integer rid) {
        this.studentid = studentid;
        this.studentname = studentname;
        this.studentpwd = studentpwd;
        this.studentsex = studentsex;
        this.studentbrith = studentbrith;
        this.studentadd = studentadd;
        this.studenttime = studenttime;
        this.studentstatus = studentstatus;
        this.cid = cid;
        this.pid = pid;
        this.kid = kid;
        this.rid = rid;
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

    public String getStudentpwd() {
        return studentpwd;
    }

    public void setStudentpwd(String studentpwd) {
        this.studentpwd = studentpwd;
    }

    public String getStudentsex() {
        return studentsex;
    }

    public void setStudentsex(String studentsex) {
        this.studentsex = studentsex;
    }

    public String getStudentbrith() {
        return studentbrith;
    }

    public void setStudentbrith(String studentbrith) {
        this.studentbrith = studentbrith;
    }

    public String getStudentadd() {
        return studentadd;
    }

    public void setStudentadd(String studentadd) {
        this.studentadd = studentadd;
    }

    public Date getStudenttime() {
        return studenttime;
    }

    public void setStudenttime(Date studenttime) {
        this.studenttime = studenttime;
    }

    public String getStudentstatus() {
        return studentstatus;
    }

    public void setStudentstatus(String studentstatus) {
        this.studentstatus = studentstatus;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    @Override
    public String toString() {
        return "TblStudent{" +
                "studentid=" + studentid +
                ", studentname='" + studentname + '\'' +
                ", studentpwd='" + studentpwd + '\'' +
                ", studentsex='" + studentsex + '\'' +
                ", studentbrith='" + studentbrith + '\'' +
                ", studentadd='" + studentadd + '\'' +
                ", studenttime=" + studenttime +
                ", studentstatus='" + studentstatus + '\'' +
                ", cid=" + cid +
                ", pid=" + pid +
                ", kid=" + kid +
                ", rid=" + rid +
                '}';
    }
}


