package com.great.kindergarten.director.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.mapper.RectorMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class RectorService
{

	@Resource
	private RectorMapper rectorMapper;

	//登录查询对应的内容
	public TblRector findRector(TblRector tblRector)
	{
		return rectorMapper.findRector(tblRector);
	}

	//判断密码是不是正确的
	public TblRector selectoldPwd(TblRector tblRector)
	{
		return rectorMapper.selectoldPwd(tblRector);
	}

	//更新密码
	@Transactional
	public int updateByIdPwd(TblRector tblRector)
	{
		return rectorMapper.updateByIdPwd(tblRector);
	}

	/* 教师模块设计*/
	//查询教师对应的信息
	public List<TblTeacher> findTeacherAll(Map<String, Object> map)
	{
		return rectorMapper.findTeacherAll(map);
	}

	//教师模块--查询记录条数
	public Long findTeacherAllCount(Map<String, Object> map)
	{
		return rectorMapper.findTeacherAllCount(map);
	}

	@Transactional
	//对应的教师表格信息的---删除语句
	public int delTeacherTable(int teacherid)
	{
		return rectorMapper.delTeacherTable(teacherid);
	}

	//	对应的教师表格信息--更新语句信息
	@Transactional
	public int updateTeacherById(TblTeacher tblTeacher)
	{
		int result = rectorMapper.updateTeacherById(tblTeacher);
		return result;
	}

	//对应的进行教师的新增
	@Transactional
	public int addTeacherForm(TblTeacher tblTeacher)
	{
		return rectorMapper.addTeacherForm(tblTeacher);
	}

	/*
	* 幼儿管理
	* */
	//查询幼儿对应的信息
	public List<TblStudent> findChildrenAll(Map<String, Object> map)
	{
		return rectorMapper.findChildrenAll(map);
	}

	//幼儿模块--查询记录条数
	public Long findChildrenAllCount(Map<String, Object> map)
	{
		return rectorMapper.findChildrenAllCount(map);
	}

	//对应的幼儿----新增
	@Transactional
	public int addChildrenForm(TblStudent tblStudent)
	{
		return rectorMapper.addChildrenForm(tblStudent);
	}

	//对应的幼儿----删除
	@Transactional
	public int delChildrenTable(int studentid)
	{
		return rectorMapper.delChildrenTable(studentid);
	}

	//对应的幼儿----修改
	@Transactional
	public int updateChildrenById(TblStudent tblStudent)
	{
		int result = rectorMapper.updateChildrenById(tblStudent);
		return result;
	}

	/*
	 * 家长和学生的两表联查
	 * */
	//查询家长和学生对应的信息
	public List<TblParent> findParentAll(Map<String, Object> map){
		return rectorMapper.findParentAll(map);
	}

	//家长模块--查询家长和学生记录条数
	public Long findParentAllCount(Map<String, Object> map){
		return rectorMapper.findParentAllCount(map);
	}


	//对应的进行家长的新增

	public int addParentForm(TblParent tblParent){
		return rectorMapper.addParentForm(tblParent);
	}
	//查询对应的新增家长的ID
	public TblParent selectParentByPid(String studentname){
		return rectorMapper.selectParentByPid(studentname);
	}
	//修改对应的学生表的pid
	public int updateChildrenByPid(Map<String, Object> map){
		return rectorMapper.updateChildrenByPid(map);
	}

}
