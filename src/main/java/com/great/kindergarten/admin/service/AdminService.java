package com.great.kindergarten.admin.service;

import com.great.kindergarten.admin.javabean.MenuTreeInfo;
import com.great.kindergarten.admin.javabean.TblStatistics;
import com.great.kindergarten.admin.mapper.AdminMapper;
import com.great.kindergarten.commons.entity.*;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class AdminService {

	@Resource
	private AdminMapper adminMapper;

	public String findAdminStatus(String adminname)
	{
		return adminMapper.findAdminStatus(adminname);
	}

	public TblAdmin adminLogin(TblAdmin tblAdmin)
	{
		return adminMapper.adminLogin(tblAdmin);
	}

	public List<TblAdmin> findAdminByName(String adminname)
	{
		return adminMapper.findAdminByName(adminname);
	}

	public List<TblAdmin> findAllAdmin(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllAdmin(condition,rowBounds);
	}

	public int findAdminCount(HashMap<String, Object> condition)
	{
		return adminMapper.findAdminCount(condition);
	}

	public int addAdminInfos(TblAdmin tblAdmin)
	{
		return adminMapper.addAdminInfos(tblAdmin);
	}

	public int updateAdminInfos(TblAdmin tblAdmin)
	{
		return adminMapper.updateAdminInfos(tblAdmin);
	}

	public int updateAdminStatus(TblAdmin tblAdmin)
	{
		return adminMapper.updateAdminStatus(tblAdmin);
	}

	public int deleteAdmin(Integer adminid)
	{
		return adminMapper.deleteAdmin(adminid);
	}

	public List<TblAdmin> checkAdminName(String adminname)
	{
		return adminMapper.checkAdminName(adminname);
	}

	public List<TblMenu> findMenuByName(String adminname)
	{
		//获取主菜单
		List<TblMenu> rootMenu = new ArrayList<>();
		rootMenu = adminMapper.findMenuByName(adminname);
		//获取子菜单
		for (TblMenu menu : rootMenu)
		{
			menu.setChildrenList(adminMapper.findMenuBySid(menu.getMenuid()));
		}
		return rootMenu;
	}

	public List<TblMenu> findStairMenu()
	{
		//获取主菜单
		List<TblMenu> rootMenu = new ArrayList<>();
		rootMenu = adminMapper.findStairMenu();
		return rootMenu;
	}

	public HashMap<String, List<TblMenu>> findMenus(String adminname)
	{
		List<TblMenu> menuList1 = adminMapper.findMenuByName(adminname);
		LinkedHashMap<String,List<TblMenu>> menuMap = new LinkedHashMap<>();
		for (TblMenu tblMenu : menuList1)
		{
			List<TblMenu> menuList2 = adminMapper.findMenuBySid(tblMenu.getMenuid());
			menuMap.put(tblMenu.getMenuname(), menuList2);
		}
		return menuMap;
	}

	public List<TblMenu> findAllMenu(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllMenu(condition, rowBounds);
	}

	public String findSuperierMenu(Integer menuid)
	{
		return adminMapper.findSuperierMenu(menuid);
	}

	public int addMenuInfo(TblMenu tblMenu)
	{
		return adminMapper.addMenuInfo(tblMenu);
	}

	public Integer findSidByName(String menuname)
	{
		return adminMapper.findSidByName(menuname);
	}

	public int updateMenuInfo(TblMenu tblMenu)
	{
		return adminMapper.updateMenuInfo(tblMenu);
	}

	public int deleteMenuInfo(Integer menuid)
	{
		return adminMapper.deleteMenuInfo(menuid);
	}

	public int deleteRoleMenu(Integer rolemenuid)
	{
		return adminMapper.deleteRoleMenu(rolemenuid);
	}

	public Integer findRoleMenuIdByMid(Integer menuid)
	{
		return adminMapper.findRoleMenuIdByMid(menuid);
	}

	public Integer findSidByMid(Integer menuid)
	{
		return adminMapper.findSidByMid(menuid);
	}

	public int findMenuCount(HashMap<String, Object> condition)
	{
		return adminMapper.findMenuCount(condition);
	}

	public String findRoleByRid(Integer rid)
	{
		return adminMapper.findRoleByRid(rid);
	}

	public TblAdmin findTblAdminByName(String name)
	{
		return adminMapper.findTblAdminByName(name);
	}

	public Integer checkMenuName(String menuName)
	{
		return adminMapper.checkMenuName(menuName);
	}

	//修改管理员密码
	public int updateAdminPwd(String adminpwd,String adminid)
	{
		Map<String,String> adminMap = new LinkedHashMap<>();
		adminMap.put("adminpwd",adminpwd);
		adminMap.put("adminid",adminid);
		return adminMapper.updateAdminPwd(adminMap);
	}

	//园所管理
	public List<TblKinder> findAllKinder(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllKinder(condition,rowBounds);
	}

	public int findAllCount(HashMap<String, Object> condition)
	{
		return adminMapper.findAllCount(condition);
	}

	public int checkQualify(String kinderstatus,Integer kinderid, String kinderapptime)
	{
		return adminMapper.checkQualify(kinderstatus,kinderid, kinderapptime);
	}

	public TblKinder findTblKinderById(Integer kinderid)
	{
		return adminMapper.findTblKinderById(kinderid);
	}

	//园所详情
	public List<TblKinder> findKinderInfoById(Integer kinderid)
	{
		return adminMapper.findKinderInfoById(kinderid);
	}

	public Integer findIdByKinderName(String kinderName)
	{
		return adminMapper.findIdByKinderName(kinderName);
	}

	public Integer findIdByKinderAccount(String kinderAccount)
	{
		return adminMapper.findIdByKinderAccount(kinderAccount);
	}

	public List<TblKinder> selectKinderInfo(Integer kinderId)
	{
		return adminMapper.selectKinderInfo(kinderId);
	}

	public List<TblKinder> findKinder()
	{
		return adminMapper.findKinder();
	}

	public String findAccountByName(String kindername)
	{
		return adminMapper.findAccountByName(kindername);
	}

	public int addKinder(List<TblKinder> tblKinderList)
	{
		return adminMapper.addKinder(tblKinderList);
	}

	public int updateKinderCode(TblKinder tblKinder)
	{
		return adminMapper.updateKinderCode(tblKinder);
	}

	public int restKinderPwd(TblKinder tblKinder)
	{
		return adminMapper.restKinderPwd(tblKinder);
	}

	public int updateKinderInfo(TblKinder tblKinder)
	{
		return adminMapper.updateKinderInfo(tblKinder);
	}

	public int deleteKinderInfo(TblKinder tblKinder)
	{
		return adminMapper.deleteKinderInfo(tblKinder);
	}

	public String initialPwd(String parametername)
	{
		return adminMapper.initialPwd(parametername);
	}

	//角色管理
	public List<TblRole> findAllRoleInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllRoleInfo(condition, rowBounds);
	}

	public int findRoleCount(HashMap<String, Object> condition)
	{
		return adminMapper.findRoleCount(condition);
	}

	public List<String> findAllRoleName()
	{
		return adminMapper.findAllRoleName();
	}

	public int updateRoleInfo(TblRole tblRole)
	{
		return adminMapper.updateRoleInfo(tblRole);
	}

	public int deleteRoleInfo(Integer roleid)
	{
		return adminMapper.deleteRoleInfo(roleid);
	}

	public List<TblRoleMenu> findRoleMenuIdByRid(Integer roleid)
	{
		return adminMapper.findRoleMenuIdByRid(roleid);
	}

	public int addRoleInfo(TblRole tblRole)
	{
		return adminMapper.addRoleInfo(tblRole);
	}

	public Integer checkRoleName(String roleName)
	{
		return adminMapper.checkRoleName(roleName);
	}

	//亲子阅读
	public List<TblReadmag> findAllReadInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllReadInfo(condition, rowBounds);
	}

	public int findReadCount(HashMap<String, Object> condition)
	{
		return adminMapper.findReadCount(condition);
	}

	public int deleteReadInfo(Integer readMagId)
	{
		return adminMapper.deleteReadInfo(readMagId);
	}

	public int addPhotoImg(TblReadmag tblReadmag)
	{
		return adminMapper.addPhotoImg(tblReadmag);
	}

	public int reUploadBook(TblReadmag tblReadmag)
	{
		return adminMapper.reUploadBook(tblReadmag);
	}

	public List<String> findAllReadBookName()
	{
		return adminMapper.findAllReadBookName();
	}

	public List<TblReadmag> findReadInfoByName(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findReadInfoByName(condition, rowBounds);
	}

	public int findReadCountByName(HashMap<String, Object> condition)
	{
		return adminMapper.findReadCountByName(condition);
	}

	public Integer findReadMagIdByName(String readMagName)
	{
		return  adminMapper.findReadMagIdByName(readMagName);
	}
	//权限管理
	public List<TblRole> findRoleInfo()
	{
		return adminMapper.findRoleInfo();
	}

	public List<TblMenu> findMenuByRid(Integer roleid)
	{
		//获取主菜单
		List<TblMenu> rootMenu = new ArrayList<>();
		rootMenu = adminMapper.findMenuByRid(roleid);
		//获取子菜单
		//		for (TblMenu menu : rootMenu)
		//		{
		//			menu.setChildrenList(adminMapper.findMenuBySid(menu.getMenuid()));
		//		}
		return rootMenu;
	}

	public List<TblMenu> findMenuBySid(Integer sid)
	{
		return adminMapper.findMenuBySid(sid);
	}

	//平台资讯

	public List<TblPlatforminfo> findAllPlatFormInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllPlatFormInfo(condition, rowBounds);
	}

	public int findPlatFormInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findPlatFormInfoCount(condition);
	}

	public int releasePlatFormInfo(TblPlatforminfo tblPlatforminfo)
	{
		return adminMapper.releasePlatFormInfo(tblPlatforminfo);
	}

	public int cancelPlatFormInfo(TblPlatforminfo tblPlatforminfo)
	{
		return adminMapper.cancelPlatFormInfo(tblPlatforminfo);
	}

	public int deletePlatFormInfo(Integer platforminfoid)
	{
		return adminMapper.deletePlatFormInfo(platforminfoid);
	}

	public int updatePlatFormInfo(TblPlatforminfo tblPlatforminfo)
	{
		return adminMapper.updatePlatFormInfo(tblPlatforminfo);
	}

	public int addPlatFormInfo(TblPlatforminfo tblPlatforminfo)
	{
		return adminMapper.addPlatFormInfo(tblPlatforminfo);
	}

	//园长管理
	public List<TblRector> findAllRectorInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllRectorInfo(condition, rowBounds);
	}

	public int findRectorInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findRectorInfoCount(condition);
	}

	public int restRectorPwd(TblRector tblRector)
	{
		return adminMapper.restRectorPwd(tblRector);
	}

	public int updateRector(TblRector tblRector)
	{
		return adminMapper.updateRector(tblRector);
	}

	public int deleteRector(Integer rectorid)
	{
		return adminMapper.deleteRector(rectorid);
	}

	public int updateRectorStatus(TblRector tblRector)
	{
		return adminMapper.updateRectorStatus(tblRector);
	}

	public int addRector(List<TblRector> tblRectorList)
	{
		return adminMapper.addRector(tblRectorList);
	}

	//教师管理
	public List<TblTeacher> findAllTeacherInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllTeacherInfo(condition, rowBounds);
	}

	public int findTeacherInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findTeacherInfoCount(condition);
	}

	public int restTeacherPwd(TblTeacher tblTeacher)
	{
		return adminMapper.restTeacherPwd(tblTeacher);
	}

	public int updateTeacher(TblTeacher tblTeacher)
	{
		return adminMapper.updateTeacher(tblTeacher);
	}

	public int deleteTeacher(Integer teacherid)
	{
		return adminMapper.deleteTeacher(teacherid);
	}

	public int updateTeacherStatus(TblTeacher tblTeacher)
	{
		return adminMapper.updateTeacherStatus(tblTeacher);
	}

	public int addTeacher(List<TblTeacher> tblTeacherList)
	{
		return adminMapper.addTeacher(tblTeacherList);
	}

	public List<String> findAllJob()
	{
		return adminMapper.findAllJob();
	}

	//家长管理
	public List<TblParent> findAllParentInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllParentInfo(condition, rowBounds);
	}

	public int findParentInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findParentInfoCount(condition);
	}

	public int restParentPwd(TblParent tblParent)
	{
		return adminMapper.restParentPwd(tblParent);
	}

	public int updateParent(TblParent tblParent)
	{
		return adminMapper.updateParent(tblParent);
	}

	public int deleteParent(Integer parentId)
	{
		return adminMapper.deleteParent(parentId);
	}

	public int updateParentStatus(TblParent tblParent)
	{
		return adminMapper.updateParentStatus(tblParent);
	}

	public int addParent(List<TblParent> tblParentList)
	{
		return adminMapper.addParent(tblParentList);
	}

	public List<String> findParentJob()
	{
		return adminMapper.findParentJob();
	}

	//保健员管理
	public List<TblHealther> findAllHealtherInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllHealtherInfo(condition, rowBounds);
	}

	public int findHealtherInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findHealtherInfoCount(condition);
	}

	public int restHealtherPwd(TblHealther tblHealther)
	{
		return adminMapper.restHealtherPwd(tblHealther);
	}

	public int updateHealther(TblHealther tblHealther)
	{
		return adminMapper.updateHealther(tblHealther);
	}

	public int deleteHealther(Integer healtherId)
	{
		return adminMapper.deleteHealther(healtherId);
	}

	public int updateHealtherStatus(TblHealther tblHealther)
	{
		return adminMapper.updateHealtherStatus(tblHealther);
	}

	public int addHealther(List<TblHealther> tblHealtherList)
	{
		return adminMapper.addHealther(tblHealtherList);
	}

	//安防员管理
	public List<TblSecurity> findAllSecurityInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllSecurityInfo(condition, rowBounds);
	}

	public int findSecurityInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findSecurityInfoCount(condition);
	}

	public int restSecurityPwd(TblSecurity tblSecurity)
	{
		return adminMapper.restSecurityPwd(tblSecurity);
	}

	public int updateSecurity(TblSecurity tblSecurity)
	{
		return adminMapper.updateSecurity(tblSecurity);
	}

	public int deleteSecurity(Integer securityId)
	{
		return adminMapper.deleteSecurity(securityId);
	}

	public int updateSecurityStatus(TblSecurity tblSecurity)
	{
		return adminMapper.updateSecurityStatus(tblSecurity);
	}

	public int addSecurity(List<TblSecurity> tblSecurityList)
	{
		return adminMapper.addSecurity(tblSecurityList);
	}

	//学生管理
	public List<TblStudent> findAllStudentInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllStudentInfo(condition, rowBounds);
	}

	public int findStudentInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findStudentInfoCount(condition);
	}

	public int restStudentPwd(TblStudent tblStudent)
	{
		return adminMapper.restStudentPwd(tblStudent);
	}

	public int updateStudent(TblStudent tblStudent)
	{
		return adminMapper.updateStudent(tblStudent);
	}

	public int deleteStudent(Integer studentId)
	{
		return adminMapper.deleteStudent(studentId);
	}

	public int updateStudentStatus(TblStudent tblStudent)
	{
		return adminMapper.updateStudentStatus(tblStudent);
	}

	public int addStudent(List<TblStudent> tblStudentList)
	{
		return adminMapper.addStudent(tblStudentList);
	}

	//安全教育管理
	public List<TblSafetyvideo> findAllSafetyVideoInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllSafetyVideoInfo(condition, rowBounds);
	}

	public int findSafetyVideoInfoCount(HashMap<String, Object> condition)
	{
		return adminMapper.findSafetyVideoInfoCount(condition);
	}

	public int deleteSafetyVideoInfo(Integer safetyVideoId)
	{
		return adminMapper.deleteSafetyVideoInfo(safetyVideoId);
	}

	public List<TblSafetyvtq> findAllSafetyVideoItemsInfo(Integer safetyVideoId)
	{
		return adminMapper.findAllSafetyVideoItemsInfo(safetyVideoId);
	}

	public int addSafetyVideo(List<TblSafetyvideo> tblSafetyvideoList)
	{
		return adminMapper.addSafetyVideo(tblSafetyvideoList);
	}

	public int updateSafetyVideo(TblSafetyvideo tblSafetyvideo)
	{
		return adminMapper.updateSafetyVideo(tblSafetyvideo);
	}

	public List<TblSafetyvideo> findAllVideoQuestionConfigInfo(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllVideoQuestionConfigInfo(condition, rowBounds);
	}

	public int addTopic(TblSafetyvtq tblSafetyvtq)
	{
		return adminMapper.addTopic(tblSafetyvtq);
	}

	public List<TblSafetyvtq> queryTopicById(Integer safetyVideoId)
	{
		return adminMapper.queryTopicById(safetyVideoId);
	}

	public int updateTopic(TblSafetyvtq tblSafetyvtq)
	{
		return adminMapper.updateTopic(tblSafetyvtq);
	}

	public int deleteTopic(TblSafetyvtq tblSafetyvtq)
	{
		return adminMapper.deleteTopic(tblSafetyvtq);
	}

	//参数配置
	public List<TblParameter> findAllParameter(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findAllParameter(condition, rowBounds);
	}

	public int findParameterCount(HashMap<String, Object> condition)
	{
		return adminMapper.findParameterCount(condition);
	}

	public List<TblParameter> findParameterInfo()
	{
		return adminMapper.findParameterInfo();
	}

	public List<String> findAllParameterType()
	{
		return adminMapper.findAllParameterType();
	}

	public int addParameter(List<TblParameter> tblParameterList)
	{
		return adminMapper.addParameter(tblParameterList);
	}

	public int updateParameter(TblParameter tblParameter)
	{
		return adminMapper.updateParameter(tblParameter);
	}

	public int deleteParameter(Integer parameterid)
	{
		return adminMapper.deleteParameter(parameterid);
	}

	//幼儿统计
	public List<TblExamination> findChildrenStatisticsInfo()
	{
		return adminMapper.findChildrenStatisticsInfo();
	}

	//男性
	public List<TblStatistics> findChildrenMaleInfo()
	{
		return adminMapper.findChildrenMaleInfo();
	}

	//女性
	public List<TblStatistics> findChildrenFeMaleInfo()
	{
		return adminMapper.findChildrenFeMaleInfo();
	}

	public List<TblStatistics> findChildrenAAgeInfo()
	{
		return adminMapper.findChildrenAAgeInfo();
	}

	public List<TblStatistics> findChildrenBAgeInfo()
	{
		return adminMapper.findChildrenBAgeInfo();
	}

	public List<TblStatistics> findChildrenCAgeInfo()
	{
		return adminMapper.findChildrenCAgeInfo();
	}

	public List<TblStatistics> findChildrenAgeInfo()
	{
		return adminMapper.findChildrenAgeInfo();
	}

	public List<TblStatistics> findChildrenStatusInfo()
	{
		return adminMapper.findChildrenStatusInfo();
	}

	public List<TblStatistics> findTSexInfo()
	{
		return adminMapper.findTSexInfo();
	}

	public List<TblStatistics> findTAgeInfo()
	{
		return adminMapper.findTAgeInfo();
	}

	public List<MenuTreeInfo> findAllMenuInfo()
	{
		return adminMapper.findAllMenuInfo();
	}

	public List<MenuTreeInfo> findMenuByRoleID(Integer rid)
	{
		return adminMapper.findMenuByRoleID(rid);
	}

	public int deleteMenuId(Integer rid)
	{
		return adminMapper.deleteMenuId(rid);
	}

	public int updateMenu(List<Map<String, Integer>> mapList)
	{
		return adminMapper.updateMenu(mapList);
	}

	public List<TblRole> findRoleInfos(HashMap<String, Object> condition, RowBounds rowBounds)
	{
		return adminMapper.findRoleInfos(condition, rowBounds);
	}

	public int findRoleCounts(HashMap<String, Object> condition)
	{
		return adminMapper.findRoleCounts(condition);
	}

	//管理员个人信息修改
	public int updateAdminInfo(TblAdmin tblAdmin)
	{
		return adminMapper.updateAdminInfo(tblAdmin);
	}

	public List<TblReadmag> findReadInfoById(Integer curPage, Integer pageSize, Integer readmagid)
	{
		return adminMapper.findReadInfoById(curPage,pageSize,readmagid);
	}

	public int findReadCountById(Integer readmagid)
	{
		return adminMapper.findReadCountById(readmagid);
	}

	public PageBean<TblReadmag> findReadBookByPage(Integer curPage, Integer pageSize, Integer readmagid)
	{
		Integer totalRerords = adminMapper.findReadCountById(readmagid);

		List<TblReadmag> list = adminMapper.findReadInfoById(curPage,pageSize,readmagid);

		PageBean<TblReadmag> readBookPageBean = new PageBean<TblReadmag>(curPage,totalRerords,pageSize);

		readBookPageBean.setList(list);

		return readBookPageBean;
	}

	public Integer findExistAdminName(String adminname)
	{
		Map<String,String> adminMap = new LinkedHashMap<>();
		adminMap.put("adminname",adminname);
		return adminMapper.findExistAdminName(adminMap);
	}

	public boolean resetAdminPwd(String adminname,String adminphone)
	{
		Map<String,String> adminMap = new LinkedHashMap<>();
		adminMap.put("adminname",adminname);
		adminMap.put("adminphone",adminphone);
		return adminMapper.resetAdminPwd(adminMap);
	}
}
