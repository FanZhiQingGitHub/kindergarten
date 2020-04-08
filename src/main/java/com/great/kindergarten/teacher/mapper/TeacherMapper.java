package com.great.kindergarten.teacher.mapper;

import com.great.kindergarten.commons.entity.TblTeacher;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface TeacherMapper {

	public String findTeacherStatus(Map<String,String> teachermap);
	public TblTeacher findTeacher(TblTeacher tblTeacher);
}
