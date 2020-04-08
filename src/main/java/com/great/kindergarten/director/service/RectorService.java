package com.great.kindergarten.director.service;

import com.great.kindergarten.commons.entity.TblKinder;
import com.great.kindergarten.commons.entity.TblRector;
import com.great.kindergarten.commons.entity.TblTeacher;
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
}
