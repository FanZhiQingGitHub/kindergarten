package com.great.kindergarten.parent.resultbean;

/**
 * 直播管理分页实体类
 */
public class LivePage {
    private Integer cid;

    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public LivePage() {
    }

    public LivePage(Integer cid, Integer page, Integer limit) {
        this.cid = cid;
        this.page = page;
        this.limit = limit;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
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
        return "LivePage{" +
                "cid=" + cid +
                ", page=" + page +
                ", limit=" + limit +
                '}';
    }
}
