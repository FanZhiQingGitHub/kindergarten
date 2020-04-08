package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TblAdmin
{
	private Integer adminid;
	private String adminname;
	private String adminpwd;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date createtime;
	private String adminstatus;
	private Integer rid;
	private String code;

	public TblAdmin()
	{
	}

	public Integer getAdminid()
	{
		return adminid;
	}

	public void setAdminid(Integer adminid)
	{
		this.adminid = adminid;
	}

	public String getAdminname()
	{
		return adminname;
	}

	public void setAdminname(String adminname)
	{
		this.adminname = adminname;
	}

	public String getAdminpwd()
	{
		return adminpwd;
	}

	public void setAdminpwd(String adminpwd)
	{
		this.adminpwd = adminpwd;
	}

	public Date getCreatetime()
	{
		return createtime;
	}

	public void setCreatetime(Date createtime)
	{
		this.createtime = createtime;
	}

	public String getAdminstatus()
	{
		return adminstatus;
	}

	public void setAdminstatus(String adminstatus)
	{
		this.adminstatus = adminstatus;
	}

	public Integer getRid()
	{
		return rid;
	}

	public void setRid(Integer rid)
	{
		this.rid = rid;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	@Override
	public String toString()
	{
		return "TblAdmin{" + "adminid=" + adminid + ", adminname='" + adminname + '\'' + ", adminpwd='" + adminpwd + '\'' + ", createtime=" + createtime + ", adminstatus='" + adminstatus + '\'' + ", rid=" + rid + ", code='" + code + '\'' + '}';
	}
}
