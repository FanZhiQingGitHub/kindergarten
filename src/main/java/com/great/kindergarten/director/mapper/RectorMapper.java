package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.TblKinder;
import com.great.kindergarten.commons.entity.TblRector;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RectorMapper
{
	//登录查询对应的内容
	public TblRector findRector(TblRector tblRector);

	//判断密码是不是正确的
	public TblRector selectoldPwd(TblRector tblRector);

	//更新密码
	public int updateByIdPwd(TblRector tblRector);


}
