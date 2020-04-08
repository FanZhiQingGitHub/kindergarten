package com.great.kindergarten.commons.entity;

/**
 * 安全视频试题实体信息类
 */
public class TblSafetyvtq {
    private Integer safetyvtqid;
    private String safetyvtqname;
    private Integer safetyvtqsonid;
    private Integer safetyvtqscore;
    private String safetyvtqresult;
    private Integer sid;

    public TblSafetyvtq() {
    }

    public TblSafetyvtq(Integer safetyvtqid, String safetyvtqname, Integer safetyvtqsonid, Integer safetyvtqscore, String safetyvtqresult, Integer sid) {
        this.safetyvtqid = safetyvtqid;
        this.safetyvtqname = safetyvtqname;
        this.safetyvtqsonid = safetyvtqsonid;
        this.safetyvtqscore = safetyvtqscore;
        this.safetyvtqresult = safetyvtqresult;
        this.sid = sid;
    }

    public Integer getSafetyvtqid() {
        return safetyvtqid;
    }

    public void setSafetyvtqid(Integer safetyvtqid) {
        this.safetyvtqid = safetyvtqid;
    }

    public String getSafetyvtqname() {
        return safetyvtqname;
    }

    public void setSafetyvtqname(String safetyvtqname) {
        this.safetyvtqname = safetyvtqname;
    }

    public Integer getSafetyvtqsonid() {
        return safetyvtqsonid;
    }

    public void setSafetyvtqsonid(Integer safetyvtqsonid) {
        this.safetyvtqsonid = safetyvtqsonid;
    }

    public Integer getSafetyvtqscore() {
        return safetyvtqscore;
    }

    public void setSafetyvtqscore(Integer safetyvtqscore) {
        this.safetyvtqscore = safetyvtqscore;
    }

    public String getSafetyvtqresult() {
        return safetyvtqresult;
    }

    public void setSafetyvtqresult(String safetyvtqresult) {
        this.safetyvtqresult = safetyvtqresult;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    @Override
    public String toString() {
        return "TblSafetyvtq{" +
                "safetyvtqid=" + safetyvtqid +
                ", safetyvtqname='" + safetyvtqname + '\'' +
                ", safetyvtqsonid=" + safetyvtqsonid +
                ", safetyvtqscore=" + safetyvtqscore +
                ", safetyvtqresult='" + safetyvtqresult + '\'' +
                ", sid=" + sid +
                '}';
    }
}
