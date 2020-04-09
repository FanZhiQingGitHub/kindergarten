package com.great.kindergarten.admin.service;

import com.great.kindergarten.commons.entity.TblAdmin;
import com.great.kindergarten.commons.entity.TblKinder;
import com.great.kindergarten.commons.entity.TblMenu;
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

    public String findRoleByRid(Integer rid)
    {
        return adminMapper.findRoleByRid(rid);
    }
    public TblAdmin findTblAdminByName(String name)
    {
        return adminMapper.findTblAdminByName(name);
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
}
