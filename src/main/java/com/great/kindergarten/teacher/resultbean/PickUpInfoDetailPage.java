package com.great.kindergarten.teacher.resultbean;

/**
 * 接送详细信息实体信息分页类
 */
public class PickUpInfoDetailPage {

    private Integer studentid;
    private String mondaydate;
    private String sundaydate;

    public PickUpInfoDetailPage() {
    }

    public PickUpInfoDetailPage(Integer studentid, String mondaydate, String sundaydate) {
        this.studentid = studentid;
        this.mondaydate = mondaydate;
        this.sundaydate = sundaydate;
    }

    public Integer getStudentid() {
        return studentid;
    }

    public void setStudentid(Integer studentid) {
        this.studentid = studentid;
    }

    public String getMondaydate() {
        return mondaydate;
    }

    public void setMondaydate(String mondaydate) {
        this.mondaydate = mondaydate;
    }

    public String getSundaydate() {
        return sundaydate;
    }

    public void setSundaydate(String sundaydate) {
        this.sundaydate = sundaydate;
    }

    @Override
    public String toString() {
        return "PickUpInfoDetailPage{" +
                "studentid=" + studentid +
                ", mondaydate='" + mondaydate + '\'' +
                ", sundaydate='" + sundaydate + '\'' +
                '}';
    }
}
