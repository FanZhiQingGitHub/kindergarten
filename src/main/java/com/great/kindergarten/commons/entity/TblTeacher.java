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
	@JsonFormat( timezone = "GMT+ 8",pattern="yyyy-MM-dd HH:mm")
	@DateTimeFormat( pattern = "yyy-MM-dd" )
	private Date teacherregtime;
	private String teacherstatus;
	private Integer cid;
	private Integer rid;
	private Integer kinderid;
	private String code;
	private String time1;
	private String time2;
	private TblClass tblClass;
	private Integer classid;
	private String classname;

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

	public Date getTeacherregtime()
	{
		return teacherregtime;
	}

	public void setTeacherregtime(Date teacherregtime)
	{
		this.teacherregtime = teacherregtime;
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

	public TblClass getTblClass()
	{
		return tblClass;
	}

	public void setTblClass(TblClass tblClass)
	{
		this.tblClass = tblClass;
	}

	public Integer getClassid()
	{
		return classid;
	}

	public void setClassid(Integer classid)
	{
		this.classid = classid;
	}

	public String getClassname()
	{
		return classname;
	}

	public void setClassname(String classname)
	{
		this.classname = classname;
	}

	public Integer getKinderid()
	{
		return kinderid;
	}

	public void setKinderid(Integer kinderid)
	{
		this.kinderid = kinderid;
	}

	@Override
	public String toString()
	{
		return "TblTeacher{" + "teacherid=" + teacherid + ", teachername='" + teachername + '\'' + ", teacherpwd='" + teacherpwd + '\'' + ", teachersex='" + teachersex + '\'' + ", teacherage=" + teacherage + ", teacheradd='" + teacheradd + '\'' + ", teacherphone='" + teacherphone + '\'' + ", teacherjob='" + teacherjob + '\'' + ", teacherregtime=" + teacherregtime + ", teacherstatus='" + teacherstatus + '\'' + ", cid=" + cid + ", rid=" + rid + ", kinderid=" + kinderid + ", code='" + code + '\'' + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + ", tblClass=" + tblClass + ", classid=" + classid + ", classname='" + classname + '\'' + '}';
	}
}
