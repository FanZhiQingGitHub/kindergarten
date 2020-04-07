package com.great.kindergarten.director.javabean;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @author JK
 * 园长实体类
 */
@Component(value = "TblRector")
@Scope("prototype")
public class TblRector
{
	private Integer rectorid;
	private String rectorname;
	private String rectorpwd;
	private String rectorsex;
	private Integer rectorage;
	private String rectoradd;
	private String rectorphone;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date rectorregtime;
	private String rectorstatus;
	private Integer rid;

	public Integer getRectorid()
	{
		return rectorid;
	}

	public void setRectorid(Integer rectorid)
	{
		this.rectorid = rectorid;
	}

	public String getRectorname()
	{
		return rectorname;
	}

	public void setRectorname(String rectorname)
	{
		this.rectorname = rectorname;
	}

	public String getRectorpwd()
	{
		return rectorpwd;
	}

	public void setRectorpwd(String rectorpwd)
	{
		this.rectorpwd = rectorpwd;
	}

	public String getRectorsex()
	{
		return rectorsex;
	}

	public void setRectorsex(String rectorsex)
	{
		this.rectorsex = rectorsex;
	}

	public Integer getRectorage()
	{
		return rectorage;
	}

	public void setRectorage(Integer rectorage)
	{
		this.rectorage = rectorage;
	}

	public String getRectoradd()
	{
		return rectoradd;
	}

	public void setRectoradd(String rectoradd)
	{
		this.rectoradd = rectoradd;
	}

	public String getRectorphone()
	{
		return rectorphone;
	}

	public void setRectorphone(String rectorphone)
	{
		this.rectorphone = rectorphone;
	}

	public Date getRectorregtime()
	{
		return rectorregtime;
	}

	public void setRectorregtime(Date rectorregtime)
	{
		this.rectorregtime = rectorregtime;
	}

	public String getRectorstatus()
	{
		return rectorstatus;
	}

	public void setRectorstatus(String rectorstatus)
	{
		this.rectorstatus = rectorstatus;
	}

	public Integer getRid()
	{
		return rid;
	}

	public void setRid(Integer rid)
	{
		this.rid = rid;
	}

	@Override
	public String toString()
	{
		return "TblRector{" + "rectorid=" + rectorid + ", rectorname='" + rectorname + '\'' + ", rectorpwd='" + rectorpwd + '\'' + ", rectorsex='" + rectorsex + '\'' + ", rectorage=" + rectorage + ", rectoradd='" + rectoradd + '\'' + ", rectorphone='" + rectorphone + '\'' + ", rectorregtime=" + rectorregtime + ", rectorstatus='" + rectorstatus + '\'' + ", rid=" + rid + '}';
	}
}
