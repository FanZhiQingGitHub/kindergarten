package com.great.kindergarten.security.resultbean;

/**
 * 报警日志信息分页实体类
 */
public class AlarmLogPage {
    private Object time1;
    private Object time2;
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public AlarmLogPage() {
    }

    public AlarmLogPage(Object time1, Object time2, Integer page, Integer limit) {
        this.time1 = time1;
        this.time2 = time2;
        this.page = page;
        this.limit = limit;
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
        return "AlarmLogPage{" +
                "time1=" + time1 +
                ", time2=" + time2 +
                ", page=" + page +
                ", limit=" + limit +
                '}';
    }
}
