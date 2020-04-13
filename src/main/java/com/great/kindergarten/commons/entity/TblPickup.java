package com.great.kindergarten.commons.entity;

import java.util.Date;
import java.util.List;

/**
 * 接送日期区间信息表实体类
 */
public class TblPickup {
    private Integer pickupid;
    private Date mondaydate;//上下周一的日期
    private Date sundaydate;//上下周日的日期
    private Integer sid;

    private TblTeacher tblTeacher;
    private String teachername;
    private TblStudent tblStudent;
    private String studentname;
    private String studentsex;
    private TblClass tblClass;
    private String classname;


    public TblPickup() {
    }

    public TblPickup(Integer pickupid, Date mondaydate, Date sundaydate, Integer sid, TblTeacher tblTeacher, String teachername, TblStudent tblStudent, String studentname, String studentsex, TblClass tblClass, String classname) {
        this.pickupid = pickupid;
        this.mondaydate = mondaydate;
        this.sundaydate = sundaydate;
        this.sid = sid;
        this.tblTeacher = tblTeacher;
        this.teachername = teachername;
        this.tblStudent = tblStudent;
        this.studentname = studentname;
        this.studentsex = studentsex;
        this.tblClass = tblClass;
        this.classname = classname;
    }

    public Integer getPickupid() {
        return pickupid;
    }

    public void setPickupid(Integer pickupid) {
        this.pickupid = pickupid;
    }

    public Date getMondaydate() {
        return mondaydate;
    }

    public void setMondaydate(Date mondaydate) {
        this.mondaydate = mondaydate;
    }

    public Date getSundaydate() {
        return sundaydate;
    }

    public void setSundaydate(Date sundaydate) {
        this.sundaydate = sundaydate;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public TblTeacher getTblTeacher() {
        return tblTeacher;
    }

    public void setTblTeacher(TblTeacher tblTeacher) {
        this.tblTeacher = tblTeacher;
    }

    public String getTeachername() {
        return teachername;
    }

    public void setTeachername(String teachername) {
        this.teachername = teachername;
    }

    public TblStudent getTblStudent() {
        return tblStudent;
    }

    public void setTblStudent(TblStudent tblStudent) {
        this.tblStudent = tblStudent;
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

    public TblClass getTblClass() {
        return tblClass;
    }

    public void setTblClass(TblClass tblClass) {
        this.tblClass = tblClass;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    @Override
    public String toString() {
        return "TblPickup{" +
                "pickupid=" + pickupid +
                ", mondaydate=" + mondaydate +
                ", sundaydate=" + sundaydate +
                ", sid=" + sid +
                ", tblTeacher=" + tblTeacher +
                ", teachername='" + teachername + '\'' +
                ", tblStudent=" + tblStudent +
                ", studentname='" + studentname + '\'' +
                ", studentsex='" + studentsex + '\'' +
                ", tblClass=" + tblClass +
                ", classname='" + classname + '\'' +
                '}';
    }
}
