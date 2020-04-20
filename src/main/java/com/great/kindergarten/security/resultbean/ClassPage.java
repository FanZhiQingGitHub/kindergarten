package com.great.kindergarten.security.resultbean;

/**
 * 直播权限管理班级分页信息表实体类
 */
public class ClassPage {
    private String kindername;
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public ClassPage() {
    }

    public ClassPage(String kindername, Integer page, Integer limit) {
        this.kindername = kindername;
        this.page = page;
        this.limit = limit;
    }

    public String getKindername() {
        return kindername;
    }

    public void setKindername(String kindername) {
        this.kindername = kindername;
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
        return "ClassPage{" +
                "kindername='" + kindername + '\'' +
                ", page=" + page +
                ", limit=" + limit +
                '}';
    }
}
