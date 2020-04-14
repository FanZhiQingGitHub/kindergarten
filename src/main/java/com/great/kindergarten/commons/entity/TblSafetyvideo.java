package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 安全视频表实体类
 */
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

    @Override
    public String toString()
    {
        return "TblSafetyvideo{" + "safetyvideoid=" + safetyvideoid + ", safetyvideoname='" + safetyvideoname + '\'' + ", safetyvideotime=" + safetyvideotime + ", safetyfinishtime=" + safetyfinishtime + ", safetyvideoplace='" + safetyvideoplace + '\'' + ", mid=" + mid + ", videoname='" + videoname + '\'' + ", videoadd='" + videoadd + '\'' + ", safetytestscore='" + safetytestscore + '\'' + ", safetytestresult='" + safetytestresult + '\'' + '}';
    }
}
