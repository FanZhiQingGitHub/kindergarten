package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author MI
 * @date 2020/4/16 17:25
 */
public class TblSafetyFinish
{
	private Integer studentid;
	private String studentname;
	//	private  Integer pid;
	private  String parentname;
	private String safetyvideoname;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date safetyfinishtime;
	//	private Integer safetyvideoid;
	//	private Integer safetyconfigid;

	//	private Integer safetytestid;
	//	private String safetyvideoid;
	//	private Integer parentid;
	private String safetytestscore;
	private String safetytestresult;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date safetytestfinshtime;
	//	private Integer safetyconfigid;

	public TblSafetyFinish()
	{
	}

	public TblSafetyFinish(Integer studentid, String studentname,  String parentname, String safetyvideoname, Date safetyfinishtime, String safetytestscore, String safetytestresult, Date safetytestfinshtime)
	{
		this.studentid = studentid;
		this.studentname = studentname;
		//		this.pid = pid;
		this.parentname = parentname;
		this.safetyvideoname = safetyvideoname;
		this.safetyfinishtime = safetyfinishtime;
		this.safetytestscore = safetytestscore;
		this.safetytestresult = safetytestresult;
		this.safetytestfinshtime = safetytestfinshtime;
	}

	public Integer getStudentid()
	{
		return studentid;
	}

	public void setStudentid(Integer studentid)
	{
		this.studentid = studentid;
	}

	public String getStudentname()
	{
		return studentname;
	}

	public void setStudentname(String studentname)
	{
		this.studentname = studentname;
	}



	public String getParentname()
	{
		return parentname;
	}

	public void setParentname(String parentname)
	{
		this.parentname = parentname;
	}

	public String getSafetyvideoname()
	{
		return safetyvideoname;
	}

	public void setSafetyvideoname(String safetyvideoname)
	{
		this.safetyvideoname = safetyvideoname;
	}

	public Date getSafetyfinishtime()
	{
		return safetyfinishtime;
	}

	public void setSafetyfinishtime(Date safetyfinishtime)
	{
		this.safetyfinishtime = safetyfinishtime;
	}

	public String getSafetytestscore()
	{
		return safetytestscore;
	}

	public void setSafetytestscore(String safetytestscore)
	{
		this.safetytestscore = safetytestscore;
	}

	public String getSafetytestresult()
	{
		return safetytestresult;
	}

	public void setSafetytestresult(String safetytestresult)
	{
		this.safetytestresult = safetytestresult;
	}

	public Date getSafetytestfinshtime()
	{
		return safetytestfinshtime;
	}

	public void setSafetytestfinshtime(Date safetytestfinshtime)
	{
		this.safetytestfinshtime = safetytestfinshtime;
	}

	@Override
	public String toString()
	{
		return "TblSafetyFinish{" + "studentid=" + studentid + ", studentname='" + studentname + '\'' + ",  parentname='" + parentname + '\'' + ", safetyvideoname='" + safetyvideoname + '\'' + ", safetyfinishtime=" + safetyfinishtime + ", safetytestscore='" + safetytestscore + '\'' + ", safetytestresult='" + safetytestresult + '\'' + ", safetytestfinshtime=" + safetytestfinshtime + '}';
	}
}
