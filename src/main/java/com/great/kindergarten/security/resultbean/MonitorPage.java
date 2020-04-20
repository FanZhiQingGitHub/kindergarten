package com.great.kindergarten.security.resultbean;

/**
 * 直播管理分页实体类
 */
public class MonitorPage {
    private String kindername;
    private Object time1;
    private Object time2;
    private String monitormvname;
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public MonitorPage() {
    }

    public MonitorPage(String kindername, Object time1, Object time2, String monitormvname, Integer page, Integer limit) {
        this.kindername = kindername;
        this.time1 = time1;
        this.time2 = time2;
        this.monitormvname = monitormvname;
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

    public String getMonitormvname() {
        return monitormvname;
    }

    public void setMonitormvname(String monitormvname) {
        this.monitormvname = monitormvname;
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
        return "MonitorPage{" +
                "kindername='" + kindername + '\'' +
                ", time1=" + time1 +
                ", time2=" + time2 +
                ", monitormvname='" + monitormvname + '\'' +
                ", page=" + page +
                ", limit=" + limit +
                '}';
    }
}
