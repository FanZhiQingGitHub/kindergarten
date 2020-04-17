package com.great.kindergarten.teacher.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.teacher.mapper.TeacherMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
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
//    查找班级名称
    public TblClass findClassAll(Integer cid){

        return teacherMapper.findClassAll(cid);
    }

    //根据班级id，当前时间查找课程信息
    public List<TblCourse> findCourseByTodayCid(HashMap<String,Object> dataHashMap){
        return teacherMapper.findCourseByTodayCid(dataHashMap);
    }

    //    查找班级所有名称
    public List<TblClass> findClassName()
    {

        return teacherMapper.findClassName();
    }
    //根据班级名查找id
    public Integer findClassidByName(TblClass tblClass)
    {
        return teacherMapper.findClassidByName(tblClass);
    }
    //新增发布作业信息
    @Transactional
    public Boolean addFileInfo(TblWorkrelease tblWorkrelease){
        return teacherMapper.addFileInfo(tblWorkrelease);
    }

    //   根据班级id 发布作业id查作业表
    public List<TblWork> findWorkTable(HashMap<String,Object> dataHashMap){

        return teacherMapper.findWorkTable(dataHashMap);
    }
    //    查找作业数据数量
    public Integer findWorkCount(Integer cid)
    {
        return teacherMapper.findWorkCount(cid);
    }
    //打分

    @Transactional
    public Boolean workScore(String score,String sid){
        Map<String,String> scoreMap = new LinkedHashMap<>();
        scoreMap.put("score",score);
        scoreMap.put("sid",sid);
        return teacherMapper.workScore(scoreMap);
    }
    //    查看视频数量
    public Integer findSafetyCount()
    {
        return teacherMapper.findSafetyCount();
    }
    //查看视频表
    public List<TblSafetyConfig> findSafetyTable(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findSafetyTable(dataHashMap);
    }
    //新增上传视频
    @Transactional
    public Boolean uploadVideo(TblSafetyvideo tblSafetyvideo){
	    return teacherMapper.uploadVideo(tblSafetyvideo);
    }
    //查找所有安全视频名称
    public List<TblSafetyvideo> findVideoName(){
        return teacherMapper.findVideoName();
    }
    //根据视频名查id
    public Integer findSafetyvideoidByName(TblSafetyvideo tblSafetyvideo){
        return teacherMapper.findSafetyvideoidByName(tblSafetyvideo);
    }
    //新增安全配置
    @Transactional
    public Boolean addSafetyConfig(TblSafetyConfig tblSafetyConfig){
        return teacherMapper.addSafetyConfig(tblSafetyConfig);
    }
    /**
     * 根据题目id找到配对的试题
     * @param safetyVideoId
     * @return
     */
    public List<TblSafetyvtq> findSafetyTestQuestionList(Integer safetyVideoId){
        return teacherMapper.findSafetyTestQuestionList(safetyVideoId);
    }

    // 查询试题完成情况总数

    public Integer findSafetytqCount(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findSafetytqCount(dataHashMap);
    }
//    查询试题完成情况表

   public List<TblSafetyFinish> findSafetytqTable(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findSafetytqTable(dataHashMap);
    }
}
