package com.great.kindergarten.admin.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.admin.mapper.AdminMapper;
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

    public List<TblAdmin> findAdminByName(String name)
    {
        return adminMapper.findAdminByName(name);
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

	public List<TblRole> findAllRoleName()
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
}
