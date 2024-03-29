package com.great.kindergarten.commons.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * @author LXC
 */
public class TblMenu
{
	private Integer menuid;
	private String menuname;
	private String menuurl;
	private Integer menusonid;
	private List<TblMenu> childrenList;
	private ArrayList fatherNodeId;
	private ArrayList sonNodeId;
	private Integer rid;
	private String supMenu;
	private String mName;
	private String pName;
	//新增菜单分配排序
	private Integer sort;

	public TblMenu()
	{
	}

	public Integer getMenuid()
	{
		return menuid;
	}

	public void setMenuid(Integer menuid)
	{
		this.menuid = menuid;
	}

	public String getMenuname()
	{
		return menuname;
	}

	public void setMenuname(String menuname)
	{
		this.menuname = menuname;
	}

	public String getMenuurl()
	{
		return menuurl;
	}

	public void setMenuurl(String menuurl)
	{
		this.menuurl = menuurl;
	}

	public Integer getMenusonid()
	{
		return menusonid;
	}

	public void setMenusonid(Integer menusonid)
	{
		this.menusonid = menusonid;
	}

	public List<TblMenu> getChildrenList()
	{
		return childrenList;
	}

	public void setChildrenList(List<TblMenu> childrenList)
	{
		this.childrenList = childrenList;
	}

	public ArrayList getFatherNodeId()
	{
		return fatherNodeId;
	}

	public void setFatherNodeId(ArrayList fatherNodeId)
	{
		this.fatherNodeId = fatherNodeId;
	}

	public ArrayList getSonNodeId()
	{
		return sonNodeId;
	}

	public void setSonNodeId(ArrayList sonNodeId)
	{
		this.sonNodeId = sonNodeId;
	}

	public Integer getRid()
	{
		return rid;
	}

	public void setRid(Integer rid)
	{
		this.rid = rid;
	}

	public String getSupMenu()
	{
		return supMenu;
	}

	public void setSupMenu(String supMenu)
	{
		this.supMenu = supMenu;
	}

	public String getmName()
	{
		return mName;
	}

	public void setmName(String mName)
	{
		this.mName = mName;
	}

	public String getpName()
	{
		return pName;
	}

	public void setpName(String pName)
	{
		this.pName = pName;
	}

	public Integer getSort()
	{
		return sort;
	}

	public void setSort(Integer sort)
	{
		this.sort = sort;
	}

	@Override
	public String toString()
	{
		return "TblMenu{" + "menuid=" + menuid + ", menuname='" + menuname + '\'' + ", menuurl='" + menuurl + '\'' + ", menusonid=" + menusonid + ", childrenList=" + childrenList + ", fatherNodeId=" + fatherNodeId + ", sonNodeId=" + sonNodeId + ", rid=" + rid + ", supMenu='" + supMenu + '\'' + ", mName='" + mName + '\'' + ", pName='" + pName + '\'' + ", sort=" + sort + '}';
	}
}
