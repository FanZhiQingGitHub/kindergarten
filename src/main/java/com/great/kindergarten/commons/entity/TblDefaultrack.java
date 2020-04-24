package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 *
 */
public class TblDefaultrack {
    private Integer detrackid;
    private String lng;
    private String lat;

    private Integer studentid;

    private List<TblDefaultrack> tblDefaultrackList;

    public TblDefaultrack() {
    }

    public TblDefaultrack(Integer detrackid, String lng, String lat) {
        this.detrackid = detrackid;
        this.lng = lng;
        this.lat = lat;
    }

    public Integer getDetrackid() {
        return detrackid;
    }

    public void setDetrackid(Integer detrackid) {
        this.detrackid = detrackid;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public List<TblDefaultrack> getTblDefaultrackList() {
        return tblDefaultrackList;
    }

    public void setTblDefaultrackList(List<TblDefaultrack> tblDefaultrackList) {
        this.tblDefaultrackList = tblDefaultrackList;
    }

    public Integer getStudentid() {
        return studentid;
    }

    public void setStudentid(Integer studentid) {
        this.studentid = studentid;
    }

    @Override
    public String toString() {
        return "TblDefaultrack{" +
                "detrackid=" + detrackid +
                ", lng='" + lng + '\'' +
                ", lat='" + lat + '\'' +
                ", studentid=" + studentid +
                ", tblDefaultrackList=" + tblDefaultrackList +
                '}';
    }
}
