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
    private String studentlng;
    private String studentlat;

    private String time1;
    private String time2;
    private TblClass tblClass;
    private Integer classid;
    private String classname;
    private TblParent tblParent;
    private Integer parentId;
    private String parentName;
    private String parentSon;
    private String parentPhone;
    private String parentAdd;
    private String parentJob;
    private TblKinder tblKinder;
    private Integer kinderid;
    private String kindername;


    public TblStudent() {
    }

    public TblStudent(Integer studentid, String studentname, String studentpwd, String studentsex, String studentbrith, String studentadd, Date studenttime, String studentstatus, Integer cid, Integer pid, Integer kid, String studentlng, String studentlat, String time1, String time2, TblClass tblClass, Integer classid, String classname, TblParent tblParent, Integer parentId, String parentName, String parentSon, String parentPhone, String parentAdd, String parentJob, TblKinder tblKinder, Integer kinderid, String kindername)
    {
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
        this.studentlng = studentlng;
        this.studentlat = studentlat;
        this.time1 = time1;
        this.time2 = time2;
        this.tblClass = tblClass;
        this.classid = classid;
        this.classname = classname;
        this.tblParent = tblParent;
        this.parentId = parentId;
        this.parentName = parentName;
        this.parentSon = parentSon;
        this.parentPhone = parentPhone;
        this.parentAdd = parentAdd;
        this.parentJob = parentJob;
        this.tblKinder = tblKinder;
        this.kinderid = kinderid;
        this.kindername = kindername;
    }

    public String getParentSon()
    {
        return parentSon;
    }

    public void setParentSon(String parentSon)
    {
        this.parentSon = parentSon;
    }

    public String getParentPhone()
    {
        return parentPhone;
    }

    public void setParentPhone(String parentPhone)
    {
        this.parentPhone = parentPhone;
    }

    public String getParentAdd()
    {
        return parentAdd;
    }

    public void setParentAdd(String parentAdd)
    {
        this.parentAdd = parentAdd;
    }

    public String getParentJob()
    {
        return parentJob;
    }

    public void setParentJob(String parentJob)
    {
        this.parentJob = parentJob;
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

    public String getStudentlng() {
        return studentlng;
    }

    public void setStudentlng(String studentlng) {
        this.studentlng = studentlng;
    }

    public String getStudentlat() {
        return studentlat;
    }

    public void setStudentlat(String studentlat) {
        this.studentlat = studentlat;
    }

    public String getTime1() {
        return time1;
    }

    public void setTime1(String time1) {
        this.time1 = time1;
    }

    public String getTime2() {
        return time2;
    }

    public void setTime2(String time2) {
        this.time2 = time2;
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

    public TblParent getTblParent() {
        return tblParent;
    }

    public void setTblParent(TblParent tblParent) {
        this.tblParent = tblParent;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public TblKinder getTblKinder() {
        return tblKinder;
    }

    public void setTblKinder(TblKinder tblKinder) {
        this.tblKinder = tblKinder;
    }

    public Integer getKinderid() {
        return kinderid;
    }

    public void setKinderid(Integer kinderid) {
        this.kinderid = kinderid;
    }

    public String getKindername() {
        return kindername;
    }

    public void setKindername(String kindername) {
        this.kindername = kindername;
    }

    @Override
    public String toString()
    {
        return "TblStudent{" + "studentid=" + studentid + ", studentname='" + studentname + '\'' + ", studentpwd='" + studentpwd + '\'' + ", studentsex='" + studentsex + '\'' + ", studentbrith='" + studentbrith + '\'' + ", studentadd='" + studentadd + '\'' + ", studenttime=" + studenttime + ", studentstatus='" + studentstatus + '\'' + ", cid=" + cid + ", pid=" + pid + ", kid=" + kid + ", studentlng='" + studentlng + '\'' + ", studentlat='" + studentlat + '\'' + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + ", tblClass=" + tblClass + ", classid=" + classid + ", classname='" + classname + '\'' + ", tblParent=" + tblParent + ", parentId=" + parentId + ", parentName='" + parentName + '\'' + ", parentSon='" + parentSon + '\'' + ", parentPhone='" + parentPhone + '\'' + ", parentAdd='" + parentAdd + '\'' + ", parentJob='" + parentJob + '\'' + ", tblKinder=" + tblKinder + ", kinderid=" + kinderid + ", kindername='" + kindername + '\'' + '}';
    }
}


