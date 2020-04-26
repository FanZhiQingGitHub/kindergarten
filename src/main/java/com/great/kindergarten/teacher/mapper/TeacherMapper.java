package com.great.kindergarten.teacher.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.teacher.resultbean.PickUpInfoDetailPage;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface TeacherMapper {
    //登录
	public String findTeacherStatus(Map<String, String> teachermap);
	public TblTeacher findTeacher(TblTeacher tblTeacher);


	public Boolean updateTeacherPwd(Map<String, String> teacherMap);
	public TblTeacher checkPwd(Integer teacherid);
	public TblClass findClassAll(Integer cid);
	//获取园所动态news
	public List<TblCampus> findKinderNews(Map<String, Object> KinderNewsmap);

	//根据班级id，当前时间查找课程信息
	public List<TblCourse> findCourseByTodayCid(HashMap<String,Object> dataHashMap);

	public Integer findCount(Integer cid);
	//  根据cid 查找班级所有
	public List<TblClass> findClassName(Integer cid);
	public Integer findClassidByName(TblClass tblClass);
	//查询发布作业表中最后一个id
	public Integer findFinallyWorkreleaseid();
	//发布作业
	public Boolean addFileInfo(TblWorkrelease tblWorkrelease);

	//   根据班级id 发布作业id查看作业表
	public List<TblWork> findWorkTable(HashMap<String,Object> dataHashMap);

	//    查找作业数据数量
	public Integer findWorkCount(Integer cid);
	//打分
	public Boolean workScore(Map<String,String> scoreMap);


	//    查看视频数量
	public Integer findSafetyCount(HashMap<String,Object> dataHashMap);
	//查看视频表
	public List<TblSafetyConfig> findSafetyTable(HashMap<String,Object> dataHashMap);

	//查找所有安全视频名称
	public List<TblSafetyvideo> findVideoName();
	//根据视频名查id
	public Integer findSafetyvideoidByName(TblSafetyvideo tblSafetyvideo);
	//新增安全配置

	public Boolean addSafetyConfig(TblSafetyConfig tblSafetyConfig);
	/**
	 * 根据题目的id找到对应的一堆题目
	 * @param safetyVideoId
	 * @return
	 */
	List<TblSafetyvtq> findSafetyTestQuestionList(Integer safetyVideoId);
	// 查询试题完成情况总数

	public Integer findSafetytqCount(HashMap<String,Object> dataHashMap);
	//    查询试题完成情况表

	public List<TblSafetyFinish> findSafetytqTable(HashMap<String,Object> dataHashMap);
	
	// 根据cid查班级人数
	public Integer findStudentCount(HashMap<String,Object> dataHashMap);
	//    根据cid查班级人员数据
	public List<TblStudent> findStudent(HashMap<String,Object> dataHashMap);
	
	/**
	 * 根据条件找到孩子的接送信息
	 * @param pickUpInfoDetailPage
	 * @return
	 */
	public List<TblDate> findALLPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage);
	/**
	 * 新增照片
	 * @param tblPhoto
	 * @return
	 */
	public Boolean uploadPhoto(TblPhoto tblPhoto);
	// 查询班级相册总数
	public Integer findClassPhotoCount(HashMap<String,Object> dataHashMap);
	//     查看班级相册数据
	public List<TblPhoto> findClassPhoto(HashMap<String,Object> dataHashMap);

	/**
	 * 班级通知
	 * @param tblClamsg
	 * @return
	 */
	public Boolean addClassMsg(TblClamsg tblClamsg);

	public Integer findExistTeacherName(Map<String, String> teachermap);

	public Boolean resetTeacherpwd(Map<String, String> teachermap);

	public int addLog(TblSyslog log);//系统日志
	//班级消息通知---查询消息通知
	public List<TblClamsg> findClassMessageAll(Map<String, Object> map);
	//班级消息通知--对应消息通知记录值
	public Long findClassMessageAllCount(Map<String, Object> map);
	//    根据kid查园所名字
	public TblKinder findkinderNameByKid(Integer kid);
}
