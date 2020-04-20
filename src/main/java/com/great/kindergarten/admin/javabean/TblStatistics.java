package com.great.kindergarten.admin.javabean;

public class TblStatistics
{
	private String studentname;
	private String studentsex;
	private String teachersex;
	private String healthstatus;
	private Integer age;
	private String time;

	//年龄段人数(<3岁)
	private Integer aCount;

	//>=3岁且<=4
	private Integer bCount;

	//>4岁且<=6
	private Integer cCount;

	//>=3岁且小于4
	private Integer dCount;

	//>=4岁且小于5
	private Integer eCount;

	//>=5岁且小于6
	private Integer fCount;

	//>=6岁
	private Integer gCount;

	//健康状态正常人数
	private Integer normalCount;
	//健康状态良好人数
	private Integer wellCount;
	//健康状态差人数
	private Integer badCount;

	private Integer maleCount;

	private Integer feMaleCount;

	public TblStatistics()
	{
	}

	public String getStudentname()
	{
		return studentname;
	}

	public void setStudentname(String studentname)
	{
		this.studentname = studentname;
	}

	public String getTime()
	{
		return time;
	}

	public void setTime(String time)
	{
		this.time = time;
	}

	public Integer getaCount()
	{
		return aCount;
	}

	public void setaCount(Integer aCount)
	{
		this.aCount = aCount;
	}

	public Integer getbCount()
	{
		return bCount;
	}

	public void setbCount(Integer bCount)
	{
		this.bCount = bCount;
	}

	public Integer getcCount()
	{
		return cCount;
	}

	public void setcCount(Integer cCount)
	{
		this.cCount = cCount;
	}

	public Integer getdCount()
	{
		return dCount;
	}

	public void setdCount(Integer dCount)
	{
		this.dCount = dCount;
	}

	public Integer geteCount()
	{
		return eCount;
	}

	public void seteCount(Integer eCount)
	{
		this.eCount = eCount;
	}

	public Integer getfCount()
	{
		return fCount;
	}

	public void setfCount(Integer fCount)
	{
		this.fCount = fCount;
	}

	public Integer getgCount()
	{
		return gCount;
	}

	public void setgCount(Integer gCount)
	{
		this.gCount = gCount;
	}

	public Integer getNormalCount()
	{
		return normalCount;
	}

	public void setNormalCount(Integer normalCount)
	{
		this.normalCount = normalCount;
	}

	public Integer getWellCount()
	{
		return wellCount;
	}

	public void setWellCount(Integer wellCount)
	{
		this.wellCount = wellCount;
	}

	public Integer getBadCount()
	{
		return badCount;
	}

	public void setBadCount(Integer badCount)
	{
		this.badCount = badCount;
	}

	public Integer getMaleCount()
	{
		return maleCount;
	}

	public void setMaleCount(Integer maleCount)
	{
		this.maleCount = maleCount;
	}

	public Integer getFeMaleCount()
	{
		return feMaleCount;
	}

	public void setFeMaleCount(Integer feMaleCount)
	{
		this.feMaleCount = feMaleCount;
	}

	public String getStudentsex()
	{
		return studentsex;
	}

	public void setStudentsex(String studentsex)
	{
		this.studentsex = studentsex;
	}

	public Integer getAge()
	{
		return age;
	}

	public void setAge(Integer age)
	{
		this.age = age;
	}

	public String getTeachersex()
	{
		return teachersex;
	}

	public void setTeachersex(String teachersex)
	{
		this.teachersex = teachersex;
	}

	public String getHealthstatus()
	{
		return healthstatus;
	}

	public void setHealthstatus(String healthstatus)
	{
		this.healthstatus = healthstatus;
	}

	@Override
	public String toString()
	{
		return "TblStatistics{" + "studentname='" + studentname + '\'' + ", studentsex='" + studentsex + '\'' + ", teachersex='" + teachersex + '\'' + ", healthstatus='" + healthstatus + '\'' + ", age=" + age + ", time='" + time + '\'' + ", aCount=" + aCount + ", bCount=" + bCount + ", cCount=" + cCount + ", dCount=" + dCount + ", eCount=" + eCount + ", fCount=" + fCount + ", gCount=" + gCount + ", normalCount=" + normalCount + ", wellCount=" + wellCount + ", badCount=" + badCount + ", maleCount=" + maleCount + ", feMaleCount=" + feMaleCount + '}';
	}
}
