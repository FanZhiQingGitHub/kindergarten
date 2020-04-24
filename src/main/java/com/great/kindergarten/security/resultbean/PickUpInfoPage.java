package com.great.kindergarten.security.resultbean;

/**
 * 接送信息管理实体信息分页类
 */
public class PickUpInfoPage {
    private String kindername;
    private Object time1;
    private Object time2;
    private String uStuName;
    private String cName;
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public PickUpInfoPage() {
    }

    public PickUpInfoPage(String kindername, Object time1, Object time2, String uStuName, String cName, Integer page, Integer limit) {
        this.kindername = kindername;
        this.time1 = time1;
        this.time2 = time2;
        this.uStuName = uStuName;
        this.cName = cName;
        this.page = page;
        this.limit = limit;
    }

    public String getKindername() {
        return kindername;
    }

    public void setKindername(String kindername) {
        this.kindername = kindername;
    }

    public Object getTime1() {
        return time1;
    }

    public void setTime1(Object time1) {
        this.time1 = time1;
    }

    public Object getTime2() {
        return time2;
    }

    public void setTime2(Object time2) {
        this.time2 = time2;
    }

    public String getuStuName() {
        return uStuName;
    }

    public void setuStuName(String uStuName) {
        this.uStuName = uStuName;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    @Override
    public String toString() {
        return "PickUpInfoPage{" +
                "kindername='" + kindername + '\'' +
                ", time1=" + time1 +
                ", time2=" + time2 +
                ", uStuName='" + uStuName + '\'' +
                ", cName='" + cName + '\'' +
                ", page=" + page +
                ", limit=" + limit +
                '}';
    }
}
