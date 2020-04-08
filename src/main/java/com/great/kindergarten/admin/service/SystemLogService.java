package com.great.kindergarten.admin.service;

import com.great.kindergarten.admin.javabean.TblSysLog;
import com.great.kindergarten.admin.mapper.SystemLogMapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class SystemLogService
{
	@Resource
	private SystemLogMapper systemLogMapper;

	public int addLog(TblSysLog log)
	{
		return systemLogMapper.addLog(log);
	}

	public List<TblSysLog> findAllDoc(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return systemLogMapper.findAllLog(condition,rowBounds);
	}

	public int findAllCount(HashMap<String, Object> condition)
	{
		return systemLogMapper.findAllCount(condition);
	}
}
