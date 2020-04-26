package com.great.kindergarten.teacher.service;

import com.great.kindergarten.commons.entity.*;

import com.great.kindergarten.teacher.mapper.TeacherMapper;
import com.great.kindergarten.teacher.resultbean.PickUpInfoDetailPage;
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

    //添加系统日志

    @Transactional
    public int addLog(TblSyslog log)
    {
        return teacherMapper.addLog(log);
    }

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
    //获取园所动态news
    public List<TblCampus> findKinderNews(Integer kinderid){
        Map<String, Object> KinderNewsmap = new LinkedHashMap<>();
        KinderNewsmap.put("kinderid",kinderid);
        return teacherMapper.findKinderNews(KinderNewsmap);
    }

    //修改密码
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

    //  根据cid 查找班级所有
    public List<TblClass> findClassName(Integer cid)
    {

        return teacherMapper.findClassName(cid);
    }
    //根据班级名查找id
    public Integer findClassidByName(TblClass tblClass)
    {
        return teacherMapper.findClassidByName(tblClass);
    }

    //查询发布作业表中最后一个id

    public Integer findFinallyWorkreleaseid()
    {
        return teacherMapper.findFinallyWorkreleaseid();
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
    public Boolean workScore(String score,String sid,String workreleaseid ){
        Map<String,String> scoreMap = new LinkedHashMap<>();
        scoreMap.put("score",score);
        scoreMap.put("sid",sid);
        scoreMap.put("workreleaseid",workreleaseid);
        return teacherMapper.workScore(scoreMap);
    }
    //    查看视频数量
    public Integer findSafetyCount(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findSafetyCount(dataHashMap);
    }
    //查看视频表
    public List<TblSafetyConfig> findSafetyTable(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findSafetyTable(dataHashMap);
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

    // 根据cid查班级人数

    public Integer findStudentCount(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findStudentCount(dataHashMap);
    }
    //    根据cid查班级人员数据

    public List<TblStudent> findStudent(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findStudent(dataHashMap);
    }


    /**
     * 根据条件找到孩子的接送信息
     * @param pickUpInfoDetailPage
     * @return
     */
    public List<TblDate> findALLPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage){
        return teacherMapper.findALLPickUpDetailInfo(pickUpInfoDetailPage);
    }


    //    新增照片

    /**
     * 新增照片
     * @param tblPhoto
     * @return
     */
    @Transactional
    public Boolean uploadPhoto(TblPhoto tblPhoto){
        return teacherMapper.uploadPhoto(tblPhoto);
    }

    // 查询班级相册总数
    public Integer findClassPhotoCount(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findClassPhotoCount(dataHashMap);
    }
    //     查看班级相册数据
    public List<TblPhoto> findClassPhoto(HashMap<String,Object> dataHashMap)
    {
        return teacherMapper.findClassPhoto(dataHashMap);
    }
    //班级通知
    @Transactional
    public Boolean addClassMsg(TblClamsg tblClamsg){
        return teacherMapper.addClassMsg(tblClamsg);
    }

    public Integer findExistTeacherName(String teachername){
        Map<String,String> teachermap = new LinkedHashMap<>();
        teachermap.put("teachername",teachername);
        return teacherMapper.findExistTeacherName(teachermap);
    }
    //重置密码
    public Boolean resetTeacherpwd(String teachername,String teacherphone){
        Map<String,String> teachermap = new LinkedHashMap<>();
        teachermap.put("teachername",teachername);
        teachermap.put("teacherphone",teacherphone);
        return teacherMapper.resetTeacherpwd(teachermap);
    }
    //班级消息通知---查询消息通知
    public List<TblClamsg> findClassMessageAll(Map<String, Object> map){
        return teacherMapper.findClassMessageAll(map);
    }

    //班级消息通知--对应消息通知记录值
    public Long findClassMessageAllCount(Map<String, Object> map){
        return teacherMapper.findClassMessageAllCount(map);
    }
}
