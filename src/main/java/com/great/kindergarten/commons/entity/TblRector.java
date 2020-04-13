package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
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
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date rectorregtime;
	private String rectorstatus;
	private Integer rid;
	private String time1;
	private String time2;

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
		return "TblRector{" + "rectorid=" + rectorid + ", rectorname='" + rectorname + '\'' + ", rectorpwd='" + rectorpwd + '\'' + ", rectorsex='" + rectorsex + '\'' + ", rectorage=" + rectorage + ", rectoradd='" + rectoradd + '\'' + ", rectorphone='" + rectorphone + '\'' + ", rectorregtime=" + rectorregtime + ", rectorstatus='" + rectorstatus + '\'' + ", rid=" + rid + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + '}';
	}
}
