package com.great.kindergarten.security.resultbean;

/**
 * 直播管理分页实体类
 */
public class MonitorPage {
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public MonitorPage() {
    }

    public MonitorPage(Integer page, Integer limit) {
        this.page = page;
        this.limit = limit;
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
                "page=" + page +
                ", limit=" + limit +
                '}';
    }
}
