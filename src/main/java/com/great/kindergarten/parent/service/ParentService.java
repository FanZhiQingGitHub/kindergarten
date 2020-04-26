package com.great.kindergarten.parent.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.MealPage;
import com.great.kindergarten.parent.mapper.ParentMapper;
import com.great.kindergarten.parent.resultbean.LivePage;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

/**
 * @author Administrator
 */
@Service
public class ParentService {

    @Resource
    private ParentMapper parentMapper;

    public ParentService()
    {

    }

    /**
     * 家长端往数据库增加日志
     * @param log
     * @return
     */
    public int addLog(TblSyslog log)
    {
        return parentMapper.addLog(log);
    }




    /**
     *  根据搜索条件找到对应的相册列表
     * @param map
     * @return
     */
    public TableDate findCampusBulletinAll(Map<String, Object> map ){

        TableDate tableDate = new TableDate();
        //计算有几个条数
        tableDate.setCount(parentMapper.findCampusBulletinAllCount(map));
        //放入数据
        tableDate.setData(parentMapper.findCampusBulletinAll(map));

        return tableDate;
    }




    /**
     *  根据搜索条件找到对应的相册列表
     * @param searchCondition
     * @return
     */
    public TableDate findPhotosByCid(SearchCondition searchCondition){

        Integer startPage = (searchCondition.getPage() -1) *searchCondition.getLimit();
        searchCondition.setPage(startPage);

        TableDate tableDate = new TableDate();
        //计算有几个条数
        tableDate.setCount(parentMapper.countPhotosByCid(searchCondition));
        //放入数据
        tableDate.setData(parentMapper.findPhotosByCid(searchCondition));

        return tableDate;
    }









    /**
     * 根据书本id和页面查询数据返回给页面显示内容
     * @param readId
     * @param page
     * @return
     */
    public PageBean<TblReadmag> readBook(Integer readId,Integer page){
        Integer totalRecords=parentMapper.countBookById(readId);

        List<TblReadmag> list =  parentMapper.readBookByIdAndPage(readId, page);

        //封装一个新的页面Bean
        PageBean<TblReadmag> pageInfo = new PageBean<TblReadmag>(page,totalRecords,1);
        //把数据信息放到Bean里面
        pageInfo.setList(list);

        return pageInfo;
    }



    /**
     * 根据条件找到阅读列表
     * @param page
     * @param limit
     * @return
     */
    public PageBean<TblReadmag> findReadList(Integer page ,Integer limit){

        Integer startPage = (page-1) *limit;

        //按条件计算出有几条用户数据
        Integer totalRecords = parentMapper.countReadList();
        //找到记录
        List<TblReadmag> list =  parentMapper.findReadList(startPage,limit);

        //封装一个新的页面Bean
        PageBean<TblReadmag> pageBean = new PageBean<TblReadmag>(page,totalRecords,limit);
        //把数据信息放到Bean里面
        pageBean.setList(list);

        return pageBean;
    }




    /**
     *  根据搜索条件找到对应的孩子体检列表
     * @param searchCondition
     * @return
     */
    public TableDate findExaminationByStudentId(SearchCondition searchCondition){

        Integer startPage = (searchCondition.getPage() -1) *searchCondition.getLimit();
        searchCondition.setPage(startPage);

        TableDate tableDate = new TableDate();
        //计算有几个条数
        tableDate.setCount(parentMapper.countExaminationByStudentId(searchCondition));
        //放入数据
        tableDate.setData(parentMapper.findExaminationByStudentId(searchCondition));

        return tableDate;
    }




    /**
     * 根据膳食id找到相应的膳食信息
     * @param mealId
     * @return
     */
    public TableDate findRecipeInfo(Integer mealId){
        TableDate tableDate = new TableDate();
        tableDate.setCount(1);
        tableDate.setData( parentMapper.findAllRecipeInfo(mealId));
        return tableDate;
    }



    /**
     * 根据id和条件找到孩子作业列表
     * @param searchCondition
     * @return
     */
    public TableDate findAllMealInfo(SearchCondition searchCondition){

        Integer startPage = (searchCondition.getPage() -1) *searchCondition.getLimit();
        searchCondition.setPage(startPage);


        TableDate result = new TableDate();
        //计算总共的页数
        result.setCount(parentMapper.findAllMealInfoCount(searchCondition));
        //放入查询的数据
        result.setData( parentMapper.findAllMealInfo(searchCondition));
        return result;
    }


