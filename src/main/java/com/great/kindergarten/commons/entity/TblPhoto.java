package com.great.kindergarten.commons.entity;

import org.springframework.stereotype.Component;

/**
 * 相册信息实体类
 */
@Component
public class TblPhoto {
    private Integer photoid;
    private String photoname;
    private String photodetail;
    private String photourl;
    private String phototime;
    private Integer cid;

    public TblPhoto() {
    }

    public TblPhoto(Integer photoid, String photoname, String photodetail, String photourl, String phototime, Integer cid) {
        this.photoid = photoid;
        this.photoname = photoname;
        this.photodetail = photodetail;
        this.photourl = photourl;
        this.phototime = phototime;
        this.cid = cid;
    }

    public Integer getPhotoid() {
        return photoid;
    }

    public void setPhotoid(Integer photoid) {
        this.photoid = photoid;
    }

    public String getPhotoname() {
        return photoname;
    }

    public void setPhotoname(String photoname) {
        this.photoname = photoname;
    }

    public String getPhotodetail() {
        return photodetail;
    }

    public void setPhotodetail(String photodetail) {
        this.photodetail = photodetail;
    }

    public String getPhotourl() {
        return photourl;
    }

    public void setPhotourl(String photourl) {
        this.photourl = photourl;
    }

    public String getPhototime() {
        return phototime;
    }

    public void setPhototime(String phototime) {
        this.phototime = phototime;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblPhoto{" +
                "photoid=" + photoid +
                ", photoname='" + photoname + '\'' +
                ", photodetail='" + photodetail + '\'' +
                ", photourl='" + photourl + '\'' +
                ", phototime='" + phototime + '\'' +
                ", cid=" + cid +
                '}';
    }
}
