package com.great.kindergarten.commons.entity;

/**
 * 安全视频试题实体信息类
 */
public class TblSafetyvtq {
    private Integer safetyvtqid;
    private String safetyvtqname;
    private String a;
    private String avalue;
    private String b;
    private String bvalue;
    private String c;
    private String cvalue;
    private String d;
    private String dvalue;
    private Integer safetyvideoid;

    public TblSafetyvtq() {
    }

    public TblSafetyvtq(Integer safetyvtqid, String safetyvtqname, String a, String avalue, String b, String bvalue, String c, String cvalue, String d, String dvalue, Integer safetyvideoid)
    {
        this.safetyvtqid = safetyvtqid;
        this.safetyvtqname = safetyvtqname;
        this.a = a;
        this.avalue = avalue;
        this.b = b;
        this.bvalue = bvalue;
        this.c = c;
        this.cvalue = cvalue;
        this.d = d;
        this.dvalue = dvalue;
        this.safetyvideoid = safetyvideoid;
    }

    public Integer getSafetyvtqid()
    {
        return safetyvtqid;
    }

    public void setSafetyvtqid(Integer safetyvtqid)
    {
        this.safetyvtqid = safetyvtqid;
    }

    public String getSafetyvtqname()
    {
        return safetyvtqname;
    }

    public void setSafetyvtqname(String safetyvtqname)
    {
        this.safetyvtqname = safetyvtqname;
    }

    public String getA()
    {
        return a;
    }

    public void setA(String a)
    {
        this.a = a;
    }

    public String getAvalue()
    {
        return avalue;
    }

    public void setAvalue(String avalue)
    {
        this.avalue = avalue;
    }

    public String getB()
    {
        return b;
    }

    public void setB(String b)
    {
        this.b = b;
    }

    public String getBvalue()
    {
        return bvalue;
    }

    public void setBvalue(String bvalue)
    {
        this.bvalue = bvalue;
    }

    public String getC()
    {
        return c;
    }

    public void setC(String c)
    {
        this.c = c;
    }

    public String getCvalue()
    {
        return cvalue;
    }

    public void setCvalue(String cvalue)
    {
        this.cvalue = cvalue;
    }

    public String getD()
    {
        return d;
    }

    public void setD(String d)
    {
        this.d = d;
    }

    public String getDvalue()
    {
        return dvalue;
    }

    public void setDvalue(String dvalue)
    {
        this.dvalue = dvalue;
    }

    public Integer getSafetyvideoid()
    {
        return safetyvideoid;
    }

    public void setSafetyvideoid(Integer safetyvideoid)
    {
        this.safetyvideoid = safetyvideoid;
    }

    @Override
    public String toString()
    {
        return "TblSafetyvtq{" + "safetyvtqid=" + safetyvtqid + ", safetyvtqname='" + safetyvtqname + '\'' + ", a='" + a + '\'' + ", avalue='" + avalue + '\'' + ", b='" + b + '\'' + ", bvalue='" + bvalue + '\'' + ", c='" + c + '\'' + ", cvalue='" + cvalue + '\'' + ", d='" + d + '\'' + ", dvalue='" + dvalue + '\'' + ", safetyvideoid=" + safetyvideoid + '}';
    }
}
