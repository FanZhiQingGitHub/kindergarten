package com.great.kindergarten.admin.javabean;

import java.util.List;

public class TblMenuTreeInfo
{
	private String title;
	private Integer id;
	private List<TblMenuTreeInfo> children;

	public TblMenuTreeInfo()
	{
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public List<TblMenuTreeInfo> getChildren()
	{
		return children;
	}

	public void setChildren(List<TblMenuTreeInfo> children)
	{
		this.children = children;
	}
}
