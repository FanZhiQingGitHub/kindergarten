package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 消息信息实体类(聊天这些)
 */
public class TblMsg {
    private Integer msgid;
    private String msgdetail;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date msgtime;
    private Integer pid;
    private Integer tid;
    private Integer kid;
    private Integer cid;

    public TblMsg() {
    }

    public TblMsg(Integer msgid, String msgdetail, Date msgtime, Integer pid, Integer tid, Integer kid, Integer cid) {
        this.msgid = msgid;
        this.msgdetail = msgdetail;
        this.msgtime = msgtime;
        this.pid = pid;
        this.tid = tid;
        this.kid = kid;
        this.cid = cid;
    }

    public Integer getMsgid() {
        return msgid;
    }

    public void setMsgid(Integer msgid) {
        this.msgid = msgid;
    }

    public String getMsgdetail() {
        return msgdetail;
    }

    public void setMsgdetail(String msgdetail) {
        this.msgdetail = msgdetail;
    }

    public Date getMsgtime() {
        return msgtime;
    }

    public void setMsgtime(Date msgtime) {
        this.msgtime = msgtime;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    @Override
    public String toString() {
        return "TblMsg{" +
                "msgid=" + msgid +
                ", msgdetail='" + msgdetail + '\'' +
                ", msgtime=" + msgtime +
                ", pid=" + pid +
                ", tid=" + tid +
                ", kid=" + kid +
                ", cid=" + cid +
                '}';
    }
}
