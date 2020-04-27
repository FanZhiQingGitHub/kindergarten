package com.great.kindergarten.commons.entity;

import java.util.Date;

/**
 * 宝宝考勤日期区间实体信息类
 */
public class TblDate {
    private Integer dateid;
    private Date monday;
    private Date sunday;
    private Integer kid;

    private TblStutime tblStutime;
    private Integer timeamid;

    private TblStudent tblStudent;
    private Integer studentid;
    private String studentname;
    private String studentsex;

    private TblTeacher tblTeacher;
    private Integer teacherid;
    private String teachername;

    private TblClass tblClass;
    private Integer classid;
    private String classname;

    public TblDate() {
    }

    public TblDate(Integer dateid, Date monday, Date sunday, Integer kid,Integer timeamid, Integer studentid, String studentname, String studentsex, Integer teacherid, String teachername, Integer classid, String classname) {
        this.dateid = dateid;
        this.monday = monday;
        this.sunday = sunday;
        this.kid = kid;
        this.timeamid = timeamid;
        this.studentid = studentid;
        this.studentname = studentname;
        this.studentsex = studentsex;
        this.teacherid = teacherid;
        this.teachername = teachername;
        this.classid = classid;
        this.classname = classname;
    }

    public Integer getDateid() {
        return dateid;
    }

    public void setDateid(Integer dateid) {
        this.dateid = dateid;
    }

    public Date getMonday() {
        return monday;
    }

    public void setMonday(Date monday) {
        this.monday = monday;
    }

    public Date getSunday() {
        return sunday;
    }

    public void setSunday(Date sunday) {
        this.sunday = sunday;
    }

    public TblStutime getTblStutime() {
        return tblStutime;
    }

    public void setTblStutime(TblStutime tblStutime) {
        this.tblStutime = tblStutime;
    }

    public Integer getTimeamid() {
        return timeamid;
    }

    public void setTimeamid(Integer timeamid) {
        this.timeamid = timeamid;
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

    public String getStudentsex() {
        return studentsex;
    }

    public void setStudentsex(String studentsex) {
        this.studentsex = studentsex;
    }

    public TblTeacher getTblTeacher() {
        return tblTeacher;
    }

    public void setTblTeacher(TblTeacher tblTeacher) {
        this.tblTeacher = tblTeacher;
    }

    public Integer getTeacherid() {
        return teacherid;
    }

    public void setTeacherid(Integer teacherid) {
        this.teacherid = teacherid;
    }

    public String getTeachername() {
        return teachername;
    }

    public void setTeachername(String teachername) {
        this.teachername = teachername;
    }

    public TblClass getTblClass() {
        return tblClass;
    }

    public void setTblClass(TblClass tblClass) {
        this.tblClass = tblClass;
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

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    @Override
    public String toString() {
        return "TblDate{" +
                "dateid=" + dateid +
                ", monday=" + monday +
                ", sunday=" + sunday +
                ", kid=" + kid +
                ", tblStutime=" + tblStutime +
                ", timeamid=" + timeamid +
                ", tblStudent=" + tblStudent +
                ", studentid=" + studentid +
                ", studentname='" + studentname + '\'' +
                ", studentsex='" + studentsex + '\'' +
                ", tblTeacher=" + tblTeacher +
                ", teacherid=" + teacherid +
                ", teachername='" + teachername + '\'' +
                ", tblClass=" + tblClass +
                ", classid=" + classid +
                ", classname='" + classname + '\'' +
                '}';
    }
}
