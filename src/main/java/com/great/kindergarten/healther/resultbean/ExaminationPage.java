package com.great.kindergarten.healther.resultbean;
/**
 * 体检中心列表分页结果类
 */
public class ExaminationPage {
    private String kindername;//园所id
    private String cName;//班级名称
    private Integer page;//从第几条开始
    private Integer limit;//显示几条数据

    public ExaminationPage() {
    }

    public ExaminationPage(String kindername, String cName, Integer page, Integer limit) {
        this.kindername = kindername;
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
        return "ExaminationPage{" +
                "kindername='" + kindername + '\'' +
                ", cName='" + cName + '\'' +
                ", page=" + page +
                ", limit=" + limit +
                '}';
    }
}
