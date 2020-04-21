package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.resultbean.TblScTInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author JK
 */
@Mapper
public interface KinderMapper
{
	//判断对应的园所是不是唯一
	public TblKinder selectKinderName(String kindername);

	//判断对应的园所账号是不是唯一
	public TblKinder selectKinderAccount(String kinderacount);

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
	public int delTblCourseInfo(int cid, int ctids);

	//添加对应的课程时间表的内容
	public int addCoursetestInfo(TblCoursetest tblCoursetest);
	//查询对应的课程时间表的ID值
	public int findCoursetestID(Map<String, Object> map);

	/*
	 * 班级管理
	 * */
	//判断对应的班级有哪些老师的名称是不是重复
	public TblClass selectClassName(String classname);

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

	/*
	 * 显示对应的教师考勤时间表是否有对应的时间
	 * */
	//（1）对应的时间表的ID值
	public List<TblTeacherAttend> findTeaAtteByTid(int teacherid);
	//（2）对应的时间表在没有的时候要进行对应的添加使用
	public boolean addDateTeaAttend(TblTeacherAttend tblTeacherAttend);
	//（3）对应的时间表要进行更新使用
	public boolean updateDateTeaAttend(TblTeacherAttend tblTeacherAttend);
	//（3）查找下午是否有过添加该字段了-如果有的话，就进行对应的
	public TblTertime findAfternoon(Map<String, Object> map);
	//（4）添加对应的下午的信息--添加到对应的字段
	public boolean addPmTerTimeMsg(TblTertime tblTertime);
	//（5）更新下午对应的信息--更新对应的下午信息进去
	public boolean updatePmTerTimeMsg(TblTertime tblTertime);
	//（6）添加对应的上午的信息--添加到对应的字段
	public boolean addAmTerTimeMsg(TblTertime tblTertime);
	//（7）更新上午对应的信息--更新对应的上午信息进去
	public boolean updateAmTerTimeMsg(TblTertime tblTertime);
	//（8）添加对应的中午的信息--添加到对应的字段
	public boolean addOmTerTimeMsg(TblTertime tblTertime);
	//（9）更新中午对应的信息--更新对应的上午信息进去
	public boolean updateOmTerTimeMsg(TblTertime tblTertime);
	/*
	* 消息通知
	* */
	//查询对应的园所的ID值
	public int selectkinderByName(String kindername);

	//添加对应的消息信息到对应的消息表----tblInfotype
	public int addInfoType(TblInfotype tblInfotype);


	//消息通知---查询消息通知
	public List<TblInfotype> findSchoolMessageAll(Map<String, Object> map);

	//消息通知--对应消息通知记录值
	public Long findSchoolMessageAllCount(Map<String, Object> map);


}
