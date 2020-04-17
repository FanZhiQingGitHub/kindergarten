package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.resultbean.TblScTInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @author JK
 */
@Mapper
public interface KinderMapper
{
	//申请园所
	public int addKinderMsg(TblKinder tblKinder);

	/*
	 * 课程管理
	 * */
	//查询班级和教师对应的信息
	public List<TblTeacher> findClassTeacherAll(Map<String, Object> map);

	//查询班级和教师记录条数
	public Long findClassTeacherAllCount(Map<String, Object> map);

	/*
	 * 对应的课程信息
	 * */
	//课程管理---查询课程的信息
	public List<TblCourse> findAllCourseName(Map<String, Object> map);

	//课程管理--对应的课程的记录值
//	public Long findAllCourseNameCount(Map<String, Object> map);

	//课程管理--添加课程表
	public int  addTblCourseInfo(List<TblCourse> tblCourseList);
	//删除--课程表
	public int delTblCourseInfo(int cid,int ctids);

	//添加对应的课程时间表的内容
	public int addCoursetestInfo(TblCoursetest tblCoursetest);
	//查询对应的课程时间表的ID值
	public int findCoursetestID(Map<String, Object> map);

	/*
	 * 班级管理
	 * */
	//查询对应的班级有哪些老师

	//查找对应的所有学生信息
	public List<TblTeacher> findTeacherClassAll();

	//新增对应的班级
	public int addClassForm(TblClass tblClass);

	//查询对应的新增的班级的id值
	public TblClass selectClassByCid(String classname);

	//修改对应的教师表的cid
	public int updateTeacherByCid(Map<String, Object> map);

	//班级表对应的删除操作
	public int delClassTable(int classid);

	//查询对应的教师表的id值
	public TblTeacher selectTeacherByTeacherId(int classid);
	//对应的班级表的修改操作
	public int updateClassTable(TblClass tblClass);

	/*
	* 班级成员管理
	* */
	//班级成员管理---查询课程的信息
	public List<TblScTInfo> findClassMemberAll(Map<String, Object> map);

	//班级成员管理--对应的课程的记录值
	public Long findClassMemberAllCount(Map<String, Object> map);

	//对应的查询班级
	public List<TblClass> findAllClassAll();

	//添加对应的班级成员信息
	public int updateStudentByCid(Map<String, Object> map);

	/*
	 * 校园公告管理
	 * */
	//校园公告管理---查询公告的信息
	public List<TblCampus> findCampusBulletinAll(Map<String, Object> map);

	//校园公告管理--对应公告的记录值
	public Long findCampusBulletinAllCount(Map<String, Object> map);

	//校园公告----新增
	public int addCampusBulletin(TblCampus tblCampus);

	//校园公告----删除
	public int delCampusBulletin(int campusinfoid);

	//校园公告----修改
	public int updateCampusBulletin(TblCampus tblCampus);

	/*
	 * 教师考勤信息
	 * */
	//教师考勤信息--查询记录
	public List<TblTeacherAttend> findTeacherAttendAll(Map<String, Object> map);
	//教师考勤信息--查询记录次数
	public Long findTeacherAttendAllCount(Map<String, Object> map);
	//教师考勤对应的显示--考勤信息值
	public List<TblTertime> findALLTeacherAttendDetail(TblTeacherAttend tblTeacherAttend);
}
