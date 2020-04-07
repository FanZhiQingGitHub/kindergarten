package com.great.kindergarten.admin.service;

import com.great.kindergarten.admin.javabean.TblAdmin;
import com.great.kindergarten.admin.javabean.TblMenu;
import com.great.kindergarten.admin.mapper.AdminMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

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
}
