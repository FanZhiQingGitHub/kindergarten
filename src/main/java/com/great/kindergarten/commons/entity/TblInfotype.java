package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

/**
 * 资讯类型表
 */
public class TblInfotype {
    private Integer infotypeid;
    private String infotypename;
    private Integer kid;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date infotypetime;

    public TblInfotype() {
    }

    public TblInfotype(Integer infotypeid, String infotypename) {
        this.infotypeid = infotypeid;
        this.infotypename = infotypename;
    }

    public Integer getInfotypeid() {
        return infotypeid;
    }

    public void setInfotypeid(Integer infotypeid) {
        this.infotypeid = infotypeid;
    }

    public String getInfotypename() {
        return infotypename;
    }

    public void setInfotypename(String infotypename) {
        this.infotypename = infotypename;
    }

    public Integer getKid()
    {
        return kid;
    }

    public void setKid(Integer kid)
    {
        this.kid = kid;
    }

    public Date getInfotypetime()
    {
        return infotypetime;
    }

    public void setInfotypetime(Date infotypetime)
    {
        this.infotypetime = infotypetime;
    }

    @Override
    public String toString()
    {
        return "TblInfotype{" + "infotypeid=" + infotypeid + ", infotypename='" + infotypename + '\'' + ", kid=" + kid + ", infotypetime=" + infotypetime + '}';
    }
}
