package com.great.kindergarten.admin.mapper;

import com.great.kindergarten.commons.entity.*;
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
public interface AdminMapper {

	/**
	 * @param adminname
	 * @return
	 */
	public String findAdminStatus(@Param(value="adminname")String adminname);

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

	//角色管理
	public List<TblRole> findAllRoleInfo(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findRoleCount(HashMap<String, Object> condition);

	public List<TblRole> findAllRoleName();

	public int updateRoleInfo(TblRole tblRole);

	public int deleteRoleInfo(Integer roleid);

	public List<TblRoleMenu> findRoleMenuIdByRid(Integer roleid);

	//修改管理员密码
	public int updateAdminPwd(Map<String,String> adminMap);

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

	public List<TblParameter> findAllParameter(HashMap<String, Object> condition, RowBounds rowBounds);

	public int findParameterCount(HashMap<String, Object> condition);

	public List<TblParameter> findParameterInfo();
}