    /**
     * 根据条件找到孩子的接送信息
     * @param pickUpInfoDetailPage
     * @return
     */
    public List<TblStutime> findPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage){
        return parentMapper.findPickUpDetailInfo(pickUpInfoDetailPage);
    };

    /**
     * 更新作业的路径
     * @param insertHomeWork
     * @return
     */
    public Integer updateWorkUrl(TblWork insertHomeWork){
        return parentMapper.updateWorkUrl(insertHomeWork);
    };

    /**
     * 查询是否已经有记录了
     * @param insertHomeWork
     * @return
     */
    public Integer findSameWorkInsertRecord(TblWork insertHomeWork){
        return parentMapper.findSameWorkInsertRecord(insertHomeWork);
    };

    /**
     * 根据类插入作业信息
     * @param insertHomeWork
     * @return
     */
    public Integer uploadHomeWork(TblWork insertHomeWork){
        return parentMapper.uploadHomeWork(insertHomeWork);
    };

    /**
     * 根据id和条件找到孩子作业列表
     * @param searchCondition
     * @return
     */
    public TableDate kidHomeWorkList(SearchCondition searchCondition,Integer cid){

        Integer startPage = (searchCondition.getPage() -1) *searchCondition.getLimit();
        searchCondition.setPage(startPage);

        TableDate result = new TableDate();
        //计算总共的页数
        result.setCount(parentMapper.countHomeWorkList(searchCondition,cid));
        //放入查询的数据
        result.setData( parentMapper.findHomeWorkList(searchCondition,cid));
        return result;
    }

    /**
     * 根据家长id找到属于自己的宝宝
     * @param parentId
     * @return
     */
    public Result getKids(Integer parentId){
        Result result = new Result();
        result.setData(parentMapper.findKisByParentId(parentId));
        return result;
    }


    /**
     * 根据家长的id和视频id插入相对应的分数
     * @param parentId
     * @param videoId
     * @param score
     * @return
     */
    public boolean recordScore(Integer parentId, Integer videoId, Integer score,Integer safetyConfigId){

        //判断数据是否已经提交
        if (parentMapper.countScore(parentId,safetyConfigId)==0){
            //如果没有提交则插入数据
            parentMapper.recordScore(videoId,parentId,score,new Date(),safetyConfigId);
            return true;
        }

        return false;
    }


    /**
     * 根据题目id找到配对的试题
     * @param safetyVideoId
     * @return
     */
    public List<TblSafetyvtq> findSafetyTestQuestionList(Integer safetyVideoId){
        return parentMapper.findSafetyTestQuestionList(safetyVideoId);
    }


    /**
     * 根据id和条件找到安全视频列表
     * @param searchCondition
     *  @param classId
     * @return
     */
    public TableDate parentSafetyTestList(SearchCondition searchCondition,Integer classId){

        Integer startPage = (searchCondition.getPage() -1) *searchCondition.getLimit();
        searchCondition.setPage(startPage);

        TableDate result = new TableDate();
        //计算总共的页数
        result.setCount(parentMapper.countVideoListNumber(searchCondition,classId));
        //放入查询的数据
        result.setData( parentMapper.findVideoList(searchCondition,classId));
        return result;
    }



    /**
     * 家长根据旧密码修改新密码
     * @param parentId
     * @param parentOldPwd
     * @param parentNewPwd
     * @return
     */
    public Result updateParentPwd(Integer parentId ,String parentOldPwd ,String parentNewPwd){
        Result updateResult = new Result();

        //判断数据是否完整
        if (parentId!=null&&parentOldPwd!=null&&!"".equals(parentOldPwd)&&parentNewPwd!=null&&!"".equals(parentNewPwd)){
            //判断旧密码是否输入正确
            if (parentMapper.countOldParentPwd(parentOldPwd,parentId)>0){
                //判断更改密码是否成功
                if(parentMapper.updateParentPwd(parentNewPwd,parentId)>0){
                    //修改成功
                    updateResult.setSuccess(true);
                }
            }else {
                updateResult.setMsg("oldPwdError");
            }

        }else {
            updateResult.setMsg("error");
        }

        return updateResult;
    }


    /**
     * 找到可以登陆的园所
     * @return
     */
    public List<String> selectLogin(){
        return parentMapper.selectLogin();
    }


    /**
     * 家长端口登陆方法
     * @param parentName
     * @param parentPwd
     * @return
     */
    public TblParent parentLogin(String parentName, String parentPwd){
        return parentMapper.parentLogin(parentName,parentPwd);
    }

    //---------------------------孩子考勤新增方法------------------------------
    /**
     * 查找父母亲和孩子的数据
     */
    public List<TblParent> findParentStuInfo(String parentname){
        Map<String,String> parentMap = new LinkedHashMap<>();
        parentMap.put("parentname",parentname);
        return parentMapper.findParentStuInfo(parentMap);
    }

    /*
    <!--    查找日期表中是否有本周一和本周日的日期-->
     */
    public List<TblDate> findDateInfo(String monday,String sunday){
        Map<String,String> dateMap = new LinkedHashMap<>();
        dateMap.put("monday",monday);
        dateMap.put("sunday",sunday);
        return parentMapper.findDateInfo(dateMap);
    }
    public TblStutime findAmTimeId(String timeamdate){
        Map<String,String> dateMap = new LinkedHashMap<>();
        dateMap.put("timeamdate",timeamdate);
        return  parentMapper.findAmTimeId(dateMap);
    }
    public TblStutime findPmTimeId(String timepmdate){
        Map<String,String> dateMap = new LinkedHashMap<>();
        dateMap.put("timepmdate",timepmdate);
        return  parentMapper.findPmTimeId(dateMap);
    }

    @Transactional
    public Boolean addDateInfo(List<TblDate> tblDateList){
        return parentMapper.addDateInfo(tblDateList);
    }
    @Transactional
    public Boolean addAmAttendance(List<TblStutime> tblStutimeListAm){
        return parentMapper.addAmAttendance(tblStutimeListAm);
    }

    @Transactional
    public Boolean addPmDate(String timepmdate){
        Map<String,String> dateMap = new LinkedHashMap<>();
        dateMap.put("timepmdate",timepmdate);
        return parentMapper.addPmDate(dateMap);
    }

    @Transactional
    public Boolean addPmAttendance(List<TblStutime> tblStutimeListPm){
        return parentMapper.addPmAttendance(tblStutimeListPm);
    }

    @Transactional
    public Boolean addPmAttendanceAll(List<TblStutime> tblStutimeListPm){
        return parentMapper.addPmAttendanceAll(tblStutimeListPm);
    }

    public TblStutime findExistDate(String timeamdate){
        Map<String,String> dateMap = new LinkedHashMap<>();
        dateMap.put("timeamdate",timeamdate);
        return parentMapper.findExistDate(dateMap);
    }
    @Transactional
    public Boolean updateAmAttendance(String timeam,String pnameam,String timeamdate){
        Map<String,String> AmMap = new LinkedHashMap<>();
        AmMap.put("timeam",timeam);
        AmMap.put("pnameam",pnameam);
        AmMap.put("timeamdate",timeamdate);
        return parentMapper.updateAmAttendance(AmMap);
    }
    @Transactional
    public Boolean updatePmAttendance(String timepm,String pnamepm,String timepmdate){
        Map<String,String> PmMap = new LinkedHashMap<>();
        PmMap.put("timepm",timepm);
        PmMap.put("pnamepm",pnamepm);
        PmMap.put("timepmdate",timepmdate);
        return parentMapper.updatePmAttendance(PmMap);
    }

    public List<TblStudent> findAllStuInfo(String parentName){
        Map<String,String> Map = new LinkedHashMap<>();
        Map.put("parentName",parentName);
        return parentMapper.findAllStuInfo(Map);
    }


    public Integer findExistParentName(String parentname){
        Map<String,String> parentmap = new LinkedHashMap<>();
        parentmap.put("parentname",parentname);
        return parentMapper.findExistParentName(parentmap);
    }

    @Transactional
    public Boolean resetParentpwd(String parentname,String parentphone){
        Map<String,String> parentmap = new LinkedHashMap<>();
        parentmap.put("parentname",parentname);
        parentmap.put("parentphone",parentphone);
        return parentMapper.resetParentpwd(parentmap);
    }

    public List<TblMonitor> findALLMonitorInfo(LivePage livePage){
        return parentMapper.findALLMonitorInfo(livePage);
    }

    public Long findALLMonitorInfoCount(LivePage livePage){
        return parentMapper.findALLMonitorInfoCount(livePage);
    }

    public Integer findParentCidByName(String parentname){
        Map<String,String> parentmap = new LinkedHashMap<>();
        parentmap.put("parentname",parentname);
        return parentMapper.findParentCidByName(parentmap);
    }
}
