package com.great.kindergarten.security.resultbean;

import java.util.List;

/**
 * 监控区域权限配置树形组件信息类
 */
public class MonitorTreeInfo {
    private  String title;
    private  Integer id;

    public MonitorTreeInfo() {
    }

    public MonitorTreeInfo(String title, Integer id) {
        this.title = title;
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "MonitorTreeInfo{" +
                "title='" + title + '\'' +
                ", id=" + id +
                '}';
    }
}
