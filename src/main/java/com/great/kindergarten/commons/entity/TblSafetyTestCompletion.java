package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

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
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date safetytestfinishtime;
    private Integer safetyconfigid;


    public TblSafetyTestCompletion() {
    }

    public TblSafetyTestCompletion(Integer safetytestid, String safetyvideoid, Integer parentid, String safetytestscore, String safetytestresult, Date safetytestfinishtime, Integer safetyconfigid)
    {
        this.safetytestid = safetytestid;
        this.safetyvideoid = safetyvideoid;
        this.parentid = parentid;
        this.safetytestscore = safetytestscore;
        this.safetytestresult = safetytestresult;
        this.safetytestfinishtime = safetytestfinishtime;
        this.safetyconfigid = safetyconfigid;
    }

    public Integer getSafetyconfigid()
    {
        return safetyconfigid;
    }

    public void setSafetyconfigid(Integer safetyconfigid)
    {
        this.safetyconfigid = safetyconfigid;
    }

    public Date getSafetytestfinishtime()
    {
        return safetytestfinishtime;
    }

    public void setSafetytestfinishtime(Date safetytestfinishtime)
    {
        this.safetytestfinishtime = safetytestfinishtime;
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
        return "TblSafetyTestCompletion{" + "safetytestid=" + safetytestid + ", safetyvideoid='" + safetyvideoid + '\'' + ", parentid=" + parentid + ", safetytestscore='" + safetytestscore + '\'' + ", safetytestresult='" + safetytestresult + '\'' + ", safetytestfinishtime=" + safetytestfinishtime + ", safetyconfigid=" + safetyconfigid + '}';
    }
}
