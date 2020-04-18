package com.great.kindergarten.commons.entity;

/**
 * 宝宝考勤详细信息实体类（上下午接送信息）
 */
public class TblStutime {
    private Integer timeamid;
    private String weekinfo;
    private String timeamdate;
    private String timeam;
    private String pnameam;
    private Integer pmid;
    private Integer sid;
    private Integer did;

    private Integer timepmid;
    private String timepmdate;
    private String timepm;
    private String pnamepm;


    public TblStutime() {
    }

    public TblStutime(Integer timeamid, String weekinfo, String timeamdate, String timeam, String pnameam, Integer pmid, Integer sid, Integer did, Integer timepmid, String timepmdate, String timepm, String pnamepm) {
        this.timeamid = timeamid;
        this.weekinfo = weekinfo;
        this.timeamdate = timeamdate;
        this.timeam = timeam;
        this.pnameam = pnameam;
        this.pmid = pmid;
        this.sid = sid;
        this.did = did;
        this.timepmid = timepmid;
        this.timepmdate = timepmdate;
        this.timepm = timepm;
        this.pnamepm = pnamepm;
    }

    public Integer getTimeamid() {
        return timeamid;
    }

    public void setTimeamid(Integer timeamid) {
        this.timeamid = timeamid;
    }

    public String getWeekinfo() {
        return weekinfo;
    }

    public void setWeekinfo(String weekinfo) {
        this.weekinfo = weekinfo;
    }

    public String getTimeamdate() {
        return timeamdate;
    }

    public void setTimeamdate(String timeamdate) {
        this.timeamdate = timeamdate;
    }

    public String getTimeam() {
        return timeam;
    }

    public void setTimeam(String timeam) {
        this.timeam = timeam;
    }

    public String getPnameam() {
        return pnameam;
    }

    public void setPnameam(String pnameam) {
        this.pnameam = pnameam;
    }

    public Integer getPmid() {
        return pmid;
    }

    public void setPmid(Integer pmid) {
        this.pmid = pmid;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getDid() {
        return did;
    }

    public void setDid(Integer did) {
        this.did = did;
    }

    public Integer getTimepmid() {
        return timepmid;
    }

    public void setTimepmid(Integer timepmid) {
        this.timepmid = timepmid;
    }

    public String getTimepmdate() {
        return timepmdate;
    }

    public void setTimepmdate(String timepmdate) {
        this.timepmdate = timepmdate;
    }

    public String getTimepm() {
        return timepm;
    }

    public void setTimepm(String timepm) {
        this.timepm = timepm;
    }

    public String getPnamepm() {
        return pnamepm;
    }

    public void setPnamepm(String pnamepm) {
        this.pnamepm = pnamepm;
    }

    @Override
    public String toString() {
        return "TblStutime{" +
                "timeamid=" + timeamid +
                ", weekinfo='" + weekinfo + '\'' +
                ", timeamdate='" + timeamdate + '\'' +
                ", timeam='" + timeam + '\'' +
                ", pnameam='" + pnameam + '\'' +
                ", pmid=" + pmid +
                ", sid=" + sid +
                ", did=" + did +
                ", timepmid=" + timepmid +
                ", timepmdate='" + timepmdate + '\'' +
                ", timepm='" + timepm + '\'' +
                ", pnamepm='" + pnamepm + '\'' +
                '}';
    }
}
