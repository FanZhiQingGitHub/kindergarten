package com.great.kindergarten.commons.entity;

/**
 * 课程表信息实体类
 */
public class TblCourse {
    private Integer courseid;
    private Integer coursenum;
    private String coursename1;
    private String coursename2;
    private String coursename3;
    private String coursename4;
    private String coursename5;
    private Integer cid;

    public TblCourse() {
    }

    public TblCourse(Integer courseid, Integer coursenum, String coursename1, String coursename2, String coursename3, String coursename4, String coursename5, Integer cid) {
        this.courseid = courseid;
        this.coursenum = coursenum;
        this.coursename1 = coursename1;
        this.coursename2 = coursename2;
        this.coursename3 = coursename3;
        this.coursename4 = coursename4;
        this.coursename5 = coursename5;
        this.cid = cid;
    }

    public Integer getCourseid() {
        return courseid;
    }

    public void setCourseid(Integer courseid) {
        this.courseid = courseid;
    }

    public Integer getCoursenum() {
        return coursenum;
    }

    public void setCoursenum(Integer coursenum) {
        this.coursenum = coursenum;
    }

    public String getCoursename1() {
        return coursename1;
    }

    public void setCoursename1(String coursename1) {
        this.coursename1 = coursename1;
    }

    public String getCoursename2() {
        return coursename2;
    }

    public void setCoursename2(String coursename2) {
        this.coursename2 = coursename2;
    }

    public String getCoursename3() {
        return coursename3;
    }

    public void setCoursename3(String coursename3) {
        this.coursename3 = coursename3;
    }

    public String getCoursename4() {
        return coursename4;
    }

    public void setCoursename4(String coursename4) {
        this.coursename4 = coursename4;
    }

    public String getCoursename5() {
        return coursename5;
    }

    public void setCoursename5(String coursename5) {
        this.coursename5 = coursename5;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblCourse{" +
                "courseid=" + courseid +
                ", coursenum=" + coursenum +
                ", coursename1='" + coursename1 + '\'' +
                ", coursename2='" + coursename2 + '\'' +
                ", coursename3='" + coursename3 + '\'' +
                ", coursename4='" + coursename4 + '\'' +
                ", coursename5='" + coursename5 + '\'' +
                ", cid=" + cid +
                '}';
    }
}
