package com.great.kindergarten.parent.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.MealPage;
import com.great.kindergarten.parent.resultbean.LivePage;
import com.great.kindergarten.security.resultbean.MonitorPage;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 */
@Mapper
public interface ParentMapper {


	/**
	 * 班级消息通知---查询消息通知
	 * @param map
	 * @return
	 */
	 List<TblClamsg> findClassMessageAll(Map<String, Object> map);

	/**
	 * 班级消息通知--对应消息通知记录值
	 * @param map
	 * @return
	 */
	 Integer findClassMessageAllCount(Map<String, Object> map);
	/**
	 * 查询校园公共信息
	 * @param map
	 * @return
	 */
	 List<TblCampus> findCampusBulletinAll(Map<String, Object> map);

	/**
	 * 计算有几条校园公告
	 * @param map
	 * @return
	 */
	 Integer findCampusBulletinAllCount(Map<String, Object> map);
	/**
	 * 往数据库增加日志方法
	 * @param log
	 * @return
	 */
	int addLog(TblSyslog log);//系统日志
	/**
	 * 根据班级id找到相册列表
	 * @param searchCondition
	 * @return
	 */
	List<TblPhoto> findPhotosByCid(SearchCondition searchCondition);
	/**
	 * 计算这个班级有几个照片记录
	 * @param searchCondition
	 * @return
	 */
	Integer countPhotosByCid(SearchCondition searchCondition);

	/**
	 * 计算这本书一共有几页
	 * @param readId
	 * @return
	 */
	Integer countBookById(Integer readId);
	/**
	 * 根据id和页码读取内容
	 * @param readId
	 * @param page
	 * @return
	 */
	List<TblReadmag> readBookByIdAndPage(Integer readId,Integer page);

	/**
	 * 计算一共有几个记录
	 * @return
	 */
	Integer countReadList();
	/**
	 * 根据页码找到对应的阅读数据
	 * @param page
	 * @param limit
	 * @return
	 */
	List<TblReadmag> findReadList(Integer page ,Integer limit);
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
	 * @param searchCondition
	 * @return
	 */
	List<TblMeal> findAllMealInfo(SearchCondition searchCondition);
	/**
	 * 根据条件找到总共有几条食物记录
	 * @param searchCondition
	 * @return
	 */
	Integer findAllMealInfoCount(SearchCondition searchCondition);


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
	 * @param safetyConfigId
	 * @return
	 */
	Integer countScore(Integer parentId,Integer safetyConfigId);


	/**
	 * 根据家长id和视频id放入成绩
	 * @param videoId
	 * @param parentId
	 * @param score
	 * @param score
	 * @param finshTime
	 * @param safetyConfigId
	 * @return
	 */
	Integer recordScore (Integer videoId , Integer parentId, Integer score, Date finshTime,Integer safetyConfigId);


	/**
	 * 根据题目的id找到对应的一堆题目
	 * @param safetyVideoId
	 * @return
	 */
	List<TblSafetyvtq> findSafetyTestQuestionList(Integer safetyVideoId);



	/**
	 * 根据条件查找出有几个记录
	 * @param condition
	 *  @param classId
	 * @return
	 */
	Integer countVideoListNumber ( SearchCondition condition,Integer classId);

	/**
	 * 根据家长id和条件找到已完成或者未完成的安全视频列表
	 * @param condition
	 *  @param classId
	 * @return
	 */
	List<TblSafetyvideo>findVideoList( SearchCondition condition,Integer classId);


	/**
	 * 查找当前可以登陆的园所
	 * @return
	 */
	List<String>selectLogin();

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


    //---------------------------孩子考勤新增方法------------------------------
	/**
	 * 查找父母亲和孩子的数据
	 */
	public List<TblParent> findParentStuInfo(Map<String,String> parentMap);

	public List<TblDate> findDateInfo(Map<String,String> dateMap);
	public TblStutime findAmTimeId(Map<String,String> dateMap);
	public TblStutime findPmTimeId(Map<String,String> dateMap);

	public TblStutime findExistDate(Map<String,String> dateMap);

	public Boolean addDateInfo(List<TblDate> tblDateList);
	public Boolean addAmAttendance(List<TblStutime> tblStutimeListAm);
	public Boolean addPmDate(Map<String,String> dateMap);
	public Boolean addPmAttendance(List<TblStutime> tblStutimeListPm);
	public Boolean addPmAttendanceAll(List<TblStutime> tblStutimeListPm);

	public Boolean updateAmAttendance(Map<String,String> AmMap);

	public Boolean updatePmAttendance(Map<String,String> PmMap);

	public List<TblStudent> findAllStuInfo(Map<String,String> Map);

	public Integer findExistParentName(Map<String, String> parentmap);

	public Boolean resetParentpwd(Map<String, String> parentmap);

	public List<TblMonitor> findALLMonitorInfo(LivePage livePage);

	public Long findALLMonitorInfoCount(LivePage livePage);

	public Integer findParentCidByName(Map<String,String> parentmap);
}
