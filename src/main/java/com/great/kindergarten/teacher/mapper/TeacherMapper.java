package com.great.kindergarten.teacher.mapper;

import com.great.kindergarten.commons.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface TeacherMapper {

	public String findTeacherStatus(Map<String, String> teachermap);
	public TblTeacher findTeacher(TblTeacher tblTeacher);
	public Boolean updateTeacherPwd(Map<String, String> teacherMap);
	public TblTeacher checkPwd(Integer teacherid);
	public TblClass findClassAll(Integer cid);
	public List<TblCourse> findCourse(Integer cid);
	public Integer findCount();
	public List<TblClass> findClassName();
	public Integer findClassidByName(TblClass tblClass);
	public Boolean addFileInfo(TblWorkrelease tblWorkrelease);
	//   根据查找作业数据
	public TblWork findWork(Integer cid);
	//   根据班级id 发布作业id查看作业表
	public List<TblWork> findWorkTable(TblWork tblWork);
	//    查找作业数据数量
	public Integer findWorkCount(Integer cid);
	//打分
	public Boolean workScore(Map<String,String> scoreMap);
	//    查看视频数量
	public Integer findSafetyCount();
	//查看视频表
	public List<TblSafetyConfig> findSafetyTable(HashMap<String,Object> dataHashMap);
	//新增上传视频
	public Boolean uploadVideo(TblSafetyvideo tblSafetyvideo);
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

}
