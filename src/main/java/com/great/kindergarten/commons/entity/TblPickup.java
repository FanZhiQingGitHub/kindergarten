package com.great.kindergarten.commons.entity;

/**
 * 接送信息表实体类
 */
public class TblPickup {
    private Integer pickupid;
    private Integer sid;
    private Integer cid;

    public TblPickup() {
    }

    public TblPickup(Integer pickupid, Integer sid, Integer cid) {
        this.pickupid = pickupid;
        this.sid = sid;
        this.cid = cid;
    }

    public Integer getPickupid() {
        return pickupid;
    }

    public void setPickupid(Integer pickupid) {
        this.pickupid = pickupid;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblPickup{" +
                "pickupid=" + pickupid +
                ", sid=" + sid +
                ", cid=" + cid +
                '}';
    }
}
