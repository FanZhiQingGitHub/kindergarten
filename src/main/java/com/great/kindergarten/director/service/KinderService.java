package com.great.kindergarten.director.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.mapper.KinderMapper;
import com.great.kindergarten.director.resultbean.TblScTInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author JK
 * 实体类
 */
@Service
public class KinderService
{
	@Resource
	private KinderMapper kinderMapper;

	//申请园所
	@Transactional
	public int addKinderMsg(TblKinder tblKinder)
	{
		return kinderMapper.addKinderMsg(tblKinder);
	}

	/*
	 * 课程管理
	 * */
	//查询班级和教师对应的信息
	public List<TblTeacher> findClassTeacherAll(Map<String, Object> map)
	{
		return kinderMapper.findClassTeacherAll(map);
	}

	//查询班级和教师记录条数
	public Long findClassTeacherAllCount(Map<String, Object> map)
	{
		return kinderMapper.findClassTeacherAllCount(map);
	}

	/*
	 * 对应的课程信息
	 * */
	//课程管理---查询课程的信息
	public List<TblCourse> findAllCourseName(Map<String, Object> map)
	{
		return kinderMapper.findAllCourseName(map);
	}

	//课程管理--对应的课程的记录值
//	public Long findAllCourseNameCount(Map<String, Object> map)
//	{
//		return kinderMapper.findAllCourseNameCount(map);
//	}

	//课程管理--添加课程表
	public int addTblCourseInfo(List<TblCourse> tblCourseList)
	{
		return kinderMapper.addTblCourseInfo(tblCourseList);
	}

	//删除--课程表
	public int delTblCourseInfo(int cid,int ctids){
		return kinderMapper.delTblCourseInfo(cid,ctids);
	}

	//添加对应的课程时间表的内容
	public int addCoursetestInfo(TblCoursetest tblCoursetest){
		return kinderMapper.addCoursetestInfo(tblCoursetest);
	}
	//查询对应的课程时间表的ID值
	public int findCoursetestID(Map<String, Object> map){
		return kinderMapper.findCoursetestID(map);
	}

	/*
	 * 班级管理
	 * */
	//查询对应的班级有哪些老师

	//查找对应的所有学生信息
	public List<TblTeacher> findTeacherClassAll()
	{
		return kinderMapper.findTeacherClassAll();
	}

	//新增对应的班级
	@Transactional
	public int addClassForm(TblClass tblClass)
	{
		return kinderMapper.addClassForm(tblClass);
	}

	//查询对应的新增的班级的id值
	public TblClass selectClassByCid(String classname)
	{
		return kinderMapper.selectClassByCid(classname);
	}

	//修改对应的教师表的cid
	@Transactional
	public int updateTeacherByCid(Map<String, Object> map)
	{
		return kinderMapper.updateTeacherByCid(map);
	}

	//班级表对应的删除操作
	@Transactional
	public int delClassTable(int classid)
	{
		return kinderMapper.delClassTable(classid);
	}

	//查询对应的教师表的id值
	public TblTeacher selectTeacherByTeacherId(int classid)
	{
		return kinderMapper.selectTeacherByTeacherId(classid);
	}

	//对应的班级表的修改操作
	@Transactional
	public int updateClassTable(TblClass tblClass)
	{
		return kinderMapper.updateClassTable(tblClass);
	}

	/*
	 * 班级成员管理
	 * */
	//班级成员管理---查询课程的信息
	public List<TblScTInfo> findClassMemberAll(Map<String, Object> map){
		return kinderMapper.findClassMemberAll(map);
	}

	//班级成员管理--对应的课程的记录值
	public Long findClassMemberAllCount(Map<String, Object> map){
		return kinderMapper.findClassMemberAllCount(map);
	}
	//对应的查询班级
	public List<TblClass> findAllClassAll(){
		return kinderMapper.findAllClassAll();
	}
	//添加对应的班级成员信息
	@Transactional
	public int updateStudentByCid(Map<String, Object> map)
	{
		return kinderMapper.updateStudentByCid(map);
	}

	/*
	* 校园公告管理
	* */
	//校园公告管理---查询公告的信息
	public List<TblCampus> findCampusBulletinAll(Map<String, Object> map){
		return kinderMapper.findCampusBulletinAll(map);
	}

	//校园公告管理--对应公告的记录值
	public Long findCampusBulletinAllCount(Map<String, Object> map){
		return kinderMapper.findCampusBulletinAllCount(map);
	}

	//校园公告----新增
	@Transactional
	public int addCampusBulletin(TblCampus tblCampus)
	{
		return kinderMapper.addCampusBulletin(tblCampus);
	}

	//校园公告----删除
	@Transactional
	public int delCampusBulletin(int campusinfoid)
	{
		return kinderMapper.delCampusBulletin(campusinfoid);
	}

	//校园公告----修改
	@Transactional
	public int updateCampusBulletin(TblCampus tblCampus)
	{
		int result = kinderMapper.updateCampusBulletin(tblCampus);
		return result;
	}

	/*
	* 教师考勤信息
	* */
	//教师考勤信息--查询记录
	public List<TblTeacherAttend> findTeacherAttendAll(Map<String, Object> map)
	{
		return kinderMapper.findTeacherAttendAll(map);
	}
	//教师考勤信息--查询记录次数
	public Long findTeacherAttendAllCount(Map<String, Object> map){
		return kinderMapper.findTeacherAttendAllCount(map);
	}

	//教师考勤对应的显示--考勤信息值
	public List<TblTertime> findALLTeacherAttendDetail(TblTeacherAttend tblTeacherAttend){
		return kinderMapper.findALLTeacherAttendDetail(tblTeacherAttend);
	}

}
