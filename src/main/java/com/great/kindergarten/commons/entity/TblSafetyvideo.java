package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 安全视频表实体类
 */
@Component
public class TblSafetyvideo {
    private Integer safetyvideoid;
    private String safetyvideoname;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date safetyvideotime;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date safetyfinishtime;
    private String safetyvideoplace;
    private Integer mid;
    private String videoname;
    private String videoadd;
    private String safetytestscore;
    private String safetytestresult;

    public TblSafetyvideo() {
    }

    public TblSafetyvideo(Integer safetyvideoid, String safetyvideoname, Date safetyvideotime, Date safetyfinishtime)
    {
        this.safetyvideoid = safetyvideoid;
        this.safetyvideoname = safetyvideoname;
        this.safetyvideotime = safetyvideotime;
        this.safetyfinishtime = safetyfinishtime;
    }

    public TblSafetyvideo(Integer safetyvideoid, String safetyvideoname, Date safetyvideotime, Date safetyfinishtime, String safetyvideoplace, Integer mid, String videoname, String videoadd, String safetytestscore, String safetytestresult)
    {
        this.safetyvideoid = safetyvideoid;
        this.safetyvideoname = safetyvideoname;
        this.safetyvideotime = safetyvideotime;
        this.safetyfinishtime = safetyfinishtime;
        this.safetyvideoplace = safetyvideoplace;
        this.mid = mid;
        this.videoname = videoname;
        this.videoadd = videoadd;
        this.safetytestscore = safetytestscore;
        this.safetytestresult = safetytestresult;
    }

    public Integer getSafetyvideoid()
    {
        return safetyvideoid;
    }

    public void setSafetyvideoid(Integer safetyvideoid)
    {
        this.safetyvideoid = safetyvideoid;
    }

    public String getSafetyvideoname()
    {
        return safetyvideoname;
    }

    public void setSafetyvideoname(String safetyvideoname)
    {
        this.safetyvideoname = safetyvideoname;
    }

    public Date getSafetyvideotime()
    {
        return safetyvideotime;
    }

    public void setSafetyvideotime(Date safetyvideotime)
    {
        this.safetyvideotime = safetyvideotime;
    }

    public Date getSafetyfinishtime()
    {
        return safetyfinishtime;
    }

    public void setSafetyfinishtime(Date safetyfinishtime)
    {
        this.safetyfinishtime = safetyfinishtime;
    }

    public String getSafetyvideoplace()
    {
        return safetyvideoplace;
    }

    public void setSafetyvideoplace(String safetyvideoplace)
    {
        this.safetyvideoplace = safetyvideoplace;
    }

    public Integer getMid()
    {
        return mid;
    }

    public void setMid(Integer mid)
    {
        this.mid = mid;
    }

    public String getVideoname()
    {
        return videoname;
    }

    public void setVideoname(String videoname)
    {
        this.videoname = videoname;
    }

    public String getVideoadd()
    {
        return videoadd;
    }

    public void setVideoadd(String videoadd)
    {
        this.videoadd = videoadd;
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
        return "TblSafetyvideo{" + "safetyvideoid=" + safetyvideoid + ", safetyvideoname='" + safetyvideoname + '\'' + ", safetyvideotime=" + safetyvideotime + ", safetyfinishtime=" + safetyfinishtime + ", safetyvideoplace='" + safetyvideoplace + '\'' + ", mid=" + mid + ", videoname='" + videoname + '\'' + ", videoadd='" + videoadd + '\'' + ", safetytestscore='" + safetytestscore + '\'' + ", safetytestresult='" + safetytestresult + '\'' + '}';
    }
}
