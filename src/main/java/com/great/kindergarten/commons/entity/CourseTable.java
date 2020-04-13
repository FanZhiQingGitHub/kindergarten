package com.great.kindergarten.commons.entity;

import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author MI
 * @date 2020/4/9 16:38
 */
@Component
public class CourseTable
{
	private int code;
	private String msg;
	private int count;
	private List data;

	public CourseTable()
	{

	}

	public CourseTable(int code, String msg, int count, List data)
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

	public List getData()
	{
		return data;
	}

	public void setData(List data)
	{
		this.data = data;
	}

	@Override
	public String toString()
	{
		return "CourseTable{" + "code=" + code + ", msg='" + msg + '\'' + ", count=" + count + ", data=" + data + '}';
	}
}
