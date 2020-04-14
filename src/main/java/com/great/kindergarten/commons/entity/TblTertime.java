package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 教师考勤信息表实体类
 */
public class TblTertime
{
	private Integer tertimeid;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date tertime;
	private String tertimedate1;
	private String tertimedate2;
	private Integer tid;

	private String tattendbegin;
	private String tattendover;

	public Integer getTertimeid()
	{
		return tertimeid;
	}

	public void setTertimeid(Integer tertimeid)
	{
		this.tertimeid = tertimeid;
	}

	public Date getTertime()
	{
		return tertime;
	}

	public void setTertime(Date tertime)
	{
		this.tertime = tertime;
	}

	public String getTertimedate1()
	{
		return tertimedate1;
	}

	public void setTertimedate1(String tertimedate1)
	{
		this.tertimedate1 = tertimedate1;
	}

	public String getTertimedate2()
	{
		return tertimedate2;
	}

	public void setTertimedate2(String tertimedate2)
	{
		this.tertimedate2 = tertimedate2;
	}

	public Integer getTid()
	{
		return tid;
	}

	public void setTid(Integer tid)
	{
		this.tid = tid;
	}

	public String getTattendbegin()
	{
		return tattendbegin;
	}

	public void setTattendbegin(String tattendbegin)
	{
		this.tattendbegin = tattendbegin;
	}

	public String getTattendover()
	{
		return tattendover;
	}

	public void setTattendover(String tattendover)
	{
		this.tattendover = tattendover;
	}

	@Override
	public String toString()
	{
		return "TblTertime{" + "tertimeid=" + tertimeid + ", tertime=" + tertime + ", tertimedate1='" + tertimedate1 + '\'' + ", tertimedate2='" + tertimedate2 + '\'' + ", tid=" + tid + '}';
	}
}
