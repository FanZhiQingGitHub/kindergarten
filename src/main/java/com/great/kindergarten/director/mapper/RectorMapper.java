package com.great.kindergarten.director.mapper;

import com.great.kindergarten.commons.entity.TblRector;
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
	@Transactional
	public int addTeacherForm(TblTeacher tblTeacher);

}
