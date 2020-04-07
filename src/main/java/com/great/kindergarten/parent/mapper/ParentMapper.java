package com.great.kindergarten.parent.mapper;

import com.great.kindergarten.parent.entity.Parent;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author Administrator
 */
@Mapper
public interface ParentMapper {

	/**
	 * 家长登陆接口
	 * @param parentName
	 * @param parentPwd
	 * @return
	 */
	 Parent parentLogin(String parentName,String parentPwd);






}
