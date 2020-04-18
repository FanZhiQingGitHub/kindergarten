package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author Administrator
 * 家长实体信息类
 */
public class TblParent
{
	private Integer parentId;
	private String parentName;
	private String parentPwd;
	private String parentSex;
	private Integer parentAge;
	private String parentAdd;
	private String parentPhone;
	private String parentSon;
	private String parentJob;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd ")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date parentRegTime;
	private String parentStatus;
	private Integer rid;

	private TblStudent tblStudent;
	private Integer studentid;
	private String studentname;
	private String time1;
	private String time2;


	public TblParent()
	{
	}

	public TblParent(Integer parentId, String parentName, String parentPwd, String parentSex, Integer parentAge, String parentAdd, String parentPhone, String parentSon, String parentJob, Date parentRegTime, String parentStatus, Integer rid, TblStudent tblStudent)
	{
		this.parentId = parentId;
		this.parentName = parentName;
		this.parentPwd = parentPwd;
		this.parentSex = parentSex;
		this.parentAge = parentAge;
		this.parentAdd = parentAdd;
		this.parentPhone = parentPhone;
		this.parentSon = parentSon;
		this.parentJob = parentJob;
		this.parentRegTime = parentRegTime;
		this.parentStatus = parentStatus;
		this.rid = rid;
		this.tblStudent = tblStudent;
	}

	public Integer getParentId()
	{
		return parentId;
	}

	public void setParentId(Integer parentId)
	{
		this.parentId = parentId;
	}

	public String getParentName()
	{
		return parentName;
	}

	public void setParentName(String parentName)
	{
		this.parentName = parentName;
	}

	public String getParentPwd()
	{
		return parentPwd;
	}

	public void setParentPwd(String parentPwd)
	{
		this.parentPwd = parentPwd;
	}

	public String getParentSex()
	{
		return parentSex;
	}

	public void setParentSex(String parentSex)
	{
		this.parentSex = parentSex;
	}

	public Integer getParentAge()
	{
		return parentAge;
	}

	public void setParentAge(Integer parentAge)
	{
		this.parentAge = parentAge;
	}

	public String getParentAdd()
	{
		return parentAdd;
	}

	public void setParentAdd(String parentAdd)
	{
		this.parentAdd = parentAdd;
	}

	public String getParentPhone()
	{
		return parentPhone;
	}

	public void setParentPhone(String parentPhone)
	{
		this.parentPhone = parentPhone;
	}

	public String getParentSon()
	{
		return parentSon;
	}

	public void setParentSon(String parentSon)
	{
		this.parentSon = parentSon;
	}

	public String getParentJob()
	{
		return parentJob;
	}

	public void setParentJob(String parentJob)
	{
		this.parentJob = parentJob;
	}

	public Date getParentRegTime()
	{
		return parentRegTime;
	}

	public void setParentRegTime(Date parentRegTime)
	{
		this.parentRegTime = parentRegTime;
	}

	public String getParentStatus()
	{
		return parentStatus;
	}

	public void setParentStatus(String parentStatus)
	{
		this.parentStatus = parentStatus;
	}

	public Integer getRid()
	{
		return rid;
	}

	public void setRid(Integer rid)
	{
		this.rid = rid;
	}

	public TblStudent getTblStudent()
	{
		return tblStudent;
	}

	public void setTblStudent(TblStudent tblStudent)
	{
		this.tblStudent = tblStudent;
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
		return "TblParent{" + "parentId=" + parentId + ", parentName='" + parentName + '\'' + ", parentPwd='" + parentPwd + '\'' + ", parentSex='" + parentSex + '\'' + ", parentAge=" + parentAge + ", parentAdd='" + parentAdd + '\'' + ", parentPhone='" + parentPhone + '\'' + ", parentSon='" + parentSon + '\'' + ", parentJob='" + parentJob + '\'' + ", parentRegTime=" + parentRegTime + ", parentStatus='" + parentStatus + '\'' + ", rid=" + rid + ", tblStudent=" + tblStudent + '}';
	}
}
