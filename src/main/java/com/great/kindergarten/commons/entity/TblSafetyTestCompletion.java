package com.great.kindergarten.commons.entity;

/**
 * 安全试题完成情况表
 */
public class TblSafetyTestCompletion
{
    private Integer safetytestid;
    private String safetyvideoid;
    private Integer parentid;
    private String safetytestscore;
    private String safetytestresult;

    public TblSafetyTestCompletion() {
    }

    public TblSafetyTestCompletion(Integer safetytestid, String safetyvideoid, Integer parentid, String safetytestscore, String safetytestresult)
    {
        this.safetytestid = safetytestid;
        this.safetyvideoid = safetyvideoid;
        this.parentid = parentid;
        this.safetytestscore = safetytestscore;
        this.safetytestresult = safetytestresult;
    }


    public Integer getSafetytestid()
    {
        return safetytestid;
    }

    public void setSafetytestid(Integer safetytestid)
    {
        this.safetytestid = safetytestid;
    }

    public String getSafetyvideoid()
    {
        return safetyvideoid;
    }

    public void setSafetyvideoid(String safetyvideoid)
    {
        this.safetyvideoid = safetyvideoid;
    }

    public Integer getParentid()
    {
        return parentid;
    }

    public void setParentid(Integer parentid)
    {
        this.parentid = parentid;
    }

    public String getSafetytestscore()
    {
        return safetytestscore;
    }

    public void setSafetytestscore(String safetytestscore)
    {
        this.safetytestscore = safetytestscore;
    }

    public String getSafetytestresult()
    {
        return safetytestresult;
    }

    public void setSafetytestresult(String safetytestresult)
    {
        this.safetytestresult = safetytestresult;
    }


    @Override
    public String toString()
    {
        return "TblSafetyTestCompletion{" + "safetytestid=" + safetytestid + ", safetyvideoid='" + safetyvideoid + '\'' + ", parentid=" + parentid + ", safetytestscore='" + safetytestscore + '\'' + ", safetytestresult='" + safetytestresult + '\'' + '}';
    }
}
