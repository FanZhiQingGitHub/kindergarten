package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.Date;


/**
 * @author MI
 * @date 2020/4/7 17:09
 */
@Component(value = "TblTeacher")
@Scope("prototype")
public class TblTeacher
{
	private Integer teacherid;
	private String teachername;
	private String teacherpwd;
	private String teachersex;
	private Integer teacherage;
	private String teacheradd;
	private String teacherphone;
	private String teacherjob;
	@JsonFormat( timezone = "GMT+ 8",pattern="yyyy -MM-dd HH: mm")
	@DateTimeFormat( pattern = " yyy-MM-dd" )
	private Date teacherretime;
	private String teacherstatus;
	private Integer cid;
	private Integer rid;
	private String code;

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public Integer getTeacherid()
	{
		return teacherid;
	}

	public void setTeacherid(Integer teacherid)
	{
		this.teacherid = teacherid;
	}

	public String getTeachername()
	{
		return teachername;
	}

	public void setTeachername(String teachername)
	{
		this.teachername = teachername;
	}

	public String getTeacherpwd()
	{
		return teacherpwd;
	}

	public void setTeacherpwd(String teacherpwd)
	{
		this.teacherpwd = teacherpwd;
	}

	public String getTeachersex()
	{
		return teachersex;
	}

	public void setTeachersex(String teachersex)
	{
		this.teachersex = teachersex;
	}

	public Integer getTeacherage()
	{
		return teacherage;
	}

	public void setTeacherage(Integer teacherage)
	{
		this.teacherage = teacherage;
	}

	public String getTeacheradd()
	{
		return teacheradd;
	}

	public void setTeacheradd(String teacheradd)
	{
		this.teacheradd = teacheradd;
	}

	public String getTeacherphone()
	{
		return teacherphone;
	}

	public void setTeacherphone(String teacherphone)
	{
		this.teacherphone = teacherphone;
	}

	public String getTeacherjob()
	{
		return teacherjob;
	}

	public void setTeacherjob(String teacherjob)
	{
		this.teacherjob = teacherjob;
	}

	public Date getTeacherretime()
	{
		return teacherretime;
	}

	public void setTeacherretime(Date teacherretime)
	{
		this.teacherretime = teacherretime;
	}

	public String getTeacherstatus()
	{
		return teacherstatus;
	}

	public void setTeacherstatus(String teacherstatus)
	{
		this.teacherstatus = teacherstatus;
	}

	public Integer getCid()
	{
		return cid;
	}

	public void setCid(Integer cid)
	{
		this.cid = cid;
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
		return "TblTeacher{" + "teacherid=" + teacherid + ", teachername='" + teachername + '\'' + ", teacherpwd='" + teacherpwd + '\'' + ", teachersex='" + teachersex + '\'' + ", teacherage=" + teacherage + ", teacheradd='" + teacheradd + '\'' + ", teacherphone=" + teacherphone + ", teacherjob='" + teacherjob + '\'' + ", teacherretime=" + teacherretime + ", teacherstatus='" + teacherstatus + '\'' + ", cid=" + cid + ", rid=" + rid + ", code='" + code + '\'' + '}';
	}
}
