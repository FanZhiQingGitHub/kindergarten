package com.great.kindergarten.parent.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.MealPage;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * @author Administrator
 */
@Mapper
public interface ParentMapper {


	/**
	 * 计算孩子体检列表的个数
	 * @param searchCondition
	 * @return
	 */
	Integer countExaminationByStudentId(SearchCondition searchCondition);
	/**
	 * 根据搜索条件找到对应的孩子体检列表
	 * @param searchCondition
	 * @return
	 */
	List<TblExamination> findExaminationByStudentId(SearchCondition searchCondition);
	/**
	 * 根据食谱id找到食谱的所有信息
	 * @param mealId
	 * @return
	 */
	List<TblRecipe> findAllRecipeInfo(Integer mealId);
	/**
	 * 根据页码找到食物历史记录
	 * @param mealPage
	 * @return
	 */
	List<TblMeal> findAllMealInfo(MealPage mealPage);
	/**
	 * 根据条件找到总共有几条食物记录
	 * @return
	 */
	Integer findAllMealInfoCount();


	/**
	 * 根据条件找到孩子的接送信息
	 * @param pickUpInfoDetailPage
	 * @return
	 */
	List<TblStutime> findPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage);

	/**
	 * 更改家长提交的作业位置
	 * @param insertHomeWork
	 * @return
	 */
	Integer updateWorkUrl(TblWork insertHomeWork);

	/**
	 * 查询是否已经上传了这个作业
	 * @param insertHomeWork
	 * @return
	 */
	Integer findSameWorkInsertRecord(TblWork insertHomeWork);

	/**
	 * 根据类插入作业信息
	 * @param insertHomeWork
	 * @return
	 */
	Integer uploadHomeWork(TblWork insertHomeWork);


	/**
	 * 根据家长id找到属于自己的宝宝
	 * @param parentId
	 * @return
	 */
	List<TblStudent> findKisByParentId(Integer parentId);


	/**
	 * 根据家长id和其他条件 找到自己孩子的作业列表
	 * @param  condition
	 * @param  cid
	 * @return
	 */
	List<TblWork> findHomeWorkList(@Param("condition") SearchCondition condition ,@Param("cid") Integer cid);

	/**
	 * 根据家长id和其他条件 找到自己孩子有几条作业记录
	 * @param  condition
	 * @param  cid
	 * @return
	 */
	Integer countHomeWorkList(@Param("condition")SearchCondition condition ,@Param("cid") Integer cid);


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
	 * @param score
	 * @param finshTime
	 * @return
	 */
	Integer recordScore (Integer videoId , Integer parentId, Integer score, Date finshTime);


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
