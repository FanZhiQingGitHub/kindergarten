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

	//判断对应的园所名称是不是唯一
	public TblKinder selectKinderName(String kindername){
		return kinderMapper.selectKinderName(kindername);
	}

	//判断对应的园所账号是不是唯一
	public TblKinder selectKinderAccount(String kinderacount){
		return kinderMapper.selectKinderAccount(kinderacount);
	}

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
	//判断对应的班级有哪些老师的名称是不是重复
	public TblClass selectClassName(String classname){
		return kinderMapper.selectClassName(classname);
	}

	//查找对应的所有学生信息
	public List<TblTeacher> findTeacherClassAll(Map<String, Object> map)
	{
		return kinderMapper.findTeacherClassAll(map);
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
	public List<TblClass> findAllClassAll(Integer kid){
		return kinderMapper.findAllClassAll(kid);
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

	//查询对应的园所的ID值
	public int selectkinderByName(String kindername){
		return kinderMapper.selectkinderByName(kindername);
	}

	/*
	* 显示对应的教师考勤时间表是否有对应的时间
	* */
	//（1）对应的时间表的ID值
	public List<TblTeacherAttend> findTeaAtteByTid(int teacherid){
		return kinderMapper.findTeaAtteByTid(teacherid);
	}
	@Transactional
	//（2）对应的时间表在没有的时候要进行对应的添加使用
	public boolean addDateTeaAttend(TblTeacherAttend tblTeacherAttend){
		return kinderMapper.addDateTeaAttend(tblTeacherAttend);
	}
	//（3）对应的时间表要进行更新使用
	public boolean updateDateTeaAttend(TblTeacherAttend tblTeacherAttend){
		return kinderMapper.updateDateTeaAttend(tblTeacherAttend);
	}
	//（3）查找下午是否有过添加该字段了-如果有的话，就进行对应的
	public TblTertime findAfternoon(Map<String, Object> map){
		return kinderMapper.findAfternoon(map);
	}
	@Transactional
	//（4）添加对应的下午的信息--添加到对应的字段
	public boolean addPmTerTimeMsg(TblTertime tblTertime){
		return kinderMapper.addPmTerTimeMsg(tblTertime);
	}
	@Transactional
	//（5）更新下午对应的信息--更新对应的下午信息进去
	public boolean updatePmTerTimeMsg(TblTertime tblTertime){
		return kinderMapper.updatePmTerTimeMsg(tblTertime);
	}
	@Transactional
	//（6）添加对应的上午的信息--添加到对应的字段
	public boolean addAmTerTimeMsg(TblTertime tblTertime){
		return kinderMapper.addAmTerTimeMsg(tblTertime);
	}
	@Transactional
	//（7）更新上午对应的信息--更新对应的上午信息进去
	public boolean updateAmTerTimeMsg(TblTertime tblTertime){
		return kinderMapper.updateAmTerTimeMsg(tblTertime);
	}
	@Transactional
	//（8）添加对应的中午的信息--添加到对应的字段
	public boolean addOmTerTimeMsg(TblTertime tblTertime){
		return kinderMapper.addOmTerTimeMsg(tblTertime);
	}
	@Transactional
	//（9）更新中午对应的信息--更新对应的上午信息进去
	public boolean updateOmTerTimeMsg(TblTertime tblTertime){
		return kinderMapper.updateOmTerTimeMsg(tblTertime);
	}


	/*
	* 消息通知
	* */
	//添加对应的消息信息到对应的消息表----tblInfotype
	public int addInfoType(TblInfotype tblInfotype){
		return kinderMapper.addInfoType(tblInfotype);
	}

	//消息通知---查询消息通知
	public List<TblInfotype> findSchoolMessageAll(Map<String, Object> map){
		return kinderMapper.findSchoolMessageAll(map);
	}

	//消息通知--对应消息通知记录值
	public Long findSchoolMessageAllCount(Map<String, Object> map){
		return kinderMapper.findSchoolMessageAllCount(map);
	}



}
