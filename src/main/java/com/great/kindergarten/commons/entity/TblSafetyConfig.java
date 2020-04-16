package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @author MI
 * @date 2020/4/15 12:04
 */
@Component
public class TblSafetyConfig
{
	private Integer safetyconfigid;
	private Integer safetyvideoid;
	private String safetyvideoname;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date safetyvideotime;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date safetyfinishtime;
	private Integer classid;
	private String classname;


	public TblSafetyConfig()
	{
	}

	public TblSafetyConfig(Integer safetyconfigid, Integer safetyvideoid, String safetyvideoname, Date safetyvideotime, Date safetyfinishtime, Integer classid, String classname)
	{
		this.safetyconfigid = safetyconfigid;
		this.safetyvideoid = safetyvideoid;
		this.safetyvideoname = safetyvideoname;
		this.safetyvideotime = safetyvideotime;
		this.safetyfinishtime = safetyfinishtime;
		this.classid = classid;
		this.classname = classname;
	}

	public String getClassname()
	{
		return classname;
	}

	public void setClassname(String classname)
	{
		this.classname = classname;
	}

	public Integer getSafetyconfigid()
	{
		return safetyconfigid;
	}

	public void setSafetyconfigid(Integer safetyconfigid)
	{
		this.safetyconfigid = safetyconfigid;
	}

	public Integer getSafetyvideoid()
	{
		return safetyvideoid;
	}

	public void setSafetyvideoid(Integer safetyvideoid)
	{
		this.safetyvideoid = safetyvideoid;
	}

	public String getSafetyvideoname()
	{
		return safetyvideoname;
	}

	public void setSafetyvideoname(String safetyvideoname)
	{
		this.safetyvideoname = safetyvideoname;
	}

	public Date getSafetyvideotime()
	{
		return safetyvideotime;
	}

	public void setSafetyvideotime(Date safetyvideotime)
	{
		this.safetyvideotime = safetyvideotime;
	}

	public Date getSafetyfinishtime()
	{
		return safetyfinishtime;
	}

	public void setSafetyfinishtime(Date safetyfinishtime)
	{
		this.safetyfinishtime = safetyfinishtime;
	}

	public Integer getClassid()
	{
		return classid;
	}

	public void setClassid(Integer classid)
	{
		this.classid = classid;
	}

	@Override
	public String toString()
	{
		return "TblSafetyConfig{" + "safetyconfigid=" + safetyconfigid + ", safetyvideoid=" + safetyvideoid + ", safetyvideoname='" + safetyvideoname + '\'' + ", safetyvideotime=" + safetyvideotime + ", safetyfinishtime=" + safetyfinishtime + ", classid=" + classid + ", classname='" + classname + '\'' + '}';
	}
}
