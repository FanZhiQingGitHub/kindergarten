package com.great.kindergarten.teacher.service;

import com.great.kindergarten.admin.mapper.AdminMapper;
import com.great.kindergarten.teacher.javabean.TblTeacher;
import com.great.kindergarten.teacher.mapper.TeacherMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class TeacherService {

    @Resource
    private TeacherMapper teacherMapper;

    public String findTeacherStatus(String teachername){
        Map<String,String> teachermap = new LinkedHashMap<>();
        teachermap.put("teachername",teachername);
        return teacherMapper.findTeacherStatus(teachermap);
    }
    public TblTeacher findTeacher(TblTeacher tblTeacher){

        return teacherMapper.findTeacher(tblTeacher);
    }

}
