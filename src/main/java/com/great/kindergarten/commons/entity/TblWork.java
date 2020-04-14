package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 提交作业信息表实体类
 */
public class TblWork {
    private Integer workid;
    private String workreleaseid;
    private String workreleasedetail;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date workreleasetime;
    private String workurl;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date wfinishtime;
    private String worklocation;
    private String workresult;
    private String workeva;
    private Integer sid;
    private String studentname;
    private Integer pid;
    private String parentname;
    private Integer cid;


    public TblWork()
    {

    }

    public TblWork(Integer workid, String workreleaseid, String workreleasedetail, Date workreleasetime, String workurl, Date wfinishtime, String worklocation, String workresult, String workeva, Integer sid, String studentname, Integer pid, String parentname, Integer cid)
    {
        this.workid = workid;
        this.workreleaseid = workreleaseid;
        this.workreleasedetail = workreleasedetail;
        this.workreleasetime = workreleasetime;
        this.workurl = workurl;
        this.wfinishtime = wfinishtime;
        this.worklocation = worklocation;
        this.workresult = workresult;
        this.workeva = workeva;
        this.sid = sid;
        this.studentname = studentname;
        this.pid = pid;
        this.parentname = parentname;
        this.cid = cid;
    }

    public String getWorkreleasedetail()
    {
        return workreleasedetail;
    }

    public void setWorkreleasedetail(String workreleasedetail)
    {
        this.workreleasedetail = workreleasedetail;
    }

    public String getWorklocation()
    {
        return worklocation;
    }

    public void setWorklocation(String worklocation)
    {
        this.worklocation = worklocation;
    }

    public Date getWorkreleasetime()
    {
        return workreleasetime;
    }

    public void setWorkreleasetime(Date workreleasetime)
    {
        this.workreleasetime = workreleasetime;
    }

    public Integer getWorkid()
    {
        return workid;
    }

    public void setWorkid(Integer workid)
    {
        this.workid = workid;
    }

    public String getWorkreleaseid()
    {
        return workreleaseid;
    }

    public void setWorkreleaseid(String workreleaseid)
    {
        this.workreleaseid = workreleaseid;
    }

    public String getWorkurl()
    {
        return workurl;
    }

    public void setWorkurl(String workurl)
    {
        this.workurl = workurl;
    }

    public Date getWfinishtime()
    {
        return wfinishtime;
    }

    public void setWfinishtime(Date wfinishtime)
    {
        this.wfinishtime = wfinishtime;
    }

    public String getWorkresult()
    {
        return workresult;
    }

    public void setWorkresult(String workresult)
    {
        this.workresult = workresult;
    }

    public String getWorkeva()
    {
        return workeva;
    }

    public void setWorkeva(String workeva)
    {
        this.workeva = workeva;
    }

    public Integer getSid()
    {
        return sid;
    }

    public void setSid(Integer sid)
    {
        this.sid = sid;
    }

    public String getStudentname()
    {
        return studentname;
    }

    public void setStudentname(String studentname)
    {
        this.studentname = studentname;
    }

    public Integer getPid()
    {
        return pid;
    }

    public void setPid(Integer pid)
    {
        this.pid = pid;
    }

    public String getParentname()
    {
        return parentname;
    }

    public void setParentname(String parentname)
    {
        this.parentname = parentname;
    }

    public Integer getCid()
    {
        return cid;
    }

    public void setCid(Integer cid)
    {
        this.cid = cid;
    }


    @Override
    public String toString()
    {
        return "TblWork{" + "workid=" + workid + ", workreleaseid='" + workreleaseid + '\'' + ", workreleasedetail='" + workreleasedetail + '\'' + ", workreleasetime=" + workreleasetime + ", workurl='" + workurl + '\'' + ", wfinishtime=" + wfinishtime + ", worklocation='" + worklocation + '\'' + ", workresult='" + workresult + '\'' + ", workeva='" + workeva + '\'' + ", sid=" + sid + ", studentname='" + studentname + '\'' + ", pid=" + pid + ", parentname='" + parentname + '\'' + ", cid=" + cid + '}';
    }
}
