package com.great.kindergarten.commons.entity;

/**
 * 安全试题表实体类
 */
public class TblSafetytest {
    private Integer safetytestid;
    private String safetytestname;
    private Integer safetytestsonid;
    private String safetytestscore;
    private String safetytestresult;

    public TblSafetytest() {
    }

    public TblSafetytest(Integer safetytestid, String safetytestname, Integer safetytestsonid, String safetytestscore, String safetytestresult) {
        this.safetytestid = safetytestid;
        this.safetytestname = safetytestname;
        this.safetytestsonid = safetytestsonid;
        this.safetytestscore = safetytestscore;
        this.safetytestresult = safetytestresult;
    }

    public Integer getSafetytestid() {
        return safetytestid;
    }

    public void setSafetytestid(Integer safetytestid) {
        this.safetytestid = safetytestid;
    }

    public String getSafetytestname() {
        return safetytestname;
    }

    public void setSafetytestname(String safetytestname) {
        this.safetytestname = safetytestname;
    }

    public Integer getSafetytestsonid() {
        return safetytestsonid;
    }

    public void setSafetytestsonid(Integer safetytestsonid) {
        this.safetytestsonid = safetytestsonid;
    }

    public String getSafetytestscore() {
        return safetytestscore;
    }

    public void setSafetytestscore(String safetytestscore) {
        this.safetytestscore = safetytestscore;
    }

    public String getSafetytestresult() {
        return safetytestresult;
    }

    public void setSafetytestresult(String safetytestresult) {
        this.safetytestresult = safetytestresult;
    }

    @Override
    public String toString() {
        return "TblSafetytest{" +
                "safetytestid=" + safetytestid +
                ", safetytestname='" + safetytestname + '\'' +
                ", safetytestsonid=" + safetytestsonid +
                ", safetytestscore='" + safetytestscore + '\'' +
                ", safetytestresult='" + safetytestresult + '\'' +
                '}';
    }
}
