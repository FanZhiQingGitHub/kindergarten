package com.great.kindergarten.commons.entity;

/**
 * 班级及监控区域名称关系表实体类
 */
public class TblClamon {
    private Integer clamonid;
    private Integer mnid;//区域名称id
    private Integer cid;//班级id

    public TblClamon() {
    }

    public TblClamon(Integer clamonid, Integer mnid, Integer cid) {
        this.clamonid = clamonid;
        this.mnid = mnid;
        this.cid = cid;
    }

    public Integer getClamonid() {
        return clamonid;
    }

    public void setClamonid(Integer clamonid) {
        this.clamonid = clamonid;
    }

    public Integer getMnid() {
        return mnid;
    }

    public void setMnid(Integer mnid) {
        this.mnid = mnid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblClamon{" +
                "clamonid=" + clamonid +
                ", mnid=" + mnid +
                ", cid=" + cid +
                '}';
    }
}
