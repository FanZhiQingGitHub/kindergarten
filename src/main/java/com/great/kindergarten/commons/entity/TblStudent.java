package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 学生信息实体了
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

    private String time1;
    private String time2;
    private TblClass tblClass;
    private Integer classid;
    private String classname;
    private TblParent tblParent;
    private Integer parentId;
    private String parentName;
    private TblKinder tblKinder;
    private Integer kinderid;
    private String kindername;


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

    public TblClass getTblClass()
    {
        return tblClass;
    }

    public void setTblClass(TblClass tblClass)
    {
        this.tblClass = tblClass;
    }

    public String getClassname()
    {
        return classname;
    }

    public void setClassname(String classname)
    {
        this.classname = classname;
    }

    public TblParent getTblParent()
    {
        return tblParent;
    }

    public void setTblParent(TblParent tblParent)
    {
        this.tblParent = tblParent;
    }

    public Integer getParentId()
    {
        return parentId;
    }

    public void setParentId(Integer parentId)
    {
        this.parentId = parentId;
    }

    public String getParentName()
    {
        return parentName;
    }

    public void setParentName(String parentName)
    {
        this.parentName = parentName;
    }

    public TblKinder getTblKinder()
    {
        return tblKinder;
    }

    public void setTblKinder(TblKinder tblKinder)
    {
        this.tblKinder = tblKinder;
    }

    public String getKindername()
    {
        return kindername;
    }

    public void setKindername(String kindername)
    {
        this.kindername = kindername;
    }

    public Integer getClassid()
    {
        return classid;
    }

    public void setClassid(Integer classid)
    {
        this.classid = classid;
    }


    public Integer getKinderid()
    {
        return kinderid;
    }

    public void setKinderid(Integer kinderid)
    {
        this.kinderid = kinderid;
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


