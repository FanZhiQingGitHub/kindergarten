package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

/**
 * @author JK  首页新闻实体类
 */
public class TblCampus
{
	private Integer campusinfoid;
	private String campusinfoname;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date campustime;
	private String campusinfodetail;
	private Integer kid;



	public Integer getCampusinfoid()
	{
		return campusinfoid;
	}

	public void setCampusinfoid(Integer campusinfoid)
	{
		this.campusinfoid = campusinfoid;
	}

	public String getCampusinfoname()
	{
		return campusinfoname;
	}

	public void setCampusinfoname(String campusinfoname)
	{
		this.campusinfoname = campusinfoname;
	}

	public Date getCampustime()
	{
		return campustime;
	}

	public void setCampustime(Date campustime)
	{
		this.campustime = campustime;
	}

	public String getCampusinfodetail()
	{
		return campusinfodetail;
	}

	public void setCampusinfodetail(String campusinfodetail)
	{
		this.campusinfodetail = campusinfodetail;
	}

	public Integer getKid()
	{
		return kid;
	}

	public void setKid(Integer kid)
	{
		this.kid = kid;
	}
}
