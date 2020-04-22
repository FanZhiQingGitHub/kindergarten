package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Mapper
public interface RectorMapper
{
	//登录查询对应的内容
	public TblRector findRector(TblRector tblRector);

	//判断密码是不是正确的
	public TblRector selectoldPwd(TblRector tblRector);

	//更新密码
	public int updateByIdPwd(TblRector tblRector);

	//更新对应的园长端的密码是不是正确的
	public boolean resetRectorPwd(String rectorphone);

	//查询对应的园长是不是有园所
	public TblKinder selectkinderId(Integer recid);

	/*
	 * 教师模块的设计
	 * */
	//教师模块设计
	public List<TblTeacher> findTeacherAll(Map<String, Object> map);

	//教师模块--查询记录条数
	public Long findTeacherAllCount(Map<String, Object> map);

	//对应的教师表格信息的删除
	public int delTeacherTable(int teacherid);

	//判断教师的名称是不是重复
	public TblTeacher selectTeacherName(String teachername);

	//	对应的教师表格信息--更新语句信息
	public int updateTeacherById(TblTeacher tblTeacher);

	//对应的进行教师的新增
	public int addTeacherForm(TblTeacher tblTeacher);

	/*
	 * 幼儿管理
	 * */
	//查询幼儿对应的信息
	public List<TblStudent> findChildrenAll(Map<String, Object> map);

	//幼儿模块--查询记录条数
	public Long findChildrenAllCount(Map<String, Object> map);

	//判断学生的名称是不是重复
	public TblStudent selectStudentName(String studentname);

	//对应的进行幼儿的新增
	public int addChildrenForm(TblStudent tblStudent);

	//对应的幼儿----删除
	public int delChildrenTable(int studentid);

	//对应的幼儿----修改
	public int updateChildrenById(TblStudent tblStudent);

	/*
	 * 家长和学生的两表联查
	 * */
	//查询家长和学生对应的信息
	public List<TblParent> findParentAll(Map<String, Object> map);

	//家长模块--查询家长和学生记录条数
	public Long findParentAllCount(Map<String, Object> map);

	//判断家长的名称是不是重复
	public TblParent selectParentName(String parentName);

	//对应的进行幼儿的新增
	public int addParentForm(TblParent tblParent);

	public TblParent selectParentByPid(String studentname);

	public int updateChildrenByPid(Map<String, Object> map);

	//查找对应的所有学生信息
	public List<TblStudent> findChildrenParentAll(Integer kid);

	/*家长的删除*/
	public int delParentTable(int parentId);

	/*
	 * 家长对应的信息进行修改操作
	 * */
	public int updateParentTable(TblParent tblParent);

	//对应的修改先删除
	public TblStudent selectStudentByStudentId(int pid);
	//	public int updateChildrenByPidDown(Map<String, Object> map);


}
