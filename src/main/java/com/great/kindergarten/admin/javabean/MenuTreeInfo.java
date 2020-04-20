package com.great.kindergarten.admin.javabean;

import java.util.List;

public class MenuTreeInfo
{
	private String title;
	private Integer id;
	private List<MenuTreeInfo> children;

	public MenuTreeInfo()
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

	public List<MenuTreeInfo> getChildren()
	{
		return children;
	}

	public void setChildren(List<MenuTreeInfo> children)
	{
		this.children = children;
	}
}
