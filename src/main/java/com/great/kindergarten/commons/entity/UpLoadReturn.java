package com.great.kindergarten.commons.entity;

import java.util.List;

public class UpLoadReturn
{
	private int code =0;
	private String msg ="";
	private String data;

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

	public String getData()
	{
		return data;
	}

	public void setData(String data)
	{
		this.data = data;
	}

	@Override
	public String toString()
	{
		return "UpLoadReturn{" + "code=" + code + ", msg='" + msg + '\'' + ", data='" + data + '\'' + '}';
	}
}
