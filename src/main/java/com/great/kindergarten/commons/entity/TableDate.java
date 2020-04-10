package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 * @author Administrator
 */
public class TableDate
{
	private int code =0;
	private String msg ="";
	private Integer count ;
	private List<?> data;


	public TableDate()
	{

	}

	public TableDate(int code, String msg, int count, List<?> data)
	{
		this.code = code;
		this.msg = msg;
		this.count = count;
		this.data = data;
	}

	public int getCode()
	{
		return code;
	}

	public void setCode(int code)
	{
		this.code = code;
	}

	public String getMsg()
	{
		return msg;
	}

	public void setMsg(String msg)
	{
		this.msg = msg;
	}

	public int getCount()
	{
		return count;
	}

	public void setCount(int count)
	{
		this.count = count;
	}

	public List<?> getData()
	{
		return data;
	}

	public void setData(List<?> data)
	{
		this.data = data;
	}
}
