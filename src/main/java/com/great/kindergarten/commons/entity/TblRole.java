package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 * @author LXC
 */
public class TblRole
{
	private Integer roleid;
	private String rolename;
	private List<TblMenu> menuList;

	public TblRole()
	{
	}

	public Integer getRoleid()
	{
		return roleid;
	}

	public void setRoleid(Integer roleid)
	{
		this.roleid = roleid;
	}

	public String getRolename()
	{
		return rolename;
	}

	public void setRolename(String rolename)
	{
		this.rolename = rolename;
	}

	public List<TblMenu> getMenuList()
	{
		return menuList;
	}

	public void setMenuList(List<TblMenu> menuList)
	{
		this.menuList = menuList;
	}

	@Override
	public String toString()
	{
		return "TblRole{" + "roleid=" + roleid + ", rolename='" + rolename + '\'' + ", menuList=" + menuList + '}';
	}
}
