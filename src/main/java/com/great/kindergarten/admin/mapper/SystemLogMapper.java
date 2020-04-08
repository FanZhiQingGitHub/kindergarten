package com.great.kindergarten.admin.mapper;


import com.great.kindergarten.commons.entity.TblSyslog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface SystemLogMapper
{
	public int addLog(TblSyslog log);

	public List<TblSyslog> findAllLog(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findAllCount(HashMap<String, Object> condition);
}
