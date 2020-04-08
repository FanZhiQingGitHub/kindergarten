package com.great.kindergarten.admin.javabean;

import java.util.Date;

public class TblSysLog
{
	private Integer syslogid;

	private String uuid;

	private String operateor;

	private String operatetype;

	private String operatedetail;

	private Date operatetime;

	private String operateresult;

	private String operateip;

	private String time1;

	private String time2;

	public TblSysLog()
	{
	}

	public Integer getSyslogid()
	{
		return syslogid;
	}

	public void setSyslogid(Integer syslogid)
	{
		this.syslogid = syslogid;
	}

	public String getUuid()
	{
		return uuid;
	}

	public void setUuid(String uuid)
	{
		this.uuid = uuid;
	}

	public String getOperateor()
	{
		return operateor;
	}

	public void setOperateor(String operateor)
	{
		this.operateor = operateor;
	}

	public String getOperatetype()
	{
		return operatetype;
	}

	public void setOperatetype(String operatetype)
	{
		this.operatetype = operatetype;
	}

	public String getOperatedetail()
	{
		return operatedetail;
	}

	public void setOperatedetail(String operatedetail)
	{
		this.operatedetail = operatedetail;
	}

	public Date getOperatetime()
	{
		return operatetime;
	}

	public void setOperatetime(Date operatetime)
	{
		this.operatetime = operatetime;
	}

	public String getOperateresult()
	{
		return operateresult;
	}

	public void setOperateresult(String operateresult)
	{
		this.operateresult = operateresult;
	}

	public String getOperateip()
	{
		return operateip;
	}

	public void setOperateip(String operateip)
	{
		this.operateip = operateip;
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
		return "TblSysLog{" + "syslogid=" + syslogid + ", operateor='" + operateor + '\'' + ", operatetype='" + operatetype + '\'' + ", operatedetail='" + operatedetail + '\'' + ", operatetime=" + operatetime + ", operateresult='" + operateresult + '\'' + ", operateip='" + operateip + '\'' + ", time1='" + time1 + '\'' + ", time2='" + time2 + '\'' + '}';
	}
}
