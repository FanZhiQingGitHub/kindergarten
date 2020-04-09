package com.great.kindergarten.teacher.service;

import com.great.kindergarten.commons.entity.TblTeacher;
import com.great.kindergarten.teacher.mapper.TeacherMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    public TblTeacher checkPwd(Integer teacherid){

        return teacherMapper.checkPwd(teacherid);
    }
    @Transactional
    public Boolean updateTeacherPwd(String teacherpwd,String teacherid){
        Map<String,String> teacherMap = new LinkedHashMap<>();
        teacherMap.put("teacherpwd",teacherpwd);
        teacherMap.put("teacherid",teacherid);

        return teacherMapper.updateTeacherPwd(teacherMap);
    }
}
