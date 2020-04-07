package com.great.kindergarten.director.mapper;

import com.great.kindergarten.director.javabean.TblRector;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RectorMapper {

	//登录查询对应的内容
	public TblRector findRector(TblRector tblRector);


}
