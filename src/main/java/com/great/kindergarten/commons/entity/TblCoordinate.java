package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 * 电子围栏顶点坐标实体类
 */
public class TblCoordinate {
    private Integer coordinateid;
    private String lng;
    private String lat;
    private Integer kinderid;

    private List<TblCoordinate> coordinatelist;

    public TblCoordinate() {
    }

    public TblCoordinate(Integer coordinateid, String lng, String lat, Integer kinderid) {
        this.coordinateid = coordinateid;
        this.lng = lng;
        this.lat = lat;
        this.kinderid = kinderid;
    }

    public Integer getCoordinateid() {
        return coordinateid;
    }

    public void setCoordinateid(Integer coordinateid) {
        this.coordinateid = coordinateid;
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

    public List<TblCoordinate> getCoordinatelist() {
        return coordinatelist;
    }

    public void setCoordinatelist(List<TblCoordinate> coordinatelist) {
        this.coordinatelist = coordinatelist;
    }

    public Integer getKinderid() {
        return kinderid;
    }

    public void setKinderid(Integer kinderid) {
        this.kinderid = kinderid;
    }

    @Override
    public String toString() {
        return "TblCoordinate{" +
                "coordinateid=" + coordinateid +
                ", lng='" + lng + '\'' +
                ", lat='" + lat + '\'' +
                ", kinderid=" + kinderid +
                ", coordinatelist=" + coordinatelist +
                '}';
    }
}
