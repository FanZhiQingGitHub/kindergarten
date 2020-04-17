package com.great.kindergarten.commons.entity;

/**
 * 资讯类型表
 */
public class TblInfotype {
    private Integer infotypeid;
    private String infotypename;

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

    @Override
    public String toString() {
        return "TblInfotype{" +
                "infotypeid=" + infotypeid +
                ", infotypename='" + infotypename + '\'' +
                '}';
    }
}
