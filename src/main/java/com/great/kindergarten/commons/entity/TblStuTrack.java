package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 * 电子围栏顶点坐标实体类
 */
public class TblStuTrack {
    private Integer trackid;
    private String lng;
    private String lat;
    private Integer stuid;


    public TblStuTrack() {
    }

    public TblStuTrack(Integer trackid, String lng, String lat, Integer stuid) {
        this.trackid = trackid;
        this.lng = lng;
        this.lat = lat;
        this.stuid = stuid;
    }

    public Integer getTrackid() {
        return trackid;
    }

    public void setTrackid(Integer trackid) {
        this.trackid = trackid;
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

    public Integer getStuid() {
        return stuid;
    }

    public void setStuid(Integer stuid) {
        this.stuid = stuid;
    }

    @Override
    public String toString() {
        return "TblStuTrack{" +
                "trackid=" + trackid +
                ", lng='" + lng + '\'' +
                ", lat='" + lat + '\'' +
                ", stuid=" + stuid +
                '}';
    }
}
