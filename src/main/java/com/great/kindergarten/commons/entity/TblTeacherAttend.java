package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/*教师考勤时间表*/
@Component(value = "TblTeacherAttend")
@Scope("prototype")
public class TblTeacherAttend
{
	private Integer tattendid;
	private String tattendbegin;
	private String tattendover;
	private Integer tid;

	private Integer teacherid;
	private String teachername;
	private String teacherjob;

	private String classname;

	public Integer getTattendid()
	{
		return tattendid;
	}

	public void setTattendid(Integer tattendid)
	{
		this.tattendid = tattendid;
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

	public Integer getTid()
	{
		return tid;
	}

	public void setTid(Integer tid)
	{
		this.tid = tid;
	}

	public String getTeachername()
	{
		return teachername;
	}

	public void setTeachername(String teachername)
	{
		this.teachername = teachername;
	}

	public String getTeacherjob()
	{
		return teacherjob;
	}

	public void setTeacherjob(String teacherjob)
	{
		this.teacherjob = teacherjob;
	}

	public Integer getTeacherid()
	{
		return teacherid;
	}

	public void setTeacherid(Integer teacherid)
	{
		this.teacherid = teacherid;
	}

	public String getClassname()
	{
		return classname;
	}

	public void setClassname(String classname)
	{
		this.classname = classname;
	}

	@Override
	public String toString()
	{
		return "TblTeacherAttend{" + "tattendid=" + tattendid + ", tattendbegin='" + tattendbegin + '\'' + ", tattendover='" + tattendover + '\'' + ", tid='" + tid + '\'' + ", teachername='" + teachername + '\'' + ", teacherjob='" + teacherjob + '\'' + '}';
	}
}
