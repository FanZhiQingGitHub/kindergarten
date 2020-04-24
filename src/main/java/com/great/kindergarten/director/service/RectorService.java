package com.great.kindergarten.director.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.mapper.RectorMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.LinkedHashMap;
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

	//更新对应的园长端的密码是不是正确的
	//重置前查下有没有这个人
	public Integer findExistRectorName(String rectorname){
		Map<String,String> rectorMap = new LinkedHashMap<>();
		rectorMap.put("rectorname",rectorname);
		return rectorMapper.findExistRectorName(rectorMap);
	}
	//根据用户名和手机号码重置
	@Transactional
	public boolean resetRectorPwd(String rectorname,String rectorphone){
		Map<String,String> rectorMap = new LinkedHashMap<>();
		rectorMap.put("rectorname",rectorname);
		rectorMap.put("rectorphone",rectorphone);
		return rectorMapper.resetRectorPwd(rectorMap);
	}

	//查询对应的园长是不是有园所
	public TblKinder selectkinderId(Integer recid){
		return rectorMapper.selectkinderId(recid);
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

	//判断教师的名称是不是重复
	public TblTeacher selectTeacherName(String teachername){
		return rectorMapper.selectTeacherName(teachername);
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

	//判断学生的名称是不是重复
	public TblStudent selectStudentName(String studentname){
		return rectorMapper.selectStudentName(studentname);
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

	//判断家长的名称是不是重复
	public TblParent selectParentName(String parentName){
		return rectorMapper.selectParentName(parentName);
	}

	//对应的进行家长的新增
	@Transactional
	public int addParentForm(TblParent tblParent){
		return rectorMapper.addParentForm(tblParent);
	}
	//查询对应的新增家长的ID
	public TblParent selectParentByPid(String studentname){
		return rectorMapper.selectParentByPid(studentname);
	}

	//修改对应的学生表的pid
	@Transactional
	public int updateChildrenByPid(Map<String, Object> map){
		return rectorMapper.updateChildrenByPid(map);
	}

	//查找对应的所有学生信息
	public List<TblStudent> findChildrenParentAll(Integer kid)
	{
		return rectorMapper.findChildrenParentAll(kid);
	}

	/*
	* 家长的删除操作
	* */
	@Transactional
	public int delParentTable(int parentId)
	{
		return rectorMapper.delParentTable(parentId);
	}
	/*
	* 家长对应的信息进行修改操作
	* */
//	//修改对应的学生表的pid
//	@Transactional
//	public int updateChildrenByPidDown(Map<String, Object> map){
//		return rectorMapper.updateChildrenByPidDown(map);
//	}
	//对应的修改先删除
	public TblStudent selectStudentByStudentId(int pid){
		return rectorMapper.selectStudentByStudentId(pid);
	}

	@Transactional
	public int updateParentTable(TblParent tblParent){
		return rectorMapper.updateParentTable(tblParent);
	}


	/* 保健员模块设计*/
	//查询保健员对应的信息
	public List<TblHealther> findHealtherAll(Map<String, Object> map)
	{
		return rectorMapper.findHealtherAll(map);
	}

	//保健员模块--查询记录条数
	public Long findHealtherAllCount(Map<String, Object> map)
	{
		return rectorMapper.findHealtherAllCount(map);
	}

	@Transactional
	//对应的保健员表格信息的---删除语句
	public int delHealtherTable(int healtherid)
	{
		return rectorMapper.delHealtherTable(healtherid);
	}

	//判断保健员的名称是不是重复
	public TblHealther selectHealtherName(String healthername){
		return rectorMapper.selectHealtherName(healthername);
	}

	//	对应的保健员表格信息--更新语句信息
	@Transactional
	public int updateHealtherById(TblHealther tblHealther)
	{
		int result = rectorMapper.updateHealtherById(tblHealther);
		return result;
	}

	//对应的进行保健员的新增
	@Transactional
	public int addHealtherForm(TblHealther tblHealther)
	{
		return rectorMapper.addHealtherForm(tblHealther);
	}


	/* 安防员模块设计*/
	//查询安防员对应的信息
	public List<TblSecurity> findSecurityAll(Map<String, Object> map)
	{
		return rectorMapper.findSecurityAll(map);
	}

	//安防员模块--查询记录条数
	public Long findSecurityAllCount(Map<String, Object> map)
	{
		return rectorMapper.findSecurityAllCount(map);
	}

	@Transactional
	//对应的安防员表格信息的---删除语句
	public int delSecurityTable(int securityid)
	{
		return rectorMapper.delSecurityTable(securityid);
	}

	//判断安防员的名称是不是重复
	public TblSecurity selectSecurityName(String securityname){
		return rectorMapper.selectSecurityName(securityname);
	}

	//	对应的安防员表格信息--更新语句信息
	@Transactional
	public int updateSecurityById(TblSecurity tblSecurity)
	{
		int result = rectorMapper.updateSecurityById(tblSecurity);
		return result;
	}

	//对应的进行安防员的新增
	@Transactional
	public int addSecurityForm(TblSecurity tblSecurity)
	{
		return rectorMapper.addSecurityForm(tblSecurity);
	}

}
