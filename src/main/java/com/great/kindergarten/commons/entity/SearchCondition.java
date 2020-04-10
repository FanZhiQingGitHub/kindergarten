package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author Administrator
 */
public class SearchCondition
{
	private String name;
	private String status;
	private Integer parentId;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date beginTime;
	@JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date endTime;
	private Integer page;
	private Integer limit;


	public SearchCondition()
	{
	}

	public SearchCondition(String name, String status, Integer parentId, Date beginTime, Date endTime, Integer page, Integer limit)
	{
		this.name = name;
		this.status = status;
		this.parentId = parentId;
		this.beginTime = beginTime;
		this.endTime = endTime;
		this.page = page;
		this.limit = limit;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Date getBeginTime()
	{
		return beginTime;
	}

	public void setBeginTime(Date beginTime)
	{
		this.beginTime = beginTime;
	}

	public Date getEndTime()
	{
		return endTime;
	}

	public void setEndTime(Date endTime)
	{
		this.endTime = endTime;
	}

	public Integer getPage()
	{
		return page;
	}

	public void setPage(Integer page)
	{
		this.page = page;
	}

	public Integer getLimit()
	{
		return limit;
	}

	public void setLimit(Integer limit)
	{
		this.limit = limit;
	}

	public Integer getParentId()
	{
		return parentId;
	}

	public void setParentId(Integer parentId)
	{
		this.parentId = parentId;
	}

	@Override
	public String toString()
	{
		return "SearchCondition{" + "name='" + name + '\'' + ", status='" + status + '\'' + ", beginTime=" + beginTime + ", endTime=" + endTime + ", page=" + page + ", limit=" + limit + '}';
	}
}
