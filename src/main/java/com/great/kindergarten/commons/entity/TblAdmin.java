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
	private String adminsex;
	private String adminphone;
	private String adminheadurl;
	private Integer rid;
	private String code;
	private TblRole tblRole;
	private Integer roleid;
	private String rolename;
	private String time1;
	private String time2;

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

	public String getAdminsex()
	{
		return adminsex;
	}

	public void setAdminsex(String adminsex)
	{
		this.adminsex = adminsex;
	}

	public String getAdminphone()
	{
		return adminphone;
	}

	public void setAdminphone(String adminphone)
	{
		this.adminphone = adminphone;
	}

	public String getAdminheadurl()
	{
		return adminheadurl;
	}

	public void setAdminheadurl(String adminheadurl)
	{
		this.adminheadurl = adminheadurl;
	}

	public TblRole getTblRole()
	{
		return tblRole;
	}

	public void setTblRole(TblRole tblRole)
	{
		this.tblRole = tblRole;
	}

	public Integer getRoleid()
	{
		return roleid;
	}

	public void setRoleid(Integer roleid)
	{
		this.roleid = roleid;
	}

	public String getRolename()
	{
		return rolename;
	}

	public void setRolename(String rolename)
	{
		this.rolename = rolename;
	}

	public String getTime1()
	{
		return time1;
	}

	public void setTime1(String time1)
	{
		this.time1 = time1;
	}

	public String getTime2()
	{
		return time2;
	}

	public void setTime2(String time2)
	{
		this.time2 = time2;
	}

	@Override
	public String toString()
	{
		return "TblAdmin{" + "adminid=" + adminid + ", adminname='" + adminname + '\'' + ", adminpwd='" + adminpwd + '\'' + ", createtime=" + createtime + ", adminstatus='" + adminstatus + '\'' + ", adminsex='" + adminsex + '\'' + ", adminphone='" + adminphone + '\'' + ", adminheadurl='" + adminheadurl + '\'' + ", rid=" + rid + ", code='" + code + '\'' + ", tblRole=" + tblRole + ", roleid=" + roleid + ", rolename='" + rolename + '\'' + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + '}';
	}
}
