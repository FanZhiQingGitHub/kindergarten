package com.great.kindergarten.healther.resultbean;

/**
 * 膳食表时间区间实体信息分页类
 */
public class MealPage {
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public MealPage() {
    }

    public MealPage(Integer page, Integer limit) {
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
        return "MealPage{" +
                "page=" + page +
                ", limit=" + limit +
                '}';
    }
}
