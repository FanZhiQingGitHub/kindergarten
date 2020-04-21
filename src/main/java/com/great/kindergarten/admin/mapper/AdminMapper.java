package com.great.kindergarten.admin.mapper;

import com.great.kindergarten.admin.javabean.MenuTreeInfo;
import com.great.kindergarten.admin.javabean.TblStatistics;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author LXC
 */

@Mapper
public interface AdminMapper
{

	/**
	 * @param adminname
	 * @return
	 */
	public String findAdminStatus(@Param(value = "adminname") String adminname);

	/**
	 * @param tblAdmin
	 * @return
	 */
	public TblAdmin adminLogin(TblAdmin tblAdmin);

	public List<TblAdmin> findAdminByName(String name);

	public TblAdmin findTblAdminByName(String name);

	//树形菜单
	public List<TblMenu> findMenuByName(String name);

	public List<TblMenu> findMenuBySid(Integer sid);

	//一级菜单
	public List<TblMenu> findStairMenu();

	//	public List<TblMenuInfo> findAllMenu(HashMap<String, Object> condition, RowBounds rowBounds);

	//菜单管理
	public List<TblMenu> findAllMenu(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findMenuCount(HashMap<String, Object> condition);

	//新增菜单
	public int addMenuInfo(TblMenu tblMenu);

	public Integer findSidByName(String menuname);

	public int updateMenuInfo(TblMenu tblMenu);

	public int deleteMenuInfo(Integer menuid);

	public int deleteRoleMenu(Integer rolemenuid);

	public Integer findRoleMenuIdByMid(Integer menuid);

	public Integer findSidByMid(Integer menuid);

	//查找父级菜单
	public String findSuperierMenu(Integer menuid);

	public String findRoleByRid(Integer rid);

	public Integer checkMenuName(String menuName);

	//角色管理
	public List<TblRole> findAllRoleInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findRoleCount(HashMap<String, Object> condition);

	public List<String> findAllRoleName();

	public int updateRoleInfo(TblRole tblRole);

	public int deleteRoleInfo(Integer roleid);

	public List<TblRoleMenu> findRoleMenuIdByRid(Integer roleid);

	public int addRoleInfo(TblRole tblRole);

	public Integer checkRoleName(String roleName);

	//修改管理员密码
	public int updateAdminPwd(Map<String, String> adminMap);

	//园所管理
	public List<TblKinder> findAllKinder(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findAllCount(HashMap<String, Object> condition);

	//资质审批
	public int checkQualify(String kinderstatus, Integer kinderid, String kinderapptime);

	public TblKinder findTblKinderById(Integer kinderid);

	public List<TblKinder> findKinder();

	public String findAccountByName(String kindername);

	//新增园所
	public int addKinder(List<TblKinder> tblKinderList);

	public int updateKinderCode(TblKinder tblKinder);

	public int restKinderPwd(TblKinder tblKinder);

	public int updateKinderInfo(TblKinder tblKinder);

	public int deleteKinderInfo(TblKinder tblKinder);

	public String initialPwd(String parametername);

	//参数配置
	public List<TblParameter> findAllParameter(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findParameterCount(HashMap<String, Object> condition);

	public List<TblParameter> findParameterInfo();

	public List<String> findAllParameterType();

	public int addParameter(List<TblParameter> tblParameterList);

	public int updateParameter(TblParameter tblParameter);

	public int deleteParameter(Integer parameterid);

	//亲子阅读管理
	public List<TblReadmag> findAllReadInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findReadCount(HashMap<String, Object> condition);

	public int deleteReadInfo(Integer readMagId);

	public int addPhotoImg(TblReadmag tblReadmag);

	public int reUploadBook(TblReadmag tblReadmag);

	public List<TblRole> findRoleInfo();

	public List<TblMenu> findMenuByRid(Integer roleid);

	//平台资讯
	public List<TblPlatforminfo> findAllPlatFormInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findPlatFormInfoCount(HashMap<String, Object> condition);

	public int releasePlatFormInfo(TblPlatforminfo tblPlatforminfo);

	public int cancelPlatFormInfo(TblPlatforminfo tblPlatforminfo);

	public int deletePlatFormInfo(Integer platforminfoid);

	public int updatePlatFormInfo(TblPlatforminfo tblPlatforminfo);

	public int addPlatFormInfo(TblPlatforminfo tblPlatforminfo);

	//园长管理
	public List<TblRector> findAllRectorInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findRectorInfoCount(HashMap<String, Object> condition);

	public int restRectorPwd(TblRector tblRector);

	public int updateRector(TblRector tblRector);

	public int deleteRector(Integer rectorid);

	public int updateRectorStatus(TblRector tblRector);

	public int addRector(List<TblRector> tblRectorList);

	//教师管理
	public List<TblTeacher> findAllTeacherInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findTeacherInfoCount(HashMap<String, Object> condition);

	public int restTeacherPwd(TblTeacher tblTeacher);

	public int updateTeacher(TblTeacher tblTeacher);

	public int deleteTeacher(Integer teacherid);

	public int updateTeacherStatus(TblTeacher tblTeacher);

	public int addTeacher(List<TblTeacher> tblTeacherList);

	public List<String> findAllJob();

	//家长管理
	public List<TblParent> findAllParentInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findParentInfoCount(HashMap<String, Object> condition);

	public int restParentPwd(TblParent tblParent);

	public int updateParent(TblParent tblParent);

	public int deleteParent(Integer parentId);

	public int updateParentStatus(TblParent tblParent);

	public int addParent(List<TblParent> tblParentList);

	public List<String> findParentJob();

	//保健员管理
	public List<TblHealther> findAllHealtherInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findHealtherInfoCount(HashMap<String, Object> condition);

	public int restHealtherPwd(TblHealther tblHealther);

	public int updateHealther(TblHealther tblHealther);

	public int deleteHealther(Integer healtherId);

	public int updateHealtherStatus(TblHealther tblHealther);

	public int addHealther(List<TblHealther> tblHealtherList);

	//	public List<String> findHealtherJob();

	//安防员管理
	public List<TblSecurity> findAllSecurityInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findSecurityInfoCount(HashMap<String, Object> condition);

	public int restSecurityPwd(TblSecurity tblSecurity);

	public int updateSecurity(TblSecurity tblSecurity);

	public int deleteSecurity(Integer securityId);

	public int updateSecurityStatus(TblSecurity tblSecurity);

	public int addSecurity(List<TblSecurity> tblSecurityList);

	//学生管理
	public List<TblStudent> findAllStudentInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findStudentInfoCount(HashMap<String, Object> condition);

	public int restStudentPwd(TblStudent tblStudent);

	public int updateStudent(TblStudent tblStudent);

	public int deleteStudent(Integer studentId);

	public int updateStudentStatus(TblStudent tblStudent);

	public int addStudent(List<TblStudent> tblStudentList);

	//安全教育管理
	public List<TblSafetyvideo> findAllSafetyVideoInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findSafetyVideoInfoCount(HashMap<String, Object> condition);

	public int deleteSafetyVideoInfo(Integer safetyVideoId);

	public int updateSafetyVideo(TblSafetyvideo tblSafetyvideo);

	public int addSafetyVideo(List<TblSafetyvideo> tblSafetyvideoList);

	//试题配置管理

	public List<TblSafetyvtq> findAllSafetyVideoItemsInfo(Integer safetyVideoId);

	public List<TblSafetyvideo> findAllVideoQuestionConfigInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int addTopic(TblSafetyvtq tblSafetyvtq);

	public List<TblSafetyvtq> queryTopicById(Integer safetyVideoId);

	public int updateTopic(TblSafetyvtq tblSafetyvtq);

	public int deleteTopic(TblSafetyvtq tblSafetyvtq);

	//幼儿统计
	public List<TblExamination> findChildrenStatisticsInfo();

	//男性
	public List<TblStatistics> findChildrenMaleInfo();

	//女性
	public List<TblStatistics> findChildrenFeMaleInfo();

	public List<TblStatistics> findChildrenAAgeInfo();

	public List<TblStatistics> findChildrenBAgeInfo();

	public List<TblStatistics> findChildrenCAgeInfo();

	public List<TblStatistics> findChildrenAgeInfo();

	public List<TblStatistics> findChildrenStatusInfo();

	public List<TblStatistics> findTSexInfo();

	public List<TblStatistics> findTAgeInfo();

	//权限
	public List<MenuTreeInfo> findAllMenuInfo();

	public List<MenuTreeInfo> findMenuByRoleID(Integer rid);

	public int deleteMenuId(Integer rid);

	public int updateMenu(List<Map<String, Integer>> mapList);

	public List<TblRole> findRoleInfos(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findRoleCounts(HashMap<String, Object> condition);

	public List<TblMenu> getAllMenu();
}
