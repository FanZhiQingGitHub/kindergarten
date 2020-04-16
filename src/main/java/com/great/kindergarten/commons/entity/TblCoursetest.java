package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author JK
 */
public class TblCoursetest
{
	private Integer ctid;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date mondaydate;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date sundaydate;

	public Integer getCtid()
	{
		return ctid;
	}

	public void setCtid(Integer ctid)
	{
		this.ctid = ctid;
	}

	public Date getMondaydate()
	{
		return mondaydate;
	}

	public void setMondaydate(Date mondaydate)
	{
		this.mondaydate = mondaydate;
	}

	public Date getSundaydate()
	{
		return sundaydate;
	}

	public void setSundaydate(Date sundaydate)
	{
		this.sundaydate = sundaydate;
	}

	@Override
	public String toString()
	{
		return "TblCoursetest{" + "ctid=" + ctid + ", mondaydate=" + mondaydate + ", sundaydate=" + sundaydate + '}';
	}
}
