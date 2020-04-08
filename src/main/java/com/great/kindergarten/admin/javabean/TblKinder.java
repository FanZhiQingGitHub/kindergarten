package com.great.kindergarten.admin.javabean;

import java.util.Date;

public class TblKinder
{
	private Integer kinderid;
	private String kindername;
	private String kinderlp;
	private String kinderpid;
	private String kinderadd;
	private Long kinderphone;
	private String schoolpermit;
	private String healthpermit;
	private String firepermit;
	private String grouppermit;
	private String registrationpermit;
	private Date kinderapptime;
	private Date kinderregtime;
	private String kinderstatus;
	private String time1;
	private String time2;

	public TblKinder()
	{
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

	public String getKinderlp()
	{
		return kinderlp;
	}

	public void setKinderlp(String kinderlp)
	{
		this.kinderlp = kinderlp;
	}

	public String getKinderpid()
	{
		return kinderpid;
	}

	public void setKinderpid(String kinderpid)
	{
		this.kinderpid = kinderpid;
	}

	public String getKinderadd()
	{
		return kinderadd;
	}

	public void setKinderadd(String kinderadd)
	{
		this.kinderadd = kinderadd;
	}

	public Long getKinderphone()
	{
		return kinderphone;
	}

	public void setKinderphone(Long kinderphone)
	{
		this.kinderphone = kinderphone;
	}

	public String getSchoolpermit()
	{
		return schoolpermit;
	}

	public void setSchoolpermit(String schoolpermit)
	{
		this.schoolpermit = schoolpermit;
	}

	public String getHealthpermit()
	{
		return healthpermit;
	}

	public void setHealthpermit(String healthpermit)
	{
		this.healthpermit = healthpermit;
	}

	public String getFirepermit()
	{
		return firepermit;
	}

	public void setFirepermit(String firepermit)
	{
		this.firepermit = firepermit;
	}

	public String getGrouppermit()
	{
		return grouppermit;
	}

	public void setGrouppermit(String grouppermit)
	{
		this.grouppermit = grouppermit;
	}

	public String getRegistrationpermit()
	{
		return registrationpermit;
	}

	public void setRegistrationpermit(String registrationpermit)
	{
		this.registrationpermit = registrationpermit;
	}

	public Date getKinderapptime()
	{
		return kinderapptime;
	}

	public void setKinderapptime(Date kinderapptime)
	{
		this.kinderapptime = kinderapptime;
	}

	public Date getKinderregtime()
	{
		return kinderregtime;
	}

	public void setKinderregtime(Date kinderregtime)
	{
		this.kinderregtime = kinderregtime;
	}

	public String getKinderstatus()
	{
		return kinderstatus;
	}

	public void setKinderstatus(String kinderstatus)
	{
		this.kinderstatus = kinderstatus;
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
		return "TblKinder{" + "kinderid=" + kinderid + ", kindername='" + kindername + '\'' + ", kinderlp='" + kinderlp + '\'' + ", kinderpid='" + kinderpid + '\'' + ", kinderadd='" + kinderadd + '\'' + ", kinderphone=" + kinderphone + ", schoolpermit='" + schoolpermit + '\'' + ", healthpermit='" + healthpermit + '\'' + ", firepermit='" + firepermit + '\'' + ", grouppermit='" + grouppermit + '\'' + ", registrationpermit='" + registrationpermit + '\'' + ", kinderapptime=" + kinderapptime + ", kinderregtime=" + kinderregtime + ", kinderstatus='" + kinderstatus + '\'' + '}';
	}
}
