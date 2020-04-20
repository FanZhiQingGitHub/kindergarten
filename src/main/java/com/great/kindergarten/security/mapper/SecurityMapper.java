package com.great.kindergarten.security.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.security.resultbean.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SecurityMapper {

    public String findSecurityStatus(Map<String, String> securitymap);

    public TblSecurity securityLogin(Map<String, String> securitymap);

    public TblSecurity findSecurityId(Map<String, String> securitymap);

    public Boolean updateSecurityPwd(Map<String, String> securitymap);

    public Boolean resetSecuritypwd(Map<String, String> securitymap);

    public List<TblClass> findAllClass();

    public List<TblStudent> findALLPickUpInfo(PickUpInfoPage pickUpInfoPage);

    public Long findALLPickUpInfoCount(PickUpInfoPage pickUpInfoPage);

    public List<TblDate> findALLPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage);

    public List<TblStudent> findAllStuInfo();

    public List<TblStudent> findStuLngLetInfo(Map<String, String> stumap);

    public Boolean addAlarmLogInfo(List<TblAlarmLog> tblAlarmLogList);

    public List<TblAlarmLog> findAlarmInfo(AlarmLogPage alarmLogPage);

    public Long findAlarmInfoCount(AlarmLogPage alarmLogPage);

    public Boolean addCoordinate(List<TblCoordinate> tblCoordinateList);

    public TblKinder findKinderId(Map<String, String> KinderIdmap);

    public List<TblCoordinate> findCoordinate(Map<String, String> KinderIdmap);

    public List<TblStuTrack> findStuTrack(Map<String, String> KinderIdmap);

    public List<TblCampus> findKinderNews(Map<String, String> KinderNewsmap);

    public List<TblCoordinate> findLngLatInfo(Map<String, String> KinderNameMap);

    public Boolean deleteLngLatInfo(Integer kinderid);

    public List<TblMonitor> findALLMonitorInfo(MonitorPage monitorPage);

    public Long findALLMonitorInfoCount(MonitorPage monitorPage);

    public List<TblClass> findClassInfo(ClassPage classPage);

    public Long findClassInfoCount(ClassPage classPage);

    public List<TblClamon> findAllMonitorname();

    public List<TblClamon> findMonitornameByClassID(Integer classid);

    public Boolean deleteMnId(Integer classid);

    public Boolean updateTblClamon(List list);


}
