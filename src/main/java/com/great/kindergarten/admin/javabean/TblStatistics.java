package com.great.kindergarten.admin.javabean;

public class TblStatistics
{
	private String sex;
	private String status;
	private Integer age;
	private String scale;
	private String funds;
	private Integer num;

	public String getSex()
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Integer getAge()
	{
		return age;
	}

	public void setAge(Integer age)
	{
		this.age = age;
	}

	public String getScale()
	{
		return scale;
	}

	public void setScale(String scale)
	{
		this.scale = scale;
	}

	public String getFunds()
	{
		return funds;
	}

	public void setFunds(String funds)
	{
		this.funds = funds;
	}

	public Integer getNum()
	{
		return num;
	}

	public void setNum(Integer num)
	{
		this.num = num;
	}

	@Override
	public String toString()
	{
		return "TblStatistics{" + "sex='" + sex + '\'' + ", status='" + status + '\'' + ", age=" + age + ", scale='" + scale + '\'' + ", funds='" + funds + '\'' + ", num=" + num + '}';
	}
}
