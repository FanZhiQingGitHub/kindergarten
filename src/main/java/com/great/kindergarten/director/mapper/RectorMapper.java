package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.TblParent;
import com.great.kindergarten.commons.entity.TblRector;
import com.great.kindergarten.commons.entity.TblStudent;
import com.great.kindergarten.commons.entity.TblTeacher;
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


	/*
	* 教师模块的设计
	* */
	//教师模块设计
	public List<TblTeacher> findTeacherAll(Map<String, Object> map);

	//教师模块--查询记录条数
	public Long findTeacherAllCount(Map<String, Object> map);

	//对应的教师表格信息的删除
	public int delTeacherTable(int teacherid);

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

	//对应的进行幼儿的新增
	public int addParentForm(TblParent tblParent);
	public TblParent selectParentByPid(String studentname);
	public int updateChildrenByPid(Map<String, Object> map);


}
