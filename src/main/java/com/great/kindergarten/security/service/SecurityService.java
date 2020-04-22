package com.great.kindergarten.security.service;

import com.great.kindergarten.admin.mapper.AdminMapper;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.security.mapper.SecurityMapper;
import com.great.kindergarten.security.resultbean.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class SecurityService {

    @Resource
    private SecurityMapper securityMapper;

    public String findSecurityStatus(String securityname){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityname",securityname);
        return securityMapper.findSecurityStatus(securitymap);
    }

    public TblSecurity securityLogin(String securityname,String securitypwd){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityname",securityname);
        securitymap.put("securitypwd",securitypwd);
        return securityMapper.securityLogin(securitymap);
    }

    public TblSecurity findSecurityId(String securityname){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityname",securityname);
        return securityMapper.findSecurityId(securitymap);
    }

    @Transactional
    public Boolean updateSecurityPwd(String securitypwd,String securityid){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securitypwd",securitypwd);
        securitymap.put("securityid",securityid);
        return securityMapper.updateSecurityPwd(securitymap);
    }

    @Transactional
    public Boolean resetSecuritypwd(String securityphone){
        Map<String,String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityphone",securityphone);
        return securityMapper.resetSecuritypwd(securitymap);
    }

    public List<TblClass> findAllClass(){
        return securityMapper.findAllClass();
    }

    public List<TblStudent> findALLPickUpInfo(PickUpInfoPage pickUpInfoPage){
        return securityMapper.findALLPickUpInfo(pickUpInfoPage);
    }

    public Long findALLPickUpInfoCount(PickUpInfoPage pickUpInfoPage){
        return securityMapper.findALLPickUpInfoCount(pickUpInfoPage);
    }

    public List<TblDate> findALLPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage){
        return securityMapper.findALLPickUpDetailInfo(pickUpInfoDetailPage);
    }

    public List<TblStudent> findAllStuInfo(){
        return securityMapper.findAllStuInfo();
    }

    public List<TblStudent> findStuLngLetInfo(String studentid,String studentname,String studentbrith){
        Map<String, String> stumap = new LinkedHashMap<>();
        stumap.put("studentid",studentid);
        stumap.put("studentname",studentname);
        stumap.put("studentbrith",studentbrith);
        return securityMapper.findStuLngLetInfo(stumap);
    }


    @Transactional
    public Boolean addAlarmLogInfo(List<TblAlarmLog> tblAlarmLogList){
        return securityMapper.addAlarmLogInfo(tblAlarmLogList);
    }

    public List<TblAlarmLog> findAlarmInfo(AlarmLogPage alarmLogPage){
        return securityMapper.findAlarmInfo(alarmLogPage);
    }

    public Long findAlarmInfoCount(AlarmLogPage alarmLogPage){
        return securityMapper.findAlarmInfoCount(alarmLogPage);
    }

    @Transactional
    public Boolean addCoordinate(List<TblCoordinate> tblCoordinateList){
        return securityMapper.addCoordinate(tblCoordinateList);
    }

    public TblKinder findKinderId(String kindername){
        Map<String, String> KinderIdmap = new LinkedHashMap<>();
        KinderIdmap.put("kindername",kindername);
        return securityMapper.findKinderId(KinderIdmap);
    }

    public List<TblCoordinate> findCoordinate(String kinderid){
        Map<String, String> KinderIdmap = new LinkedHashMap<>();
        KinderIdmap.put("kinderid",kinderid);
        return securityMapper.findCoordinate(KinderIdmap);
    }

    public List<TblStuTrack> findStuTrack(String stuid){
        Map<String, String> KinderIdmap = new LinkedHashMap<>();
        KinderIdmap.put("stuid",stuid);
        return securityMapper.findStuTrack(KinderIdmap);
    }

    public List<TblCampus> findKinderNews(String kindername){
        Map<String, String> KinderNewsmap = new LinkedHashMap<>();
        KinderNewsmap.put("kindername",kindername);
        return securityMapper.findKinderNews(KinderNewsmap);
    }

    public List<TblCoordinate> findLngLatInfo(String kindername){
        Map<String, String> KinderNameMap = new LinkedHashMap<>();
        KinderNameMap.put("kindername",kindername);
        return securityMapper.findLngLatInfo(KinderNameMap);
    }

    @Transactional
    public Boolean deleteLngLatInfo(Integer kinderid){
        return securityMapper.deleteLngLatInfo(kinderid);
    }


    public List<TblMonitor> findALLMonitorInfo(MonitorPage monitorPage){
        return securityMapper.findALLMonitorInfo(monitorPage);
    }

    public Long findALLMonitorInfoCount(MonitorPage monitorPage){
        return securityMapper.findALLMonitorInfoCount(monitorPage);
    }

    public List<TblClass> findClassInfo(ClassPage classPage){
        return securityMapper.findClassInfo(classPage);
    }

    public Long findClassInfoCount(ClassPage classPage){
        return securityMapper.findClassInfoCount(classPage);
    }

    public List<TblClamon> findAllMonitorname(){
        return securityMapper.findAllMonitorname();
    }

    public List<TblClamon> findMonitornameByClassID(Integer classid){
        return securityMapper.findMonitornameByClassID(classid);
    }

    @Transactional
    public Boolean deleteMnId(Integer classid){
        return securityMapper.deleteMnId(classid);
    }

    public Long findMonitorInfoCont(Integer cid){
        return securityMapper.findMonitorInfoCont(cid);
    }

    @Transactional
    public Boolean updateTblClamon(List list){
        return securityMapper.updateTblClamon(list);
    }

    public List<TblMonitor> findALLMonitorInfoMag(MonitorPage monitorPage){
        return securityMapper.findALLMonitorInfoMag(monitorPage);
    }

    public Long findALLMonitorInfoCountMag(MonitorPage monitorPage){
        return securityMapper.findALLMonitorInfoCountMag(monitorPage);
    }

    @Transactional
    public int addLog(TblSyslog log)
    {
        return securityMapper.addLog(log);
    }

}
