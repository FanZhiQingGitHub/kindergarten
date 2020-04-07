package com.great.kindergarten.admin.javabean;

/**
 * @author LXC
 */
public class TblRoleMenu
{
	private Integer rolemenuid;
	private Integer rid;
	private Integer mid;

	public TblRoleMenu()
	{
	}

	public Integer getRolemenuid()
	{
		return rolemenuid;
	}

	public void setRolemenuid(Integer rolemenuid)
	{
		this.rolemenuid = rolemenuid;
	}

	public Integer getRid()
	{
		return rid;
	}

	public void setRid(Integer rid)
	{
		this.rid = rid;
	}

	public Integer getMid()
	{
		return mid;
	}

	public void setMid(Integer mid)
	{
		this.mid = mid;
	}

	@Override
	public String toString()
	{
		return "TblRoleMenu{" + "rolemenuid=" + rolemenuid + ", rid=" + rid + ", mid=" + mid + '}';
	}
}
