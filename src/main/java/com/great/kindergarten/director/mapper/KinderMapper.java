package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.TblKinder;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author JK
 */
@Mapper
public interface KinderMapper
{
	//申请园所
	public int addKinderMsg(TblKinder tblKinder);
}
