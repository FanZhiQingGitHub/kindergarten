package com.great.kindergarten.commons.entity;

/**
 * 参数表信息实体类
 */
public class TblParameter {
    private Integer parameterid;
    private String parametername;
    private String parameterval;
    private String parametertype;
    private Integer stid;
    private Integer svid;

    public TblParameter() {
    }

    public TblParameter(Integer parameterid, String parametername, String parameterval, String parametertype, Integer stid, Integer svid) {
        this.parameterid = parameterid;
        this.parametername = parametername;
        this.parameterval = parameterval;
        this.parametertype = parametertype;
        this.stid = stid;
        this.svid = svid;
    }

    public Integer getParameterid() {
        return parameterid;
    }

    public void setParameterid(Integer parameterid) {
        this.parameterid = parameterid;
    }

    public String getParametername() {
        return parametername;
    }

    public void setParametername(String parametername) {
        this.parametername = parametername;
    }

    public String getParameterval() {
        return parameterval;
    }

    public void setParameterval(String parameterval) {
        this.parameterval = parameterval;
    }

    public String getParametertype() {
        return parametertype;
    }

    public void setParametertype(String parametertype) {
        this.parametertype = parametertype;
    }

    public Integer getStid() {
        return stid;
    }

    public void setStid(Integer stid) {
        this.stid = stid;
    }

    public Integer getSvid() {
        return svid;
    }

    public void setSvid(Integer svid) {
        this.svid = svid;
    }

    @Override
    public String toString() {
        return "TblParameter{" +
                "parameterid=" + parameterid +
                ", parametername='" + parametername + '\'' +
                ", parameterval='" + parameterval + '\'' +
                ", parametertype='" + parametertype + '\'' +
                ", stid=" + stid +
                ", svid=" + svid +
                '}';
    }
}
