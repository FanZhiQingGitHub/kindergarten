package com.great.kindergarten.commons.entity;

/**
 * 班级消息通知表
 */
public class TblClamsg {
    private Integer clamsgid;
    private String clamsgdetail;
    private Integer cid;

    public TblClamsg() {
    }

    public TblClamsg(Integer clamsgid, String clamsgdetail, Integer cid) {
        this.clamsgid = clamsgid;
        this.clamsgdetail = clamsgdetail;
        this.cid = cid;
    }

    public Integer getClamsgid() {
        return clamsgid;
    }

    public void setClamsgid(Integer clamsgid) {
        this.clamsgid = clamsgid;
    }

    public String getClamsgdetail() {
        return clamsgdetail;
    }

    public void setClamsgdetail(String clamsgdetail) {
        this.clamsgdetail = clamsgdetail;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblClamsg{" +
                "clamsgid=" + clamsgid +
                ", clamsgdetail='" + clamsgdetail + '\'' +
                ", cid=" + cid +
                '}';
    }
}
