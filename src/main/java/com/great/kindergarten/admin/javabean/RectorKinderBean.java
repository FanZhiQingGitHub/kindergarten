package com.great.kindergarten.admin.javabean;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.great.kindergarten.commons.entity.TblKinder;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

public class RectorKinderBean
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

	private TblKinder tblKinder;
	private Integer kinderid;
	private String kindername;
	private Integer recid;//对应的园长ID外键

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

	public TblKinder getTblKinder()
	{
		return tblKinder;
	}

	public void setTblKinder(TblKinder tblKinder)
	{
		this.tblKinder = tblKinder;
	}

	public Integer getKinderid()
	{
		return kinderid;
	}

	public void setKinderid(Integer kinderid)
	{
		this.kinderid = kinderid;
	}

	public String getKindername()
	{
		return kindername;
	}

	public void setKindername(String kindername)
	{
		this.kindername = kindername;
	}

	public Integer getRecid()
	{
		return recid;
	}

	public void setRecid(Integer recid)
	{
		this.recid = recid;
	}
}
