package com.great.kindergarten.parent.mapper;

import com.great.kindergarten.commons.entity.SearchCondition;
import com.great.kindergarten.commons.entity.TblParent;
import com.great.kindergarten.commons.entity.TblSafetyvideo;
import com.great.kindergarten.commons.entity.TblSafetyvtq;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author Administrator
 */
@Mapper
public interface ParentMapper {


	/**
	 * 先查询防止分数数据重复
	 * @param parentId
	 * @param videoId
	 * @return
	 */
	Integer countScore(Integer parentId,Integer videoId);


	/**
	 * 根据家长id和视频id放入成绩
	 * @param videoId
	 * @param parentId
	 * @param score
	 * @return
	 */
	Integer recordScore (Integer videoId ,Integer parentId,Integer score);


	/**
	 * 根据题目的id找到对应的一堆题目
	 * @param safetyVideoId
	 * @return
	 */
	List<TblSafetyvtq> findSafetyTestQuestionList(Integer safetyVideoId);



	/**
	 * 根据条件查找出有几个记录
	 * @param condition
	 * @return
	 */
	Integer countVideoListNumber ( SearchCondition condition);

	/**
	 * 根据家长id和条件找到已完成或者未完成的安全视频列表
	 * @param condition
	 * @return
	 */
	List<TblSafetyvideo>findVideoList( SearchCondition condition);



	/**
	 * 家长登陆接口
	 * @param parentName
	 * @param parentPwd
	 * @return
	 */
	 TblParent parentLogin(String parentName, String parentPwd);

	/**
	 * 根据家长id和旧密码判断旧密码是否输入正确
	 * @param oldParentPwd
	 * @param parentId
	 * @return
	 */
	Integer countOldParentPwd(String oldParentPwd,Integer parentId);

	/**
	 * 根据家长的id更新密码
	 * @param parentPwd
	 * @param parentId
	 * @return
	 */
    Integer	updateParentPwd(String parentPwd,Integer parentId);

}
