package com.great.kindergarten.admin.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.great.kindergarten.admin.annotation.AdminSystemLog;
import com.great.kindergarten.admin.javabean.DataResult;
import com.great.kindergarten.admin.service.SystemLogService;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.admin.service.AdminService;
import com.great.kindergarten.util.GsonUtils;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.apache.ibatis.session.RowBounds;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

/**
 * @author LXC
 */

@Controller
@RequestMapping("/admin")
public class AdminController {
    private String admincode;

    @Resource
    private AdminService adminService;

    @Resource
    private SystemLogService systemLogService;

	@RequestMapping("/toUrl/{url}")
	public String matchUrl(@PathVariable("url") String url)
	{
		System.out.println("url=" + url);
		return "/adminjsp/" + url;
	}

    @RequestMapping(value = "/logout")
    public String toLogout(HttpSession session){
        //销毁session
        session.invalidate();
        return "adminjsp/adminLogin";
    }

    @RequestMapping("/loginCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) {
        try {
            int width = 60;
            int height = 30;
            //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
//            String data = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789";
            String data = "0123456789";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
            //随机类
            Random random = new Random();
            //1 创建图片数据缓存区域（核心类）
            // 创建一个彩色的图片
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            //2 获得画板(图片，ps图层)，绘画对象。
            Graphics g = image.getGraphics();
            //3 选择颜色，画矩形3，4步是画一个有内外边框的效果
            g.setColor(Color.BLACK);
            g.fillRect(0, 0, width, height);
            //4白色矩形
            g.setColor(Color.WHITE);
            g.fillRect(1, 1, width - 2, height - 2);
            /**1 提供缓存区域，为了存放4个随机字符，以便存入session */
            StringBuilder builder = new StringBuilder();
            //5 随机生成4个字符
            //设置字体颜色
            g.setFont(new Font("宋体", Font.BOLD & Font.ITALIC, 20));
            for (int i = 0; i < 4; i++) {
                //随机颜色
                g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
                //随机字符
                int index = random.nextInt(data.length());
                String str = data.substring(index, index + 1);
                /**2 缓存*/
                builder.append(str);
                //写入
                g.drawString(str, (width / 6) * (i + 1), 20);
            }
            //给图中绘制噪音点，让图片不那么好辨别
            for (int j = 0, n = random.nextInt(100); j < n; j++) {
                g.setColor(Color.RED);
                //随机噪音点
                g.fillRect(random.nextInt(width), random.nextInt(height), 1, 1);
            }
            /**3 获得随机数据，并保存session*/
            admincode = builder.toString();
            request.getSession().setAttribute("admincode", admincode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //管理员登录校验
//    @AdminSystemLog(operationType = "登录",operationName = "管理员登录")
    @RequestMapping("/checkLogin")
    public void login(TblAdmin tblAdmin, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
    {
        boolean flag = admincode.equalsIgnoreCase(tblAdmin.getCode());
        if(flag)
        {
            String adminstatus = adminService.findAdminStatus(tblAdmin.getAdminname());
            if("启用".equals(adminstatus))
            {
                if(tblAdmin.getAdminname() != null &&!"".equals(tblAdmin.getAdminname().trim())
                        &&tblAdmin.getAdminpwd() != null &&!"".equals(tblAdmin.getAdminpwd().trim()))
                {
                    String adminpwd = MD5Utils.md5(tblAdmin.getAdminpwd());
                    tblAdmin.setAdminpwd(adminpwd);
                    tblAdmin = adminService.adminLogin(tblAdmin);
                    if(tblAdmin != null)
                    {
	                    List<String> teacherList = adminService.findAllJob();
	                    List<String> teacherNewList = new ArrayList<String>();
	                    for (String str : teacherList) {
		                    if (!teacherNewList.contains(str)) {
			                    teacherNewList.add(str);
		                    }
	                    }
	                    List<String> parentList = adminService.findParentJob();
	                    List<String> parentNewList = new ArrayList<String>();
	                    for (String str : parentList) {
		                    if (!parentNewList.contains(str)) {
			                    parentNewList.add(str);
		                    }
	                    }
//	                    List<String> healtherList = adminService.findHealtherJob();
//	                    List<String> healtherNewList = new ArrayList<String>();
//	                    for (String str : healtherList) {
//		                    if (!healtherNewList.contains(str)) {
//			                    healtherNewList.add(str);
//		                    }
//	                    }
	                    req.getSession().setAttribute("teacherNewList",teacherNewList);
	                    req.getSession().setAttribute("teacherNewList",teacherNewList);
//	                    req.getSession().setAttribute("healtherNewList",healtherNewList);
	                    String rolename = adminService.findRoleByRid(tblAdmin.getRid());
                        List<TblAdmin> tblAdminList = adminService.findAdminByName(tblAdmin.getAdminname());
                        req.getSession().setAttribute("tblAdminList",tblAdminList);
                        req.getSession().setAttribute("rolename",rolename);
                        req.getSession().setAttribute("tblAdmin",tblAdmin);
                        req.getSession().setAttribute("adminname",tblAdmin.getAdminname());
                        ResponseUtils.outHtml(res,"success");
                    }else{
	                    ResponseUtils.outHtml(res,"pwderror");
                    }
                }else{
                    ResponseUtils.outHtml(res,"error");
                }
            }else{
                ResponseUtils.outHtml(res,"notman");
            }
        }else{
            ResponseUtils.outHtml(res,"codeerror");
        }
    }

	@RequestMapping("/treeMenu")
	public void treeDemo(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String adminname = (String) request.getSession().getAttribute("adminname");
		List<TblMenu> list = adminService.findMenuByName(adminname);
        List<TblMenu> stairMenuList = adminService.findStairMenu();
		response.setContentType("application/json; charset=utf-8");
		request.getSession().setAttribute("stairMenuList",stairMenuList);
		response.getWriter().write(GsonUtils.getgsonUtils().toStr(list));
		response.getWriter().flush();
		response.getWriter().close();
	}

	//菜单管理
    @RequestMapping("/menuMgrInfo")
    public void menuMgrInfo(String page, String limit, TblMenu tblMenu, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        HashMap<String,Object> condition = new HashMap<>();
        if(null != tblMenu.getmName() && !"".equals(tblMenu.getmName().trim())) {
            condition.put("mName",tblMenu.getmName());
            System.out.println("mName="+tblMenu.getmName());
        }

        if(null != tblMenu.getpName() && !"".equals(tblMenu.getpName().trim())) {
            condition.put("pName",tblMenu.getpName());
            System.out.println("pName="+tblMenu.getpName());
        }

        int num = adminService.findMenuCount(condition);

        RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));

        List<TblMenu> list = new ArrayList<>();
        list = adminService.findAllMenu(condition,rowBounds);

        String supName = null;
        TblMenu menu = null;
        List<TblMenu> tblMenuList = new ArrayList<>();
        for(int i = 0; i < list.size(); i++)
        {
            menu = new TblMenu();
            menu.setMenuid(list.get(i).getMenuid());
            menu.setMenuname(list.get(i).getMenuname());
            menu.setMenuurl(list.get(i).getMenuurl());
            menu.setSort(list.get(i).getSort());
            supName = adminService.findSuperierMenu(list.get(i).getMenuid());
            if(supName == null)
            {
                menu.setSupMenu(null);
            }else{
                menu.setSupMenu(supName);
            }
            tblMenuList.add(menu);
        }

        if(tblMenuList != null)
        {
            Gson gson = new GsonBuilder().serializeNulls().create();
            dataResult.setCode(0);
            dataResult.setCount(num);
            dataResult.setMsg("");
            dataResult.setData(tblMenuList);
            res.setContentType("application/json; charset=utf-8");
            res.getWriter().write(gson.toJson(dataResult));
            res.getWriter().flush();
            res.getWriter().close();
        }
    }

    //新增菜单
    @AdminSystemLog(operationType = "新增菜单",operationName = "管理员新增菜单")
	@RequestMapping("/addMenuItems")
	public void addMenuItems(TblMenu tblMenu,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblMenu);
		if(tblMenu.getpName() != null && !"".equals(tblMenu.getpName().trim()) && !"请选择".equals(tblMenu.getpName()))
		{
			Integer menuId = adminService.findSidByName(tblMenu.getpName());
			tblMenu.setMenusonid(menuId);
		}
		int num = adminService.addMenuInfo(tblMenu);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/checkMenuName")
	public void checkMenuName(TblMenu tblMenu,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblMenu.getMenuname());
		Integer menuId = adminService.checkMenuName(tblMenu.getMenuname());
		System.out.println(menuId);
		if(menuId == null)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@AdminSystemLog(operationType = "修改菜单",operationName = "管理员修改菜单信息")
	@RequestMapping("/updateMenuInfo")
	public void updateMenuInfo(TblMenu tblMenu,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblMenu);
		if(tblMenu.getpName() != null && !"".equals(tblMenu.getpName().trim()) && !"请选择".equals(tblMenu.getpName()))
		{
			Integer menuId = adminService.findSidByName(tblMenu.getpName());
			tblMenu.setMenusonid(menuId);
		}
		int num = adminService.updateMenuInfo(tblMenu);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@AdminSystemLog(operationType = "删除菜单",operationName = "管理员删除菜单信息")
	@RequestMapping("/deleteMenuInfo")
	public void deleteMenuInfo(TblMenu tblMenu,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblMenu);
		Integer menusonid = adminService.findSidByMid(tblMenu.getMenuid());
		if(menusonid != null)
		{
			Integer rolemenuid = adminService.findRoleMenuIdByMid(tblMenu.getMenuid());
			adminService.deleteRoleMenu(rolemenuid);
		}
		if(tblMenu.getpName() != null && !"".equals(tblMenu.getpName().trim()) && !"请选择".equals(tblMenu.getpName()))
		{
			Integer menuId = adminService.findSidByName(tblMenu.getpName());
			System.out.println("子id="+menuId);
			tblMenu.setMenusonid(menuId);
		}

		int num = adminService.deleteMenuInfo(tblMenu.getMenuid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

    @RequestMapping("/checkOldPwd")
    public void checkOldPwd(HttpServletRequest request, HttpServletResponse response)
    {
        String oldadminpwd = MD5Utils.md5(request.getParameter("oldadminpwd"));
        String adminname = (String) request.getSession().getAttribute("adminname");
        TblAdmin tblAdmin = adminService.findTblAdminByName(adminname);
        if(tblAdmin.getAdminpwd().equals(oldadminpwd))
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

    @RequestMapping("/updateAdminpwd")
    @AdminSystemLog(operationType = "修改",operationName = "修改管理员密码")
    public void updateAdminpwd(HttpServletRequest request, HttpServletResponse response)
    {
        String oldadminpwd = MD5Utils.md5(request.getParameter("oldadminpwd"));
        String adminname = (String) request.getSession().getAttribute("adminname");
        TblAdmin tblAdmin = adminService.findTblAdminByName(adminname);
        if(tblAdmin.getAdminpwd().equals(oldadminpwd))
        {
            String adminpwd = MD5Utils.md5(request.getParameter("adminpwd"));
            int num = adminService.updateAdminPwd(adminpwd,tblAdmin.getAdminid().toString());
            if(num > 0)
            {
                ResponseUtils.outHtml(response,"success");
            }else{
                ResponseUtils.outHtml(response,"error");
            }
        }else{
            ResponseUtils.outHtml(response,"pwderror");
        }
    }

    @RequestMapping("/logMgrInfo")
    public void findLogByPage(String page, String limit, TblSyslog tblSysLog, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        HashMap<String,Object> condition = new HashMap<>();

        if(null != tblSysLog.getTime1() && !"".equals(tblSysLog.getTime1().trim())) {
            condition.put("time1",tblSysLog.getTime1());
        }

        if(null != tblSysLog.getTime2() && !"".equals(tblSysLog.getTime2().trim())) {
            condition.put("time2",tblSysLog.getTime2());
        }

        int num = systemLogService.findAllCount(condition);

        RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));

        List<TblSyslog> list = new ArrayList<>();
        list = systemLogService.findAllDoc(condition,rowBounds);
        if(list != null)
        {
            Gson gson = new GsonBuilder().serializeNulls().create();
            dataResult.setCode(0);
            dataResult.setCount(num);
            dataResult.setMsg("");
            dataResult.setData(list);
            res.setContentType("application/json; charset=utf-8");
            res.getWriter().write(gson.toJson(dataResult));
            res.getWriter().flush();
            res.getWriter().close();
        }
    }

    @RequestMapping("/qualifyAppInfo")
    public void findKinderByPage(String page, String limit, TblKinder tblKinder, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        HashMap<String,Object> condition = new HashMap<>();

        if(null != tblKinder.getTime1() && !"".equals(tblKinder.getTime1().trim())) {
            condition.put("time1",tblKinder.getTime1());
        }

        if(null != tblKinder.getTime2() && !"".equals(tblKinder.getTime2().trim())) {
            condition.put("time2",tblKinder.getTime2());
        }

        if(null != tblKinder.getKinderstatus() && !"".equals(tblKinder.getKinderstatus().trim())) {
            condition.put("kinderstatus",tblKinder.getKinderstatus());
        }

	    if(null != tblKinder.getKindercode() && !"".equals(tblKinder.getKindercode().trim())) {
			condition.put("kindercode",tblKinder.getKindercode());
	    }

        if(null != tblKinder.getKindername() && !"".equals(tblKinder.getKindername().trim())) {
            System.out.println("园所="+tblKinder.getKindername());
            condition.put("kindername",tblKinder.getKindername());
        }

        int num = adminService.findAllCount(condition);

        RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));

        List<TblKinder> tblKinderList = new ArrayList<>();
	    tblKinderList = adminService.findAllKinder(condition,rowBounds);
        if(tblKinderList != null)
        {
            List<TblKinder> kinderList = adminService.findKinder();
            Gson gson = new GsonBuilder().serializeNulls().create();
            dataResult.setCode(0);
            dataResult.setCount(num);
            dataResult.setMsg("");
            dataResult.setData(tblKinderList);
            req.getSession().setAttribute("kinderList",kinderList);
            res.setContentType("application/json; charset=utf-8");
            res.getWriter().write(gson.toJson(dataResult));
            res.getWriter().flush();
            res.getWriter().close();
        }
    }

    @RequestMapping("/findTblKinderById")
    public void findTblKinderById(TblKinder tblKinder,HttpServletRequest request,HttpServletResponse response)
    {
    	tblKinder = adminService.findTblKinderById(tblKinder.getKinderid());
    	if(tblKinder != null)
	    {
		    request.getSession().setAttribute("tblKinder",tblKinder);
	    }
    }

    //园所资质申请通过
    @RequestMapping("/checkQualify")
    public void checkQualify(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
    {
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        String kinderstatus = null;
        int kinderid = Integer.valueOf(request.getParameter("kinderid"));
	    if(tblKinder != null)
	    {
		    kinderstatus = "通过";
		    int num = adminService.checkQualify(kinderstatus,kinderid,sf.format(new Date()));
		    if(num > 0)
		    {
			    ResponseUtils.outHtml(response,"success");
		    }else{
			    ResponseUtils.outHtml(response,"error");
		    }
	    }else{
		    ResponseUtils.outHtml(response,"codeerror");
	    }
    }

	//园所资质申请未通过
    @RequestMapping("/reject")
    public void reject(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
    {
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        String kinderstatus = null;
        int kinderid = Integer.valueOf(request.getParameter("kinderid"));
        if(tblKinder != null)
        {
            kinderstatus = "未通过";
            int num = adminService.checkQualify(kinderstatus,kinderid,sf.format(new Date()));
            if(num > 0)
            {
                ResponseUtils.outHtml(response,"success");
            }else{
                ResponseUtils.outHtml(response,"error");
            }
        }else{
            ResponseUtils.outHtml(response,"codeerror");
        }
    }

    //根据园所名称查找园所账号
    @RequestMapping("/kinderAccount")
    public void findAccountByName(HttpServletRequest request, HttpServletResponse response)
	{
		String kindername = request.getParameter("kindername");
		System.out.println(kindername);
		String kinderacount = adminService.findAccountByName(kindername);
		System.out.println(kinderacount);
	    if(kinderacount != null && !"".equals(kinderacount.trim()))
	    {
		    ResponseUtils.outHtml(response,kinderacount);
	    }else{
		    ResponseUtils.outHtml(response,"error");
	    }
    }

    //新增园所
    @RequestMapping("/addKinder")
    public void addKinder(TblKinder tblKinder,HttpServletRequest request, HttpServletResponse response)
    {
        tblKinder.setKinderregtime(new Date());
        tblKinder.setKinderstatus("未审批");
        tblKinder.setKindercode("启用");
        List<TblKinder> tblKinderList = new ArrayList<>();
        tblKinderList.add(tblKinder);
        int num = adminService.addKinder(tblKinderList);
        if(num > 0)
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

    @RequestMapping("/forbiddenAccount")
    public void forbiddenAccount(TblKinder tblKinder,HttpServletRequest request, HttpServletResponse response)
    {
        tblKinder.setKindercode("禁用");
        int num = adminService.updateKinderCode(tblKinder);
        if(num > 0)
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

    @RequestMapping("/openAccount")
    public void openAccount(TblKinder tblKinder,HttpServletRequest request, HttpServletResponse response)
    {
        tblKinder.setKindercode("启用");
        int num = adminService.updateKinderCode(tblKinder);
        if(num > 0)
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

    @RequestMapping("/restKinderPwd")
    public void restKinderPwd(TblKinder tblKinder,HttpServletRequest request, HttpServletResponse response)
    {
        String kinderPwd = adminService.initialPwd("初始密码");
        tblKinder.setKinderpwd(kinderPwd);
        int num = adminService.restKinderPwd(tblKinder);
        if(num > 0)
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

    @RequestMapping("/deleteKinderInfo")
    public void deleteKinderInfo(TblKinder tblKinder,HttpServletRequest request, HttpServletResponse response)
    {
        int num = adminService.deleteKinderInfo(tblKinder);
        if(num > 0)
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

    @RequestMapping("/updateKinderInfo")
    public void updateKinderInfo(TblKinder tblKinder,HttpServletRequest request, HttpServletResponse response)
    {
        int num = adminService.updateKinderInfo(tblKinder);
        if(num > 0)
        {
            ResponseUtils.outHtml(response,"success");
        }else{
            ResponseUtils.outHtml(response,"error");
        }
    }

	@RequestMapping("/roleMgrInfo")
	public void roleDemo(String page, String limit, TblRole tblRole, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblRole.getRolename() && !"".equals(tblRole.getRolename().trim())) {
			condition.put("rolename",tblRole.getRolename());
		}
		int num = adminService.findRoleCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblRole> roleList = adminService.findAllRoleInfo(condition,rowBounds);
		List<TblRole> tblRoleList = adminService.findAllRoleName();
		System.out.println("角色："+GsonUtils.getgsonUtils().toStr(tblRoleList));
		if(roleList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(roleList);
			request.getSession().setAttribute("tblRoleList",tblRoleList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/updateRoleInfo")
	public void updateRoleInfo(TblRole tblRole,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateRoleInfo(tblRole);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteRoleInfo")
	public void deleteRoleInfo(TblRole tblRole,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteRoleInfo(tblRole.getRoleid());
		List<TblRoleMenu> list = adminService.findRoleMenuIdByRid(tblRole.getRoleid());
		System.out.println(GsonUtils.getgsonUtils().toStr(list));
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/checkRoleName")
	public void checkRoleName(TblRole tblRole,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblRole.getRolename());
		Integer roleId = adminService.checkRoleName(tblRole.getRolename());
		System.out.println(roleId);
		if(roleId == null)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//新增角色
	@AdminSystemLog(operationType = "新增角色",operationName = "管理员新增角色")
	@RequestMapping("/addRoleItems")
	public void addRoleItems(TblRole tblRole,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblRole);
		int num = adminService.addRoleInfo(tblRole);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/readMgrInfo")
	public void readMgrInfo(String page, String limit, TblReadmag tblReadmag, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		String readMagName = request.getParameter("readmagname");
		System.out.println(readMagName);
		if(null != readMagName && !"".equals(readMagName.trim())) {
			condition.put("readmagname",readMagName);
		}
		if(null != tblReadmag.getTime1() && !"".equals(tblReadmag.getTime1().trim())) {
			condition.put("time1",tblReadmag.getTime1());
		}

		if(null != tblReadmag.getTime2() && !"".equals(tblReadmag.getTime2().trim())) {
			condition.put("time2",tblReadmag.getTime2());
		}

		int num = adminService.findReadCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblReadmag> readMagList = adminService.findAllReadInfo(condition,rowBounds);
		if(readMagList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(readMagList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/deleteReadInfo")
	public void deleteReadInfo(TblReadmag tblReadmag,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblReadmag);
		int num = adminService.deleteReadInfo(tblReadmag.getReadmagid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/uploadImg")
	public void upload(@RequestParam("file") MultipartFile file, String contentInfo ,String pageNum , String reamagname1, TblReadmag tblReadmag, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		System.out.println("file="+file+"绘本名称"+reamagname1+"内容信息"+contentInfo+"页数"+pageNum);
		String prefix = "";
		String dateStr = "";
		//保存上传
		if(file != null){
			String originalName = file.getOriginalFilename();
			prefix = originalName.substring(originalName.lastIndexOf(".")+1);
			Date date = new Date();
			String uuid = UUID.randomUUID()+"";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateStr = simpleDateFormat.format(date);
//			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\img\\" + dateStr+"\\"+uuid+"." + prefix;
			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\img\\" + "\\"+originalName;
			File files = new File(filepath);
			//打印查看上传路径
			System.out.println(filepath);
			if(!files.getParentFile().exists()){
				files.getParentFile().mkdirs();
			}
			tblReadmag.setReadmagname("三只小羊");
			tblReadmag.setReadmagurl("E:\\kindergarten\\亲子阅读");
			tblReadmag.setReadmagdetail(contentInfo);
			tblReadmag.setPhotourl("image/adminimg/img/"+originalName);
			tblReadmag.setReadmagpage(Integer.valueOf(pageNum));
			tblReadmag.setReadmagtime(date);
			int num = adminService.addPhotoImg(tblReadmag);
			if(num > 0)
			{
				file.transferTo(files);
				response.getWriter().write("{\"code\":0, \"msg\":\"\", \"data\":{}}");
				response.getWriter().flush();
				response.getWriter().close();
			}

		}else{
			response.getWriter().write("{\"code\":1, \"msg\":\"\", \"data\":{}}");
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/reUploadBook")
	public void reUploadBook(TblReadmag tblReadmag, HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException
	{
		System.out.println("重新"+tblReadmag);
		tblReadmag.setReadmagtime(new Date());
		int num = adminService.reUploadBook(tblReadmag);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}
	@RequestMapping("/findRoleInfo")
	public void findRoleInfo(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		List<TblRole> tblRoleList = adminService.findRoleInfo();
		System.out.println("角色"+tblRoleList);
//		Map map = null;
//		for(int i = 0; i < tblRoleList.size() ; i++)
//		{
//			map = new LinkedHashMap();
//			map.put("roleid",tblRoleList.get(i).getRoleid());
//			map.put("title",tblRoleList.get(i).getRolename());
//		}

		List<HashMap<String, Object>> result = new ArrayList<>();
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(GsonUtils.getgsonUtils().toStr(fun(tblRoleList,result)));
		response.getWriter().flush();
		response.getWriter().close();
//		if(map != null)
//		{
//			ResponseUtils.outJson(response,GsonUtils.getgsonUtils().toStr(map));
//		}else{
//			ResponseUtils.outHtml(response,"error");
//		}
	}

	private Object fun(List<TblRole> list, List<HashMap<String, Object>> result) {
		for(TblRole tblRole : list){
			HashMap<String, Object> map = new HashMap<>();
			//id，title，spread等的命名是layui需要的，所以需要把获取到的list重新遍历一遍并命名成layui需要的字段名称
			map.put("id", tblRole.getRoleid());
//			if("管理员".equals(tblRole.getRolename()))
//			{
				map.put("title", tblRole.getRolename());
//			}
			//设置是否展开
			map.put("spread", false);
			result.add(map);
		}
		System.out.println(result);
		return result;
	}

	@RequestMapping("/findMenuByRoleName")
	public void findMenuByRoleName(TblRole tblRole, Integer data, HttpServletResponse response, HttpServletRequest request) throws IOException
	{
		System.out.println("前台信息"+data);
		List<TblMenu> list = adminService.findMenuByRid(data);

		for(TblMenu tblMenu : list){
			//根据一级菜单获取二级菜单，并把它加入到list
			tblMenu.setChildrenList(adminService.findMenuBySid(tblMenu.getMenuid()));
		}

		//定义一个map处理json键名问题
		List<HashMap<String, Object>> result = new ArrayList<>();
		response.setContentType("application/json; charset=utf-8");
//		response.getWriter().write(GsonUtils.getgsonUtils().toStr(list));
		response.getWriter().write(GsonUtils.getgsonUtils().toStr(fun2(list,result)));
		response.getWriter().flush();
		response.getWriter().close();

	}

//	private List<TblMenu> getChildNodes(Integer id, List<TblMenu> parentMenuList) throws Exception {
//		// 子节点
//		List<TblMenu> childList = new ArrayList<>();
//		// 把sid=mid的子节点放到对应mid的父节点上
//		for (TblMenu tblMenu : parentMenuList) {
//			if (tblMenu.getMenusonid() != 0) {
//				if (tblMenu.getMenusonid() == id) {
//					childList.add(tblMenu);
//				}
//			}
//		}
//		if (childList.size() == 0) {
//			return null;
//		}
//		// Look up it's child node and fill
//		for (TblMenu tblMenu : childList) {
//			tblMenu.setChildrenList(getChildNodes(tblMenu.getMenuid(), parentMenuList));
//		}
//		return childList;
//	}

	private Object fun2(List<TblMenu> list, List<HashMap<String, Object>> result) {
		for(TblMenu d : list){
			HashMap<String, Object> map = new HashMap<>();
			//id，title，spread等的命名是layui需要的，所以需要把获取到的list重新遍历一遍并命名成layui需要的字段名称
			map.put("id", d.getMenuid());
			map.put("title", d.getMenuname());
//			map.put("url",d.getMurl());
			//设置是否展开
			map.put("spread", true);
			List<HashMap<String, Object>> result1 = new ArrayList<>();
			if(d.getChildrenList() != null){
				//下级菜单
				List<TblMenu> children = d.getChildrenList();
				//这里可以根据自己需求判断节点默认选中
				//				if(d.getPmid() != null || d.getChildNodes().size() == 0){
				//					map.put("checked", true);    //设置为选中状态
				//				}
				map.put("children", fun2(children, result1));
			}
			result.add(map);
		}
		System.out.println("大小"+list.size());
		System.out.println("111"+result);
		return result;
	}

	@RequestMapping("/platformInfoMag")
	public void platformInfoMag(String page, String limit, TblPlatforminfo tblPlatforminfo, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblPlatforminfo.getPlatforminfoname() && !"".equals(tblPlatforminfo.getPlatforminfoname().trim())) {
			condition.put("platforminfoname",tblPlatforminfo.getPlatforminfoname());
		}
		if(null != tblPlatforminfo.getTime1() && !"".equals(tblPlatforminfo.getTime1().trim())) {
			condition.put("time1",tblPlatforminfo.getTime1());
		}

		if(null != tblPlatforminfo.getTime2() && !"".equals(tblPlatforminfo.getTime2().trim())) {
			condition.put("time2",tblPlatforminfo.getTime2());
		}

		int num = adminService.findPlatFormInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblPlatforminfo> readMagList = adminService.findAllPlatFormInfo(condition,rowBounds);
		if(readMagList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(readMagList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/releasePlatFormInfo")
	public void releasePlatFormInfo(TblPlatforminfo tblPlatforminfo,HttpServletRequest request, HttpServletResponse response)
	{
		tblPlatforminfo.setPlatforminfostatus("已发布");
		int num = adminService.releasePlatFormInfo(tblPlatforminfo);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/cancelPlatFormInfo")
	public void cancelPlatFormInfo(TblPlatforminfo tblPlatforminfo,HttpServletRequest request, HttpServletResponse response)
	{
		tblPlatforminfo.setPlatforminfostatus("未发布");
		int num = adminService.cancelPlatFormInfo(tblPlatforminfo);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deletePlatFormInfo")
	public void deletePlatFormInfo(TblPlatforminfo tblPlatforminfo,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblPlatforminfo);
		int num = adminService.deletePlatFormInfo(tblPlatforminfo.getPlatforminfoid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updatePlatFormInfo")
	public void updatePlatFormInfo(TblPlatforminfo tblPlatforminfo,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblPlatforminfo);
		int num = adminService.updatePlatFormInfo(tblPlatforminfo);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/addPlatFormInfo")
	public void addPlatFormInfo(TblPlatforminfo tblPlatforminfo,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblPlatforminfo);
		tblPlatforminfo.setPlatforminfotime(new Date());
		tblPlatforminfo.setPlatforminfostatus("未发布");
		int num = adminService.addPlatFormInfo(tblPlatforminfo);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//园长管理
	@RequestMapping("/rectorMgrInfo")
	public void rectorMgrInfo(String page, String limit, TblRector tblRector, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblRector.getRectorname() && !"".equals(tblRector.getRectorname().trim())) {
			condition.put("rectorname",tblRector.getRectorname());
		}

		if(null != tblRector.getRectorstatus() && !"".equals(tblRector.getRectorstatus().trim())) {
			condition.put("rectorstatus",tblRector.getRectorstatus());
		}

		if(null != tblRector.getTime1() && !"".equals(tblRector.getTime1().trim())) {
			condition.put("time1",tblRector.getTime1());
		}

		if(null != tblRector.getTime2() && !"".equals(tblRector.getTime2().trim())) {
			condition.put("time2",tblRector.getTime2());
		}

		int num = adminService.findRectorInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblRector> tblRectorList = adminService.findAllRectorInfo(condition,rowBounds);
		if(tblRectorList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblRectorList );
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/addRector")
	public void addRector(TblRector tblRector,HttpServletRequest request, HttpServletResponse response)
	{
		tblRector.setRectorregtime(new Date());
		tblRector.setRectorstatus("启用");
		List<TblRector> tblRectorList = new ArrayList<>();
		tblRectorList.add(tblRector);
		int num = adminService.addRector(tblRectorList);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/forbiddenRector")
	public void forbiddenRector(TblRector tblRector,HttpServletRequest request, HttpServletResponse response)
	{
		tblRector.setRectorstatus("禁用");
		int num = adminService.updateRectorStatus(tblRector);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/openRector")
	public void openRector(TblRector tblRector,HttpServletRequest request, HttpServletResponse response)
	{
		tblRector.setRectorstatus("启用");
		int num = adminService.updateRectorStatus(tblRector);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/restRectorPwd")
	public void restRectorPwd(TblRector tblRector,HttpServletRequest request, HttpServletResponse response)
	{
		String rectorPwd = adminService.initialPwd("初始密码");
		tblRector.setRectorpwd(rectorPwd);
		int num = adminService.restRectorPwd(tblRector);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteRector")
	public void deleteRector(TblRector tblRector,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteRector(tblRector.getRectorid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updateRector")
	public void updateRector(TblRector tblRector,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateRector(tblRector);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//教师管理
	@RequestMapping("/teacherMgrInfo")
	public void teacherMgrInfo(String page, String limit, TblTeacher tblTeacher, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblTeacher.getTeachername() && !"".equals(tblTeacher.getTeachername().trim())) {
			condition.put("teachername",tblTeacher.getTeachername());
		}

		if(null != tblTeacher.getTeacherstatus() && !"".equals(tblTeacher.getTeacherstatus().trim())) {
			condition.put("teacherstatus",tblTeacher.getTeacherstatus());
		}

		if(null != tblTeacher.getTeacherjob() && !"".equals(tblTeacher.getTeacherjob().trim())) {
			condition.put("teacherjob",tblTeacher.getTeacherjob());
		}

		if(null != tblTeacher.getTime1() && !"".equals(tblTeacher.getTime1().trim())) {
			condition.put("time1",tblTeacher.getTime1());
		}

		if(null != tblTeacher.getTime2() && !"".equals(tblTeacher.getTime2().trim())) {
			condition.put("time2",tblTeacher.getTime2());
		}

		int num = adminService.findTeacherInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblTeacher> tblTeacherList = adminService.findAllTeacherInfo(condition,rowBounds);
		if(tblTeacherList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblTeacherList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/addTeacher")
	public void addTeacher(TblTeacher tblTeacher,HttpServletRequest request, HttpServletResponse response)
	{
		tblTeacher.setTeacherregtime(new Date());
		tblTeacher.setTeacherstatus("启用");
		List<TblTeacher> tblTeacherList = new ArrayList<>();
		tblTeacherList.add(tblTeacher);
		int num = adminService.addTeacher(tblTeacherList);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/forbiddenTeacher")
	public void forbiddenTeacher(TblTeacher tblTeacher,HttpServletRequest request, HttpServletResponse response)
	{
		tblTeacher.setTeacherstatus("禁用");
		int num = adminService.updateTeacherStatus(tblTeacher);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/openTeacher")
	public void openTeacher(TblTeacher tblTeacher,HttpServletRequest request, HttpServletResponse response)
	{
		tblTeacher.setTeacherstatus("启用");
		int num = adminService.updateTeacherStatus(tblTeacher);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/restTeacherPwd")
	public void restTeacherPwd(TblTeacher tblTeacher,HttpServletRequest request, HttpServletResponse response)
	{
		String teacherPwd = adminService.initialPwd("初始密码");
		tblTeacher.setTeacherpwd(teacherPwd);
		int num = adminService.restTeacherPwd(tblTeacher);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteTeacher")
	public void deleteTeacher(TblTeacher tblTeacher,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteTeacher(tblTeacher.getTeacherid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updateTeacher")
	public void updateTeacher(TblTeacher tblTeacher,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateTeacher(tblTeacher);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//家长管理
	@RequestMapping("/parentMgrInfo")
	public void parentMgrInfo(String page, String limit, TblParent tblParent, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblParent.getParentName() && !"".equals(tblParent.getParentName().trim())) {
			condition.put("parentName",tblParent.getParentName());
		}

		if(null != tblParent.getParentStatus() && !"".equals(tblParent.getParentStatus().trim())) {
			condition.put("parentStatus",tblParent.getParentStatus());
		}

		if(null != tblParent.getParentJob() && !"".equals(tblParent.getParentJob().trim())) {
			condition.put("parentJob",tblParent.getParentJob());
		}

		if(null != tblParent.getTime1() && !"".equals(tblParent.getTime1().trim())) {
			condition.put("time1",tblParent.getTime1());
		}

		if(null != tblParent.getTime2() && !"".equals(tblParent.getTime2().trim())) {
			condition.put("time2",tblParent.getTime2());
		}

		int num = adminService.findParentInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblParent> tblParentList = adminService.findAllParentInfo(condition,rowBounds);
		if(tblParentList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblParentList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/addParent")
	public void addParent(TblParent tblParent,HttpServletRequest request, HttpServletResponse response)
	{
		tblParent.setParentRegTime(new Date());
		tblParent.setParentStatus("启用");
		List<TblParent> tblParentList = new ArrayList<>();
		tblParentList.add(tblParent);
		int num = adminService.addParent(tblParentList);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/forbiddenParent")
	public void forbiddenParent(TblParent tblParent,HttpServletRequest request, HttpServletResponse response)
	{
		tblParent.setParentStatus("禁用");
		int num = adminService.updateParentStatus(tblParent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/openParent")
	public void openParent(TblParent tblParent,HttpServletRequest request, HttpServletResponse response)
	{
		tblParent.setParentStatus("启用");
		int num = adminService.updateParentStatus(tblParent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/restParentPwd")
	public void restParentPwd(TblParent tblParent,HttpServletRequest request, HttpServletResponse response)
	{
		String parentPwd = adminService.initialPwd("初始密码");
		tblParent.setParentPwd(parentPwd);
		int num = adminService.restParentPwd(tblParent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteParent")
	public void deleteParent(TblParent tblParent,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteParent(tblParent.getParentId());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updateParent")
	public void updateParent(TblParent tblParent,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateParent(tblParent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//保健员管理
	@RequestMapping("/healtherMgrInfo")
	public void healtherMgrInfo(String page, String limit, TblHealther tblHealther, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblHealther.getHealthername() && !"".equals(tblHealther.getHealthername().trim())) {
			condition.put("healthername",tblHealther.getHealthername());
		}

		if(null != tblHealther.getHealtherstatus() && !"".equals(tblHealther.getHealtherstatus().trim())) {
			condition.put("healtherstatus",tblHealther.getHealtherstatus());
		}

//		if(null != tblHealther.getHealtherjob() && !"".equals(tblHealther.getHealtherjob().trim())) {
//			condition.put("Healtherjob",tblHealther.getHealtherjob());
//		}

		if(null != tblHealther.getTime1() && !"".equals(tblHealther.getTime1().trim())) {
			condition.put("time1",tblHealther.getTime1());
		}

		if(null != tblHealther.getTime2() && !"".equals(tblHealther.getTime2().trim())) {
			condition.put("time2",tblHealther.getTime2());
		}

		int num = adminService.findHealtherInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblHealther> tblHealtherList = adminService.findAllHealtherInfo(condition,rowBounds);
		if(tblHealtherList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblHealtherList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/addHealther")
	public void addHealther(TblHealther tblHealther,HttpServletRequest request, HttpServletResponse response)
	{
		tblHealther.setHealtherregtime(new Date());
		tblHealther.setHealtherstatus("启用");
		List<TblHealther> tblHealtherList = new ArrayList<>();
		tblHealtherList.add(tblHealther);
		int num = adminService.addHealther(tblHealtherList);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/forbiddenHealther")
	public void forbiddenHealther(TblHealther tblHealther,HttpServletRequest request, HttpServletResponse response)
	{
		tblHealther.setHealtherstatus("禁用");
		int num = adminService.updateHealtherStatus(tblHealther);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/openHealther")
	public void openHealther(TblHealther tblHealther,HttpServletRequest request, HttpServletResponse response)
	{
		tblHealther.setHealtherstatus("启用");
		int num = adminService.updateHealtherStatus(tblHealther);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/restHealtherPwd")
	public void restHealtherPwd(TblHealther tblHealther,HttpServletRequest request, HttpServletResponse response)
	{
		String healtherPwd = adminService.initialPwd("初始密码");
		tblHealther.setHealtherpwd(healtherPwd);
		int num = adminService.restHealtherPwd(tblHealther);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteHealther")
	public void deleteHealther(TblHealther tblHealther,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteHealther(tblHealther.getHealtherid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updateHealther")
	public void updateHealther(TblHealther tblHealther,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateHealther(tblHealther);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//安防员管理
	@RequestMapping("/securityMgrInfo")
	public void securityMgrInfo(String page, String limit, TblSecurity tblSecurity, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblSecurity.getSecurityname() && !"".equals(tblSecurity.getSecurityname().trim())) {
			condition.put("securityname",tblSecurity.getSecurityname());
		}

		if(null != tblSecurity.getSecuritystatus() && !"".equals(tblSecurity.getSecuritystatus().trim())) {
			condition.put("securitystatus",tblSecurity.getSecuritystatus());
		}

		//		if(null != tblHealther.getHealtherjob() && !"".equals(tblHealther.getHealtherjob().trim())) {
		//			condition.put("Healtherjob",tblHealther.getHealtherjob());
		//		}

		if(null != tblSecurity.getTime1() && !"".equals(tblSecurity.getTime1().trim())) {
			condition.put("time1",tblSecurity.getTime1());
		}

		if(null != tblSecurity.getTime2() && !"".equals(tblSecurity.getTime2().trim())) {
			condition.put("time2",tblSecurity.getTime2());
		}

		int num = adminService.findSecurityInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblSecurity> tblSecurityList = adminService.findAllSecurityInfo(condition,rowBounds);
		if(tblSecurityList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblSecurityList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/addSecurity")
	public void addSecurity(TblSecurity tblSecurity,HttpServletRequest request, HttpServletResponse response)
	{
		SimpleDateFormat sf = new SimpleDateFormat();
		tblSecurity.setSecurityregtime(sf.format(new Date()));
		tblSecurity.setSecuritystatus("启用");
		List<TblSecurity> tblSecurityList = new ArrayList<>();
		tblSecurityList.add(tblSecurity);
		int num = adminService.addSecurity(tblSecurityList);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/forbiddenSecurity")
	public void forbiddenSecurity(TblSecurity tblSecurity,HttpServletRequest request, HttpServletResponse response)
	{
		tblSecurity.setSecuritystatus("禁用");
		int num = adminService.updateSecurityStatus(tblSecurity);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/openSecurity")
	public void openSecurity(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response)
	{
		tblSecurity.setSecuritystatus("启用");
		int num = adminService.updateSecurityStatus(tblSecurity);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/restSecurityPwd")
	public void restSecurityPwd(TblSecurity tblSecurity,HttpServletRequest request, HttpServletResponse response)
	{
		String securityPwd = adminService.initialPwd("初始密码");
		tblSecurity.setSecuritypwd(securityPwd);
		int num = adminService.restSecurityPwd(tblSecurity);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteSecurity")
	public void deleteSecurity(TblSecurity tblSecurity,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteSecurity(tblSecurity.getSecurityid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updateSecurity")
	public void updateSecurity(TblSecurity tblSecurity,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateSecurity(tblSecurity);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//学生管理
	@RequestMapping("/studentMgrInfo")
	public void studentMgrInfo(String page, String limit, TblStudent tblStudent, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblStudent.getStudentname() && !"".equals(tblStudent.getStudentname().trim())) {
			condition.put("studentname",tblStudent.getStudentname());
		}

		if(null != tblStudent.getStudentstatus() && !"".equals(tblStudent.getStudentstatus().trim())) {
			condition.put("studentstatus",tblStudent.getStudentstatus());
		}

		//		if(null != tblHealther.getHealtherjob() && !"".equals(tblHealther.getHealtherjob().trim())) {
		//			condition.put("Healtherjob",tblHealther.getHealtherjob());
		//		}

		if(null != tblStudent.getTime1() && !"".equals(tblStudent.getTime1().trim())) {
			condition.put("time1",tblStudent.getTime1());
		}

		if(null != tblStudent.getTime2() && !"".equals(tblStudent.getTime2().trim())) {
			condition.put("time2",tblStudent.getTime2());
		}

		int num = adminService.findStudentInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblStudent> tblStudentList = adminService.findAllStudentInfo(condition,rowBounds);
		if(tblStudentList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblStudentList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/addStudent")
	public void addStudent(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		SimpleDateFormat sf = new SimpleDateFormat();
		tblStudent.setStudenttime(new Date());
		tblStudent.setStudentstatus("启用");
		List<TblStudent> tblStudentList = new ArrayList<>();
		tblStudentList.add(tblStudent);
		int num = adminService.addStudent(tblStudentList);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/forbiddenStudent")
	public void forbiddenStudent(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		tblStudent.setStudentstatus("禁用");
		int num = adminService.updateStudentStatus(tblStudent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/openStudent")
	public void openStudent(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		tblStudent.setStudentstatus("启用");
		int num = adminService.updateStudentStatus(tblStudent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/restStudentPwd")
	public void restStudentPwd(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		String studentPwd = adminService.initialPwd("初始密码");
		tblStudent.setStudentpwd(studentPwd);
		int num = adminService.restStudentPwd(tblStudent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/deleteStudent")
	public void deleteStudent(TblStudent tblStudent,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteStudent(tblStudent.getStudentid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/updateStudent")
	public void updateStudent(TblStudent tblStudent,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.updateStudent(tblStudent);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	//安全教育管理
	@RequestMapping("/safetyEducationInfo")
	public void safetyEducationInfo(String page, String limit, TblSafetyvideo tblSafetyvideo, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String,Object> condition = new HashMap<>();
		if(null != tblSafetyvideo.getSafetyvideoname() && !"".equals(tblSafetyvideo.getSafetyvideoname().trim())) {
			condition.put("safetyvideoname",tblSafetyvideo.getSafetyvideoname());
		}

//		if(null != tblSafetyvideo.getStudentstatus() && !"".equals(tblStudent.getStudentstatus().trim())) {
//			condition.put("studentstatus",tblStudent.getStudentstatus());
//		}

		//		if(null != tblHealther.getHealtherjob() && !"".equals(tblHealther.getHealtherjob().trim())) {
		//			condition.put("Healtherjob",tblHealther.getHealtherjob());
		//		}

		if(null != tblSafetyvideo.getTime1() && !"".equals(tblSafetyvideo.getTime1().trim())) {
			condition.put("time1",tblSafetyvideo.getTime1());
		}

		if(null != tblSafetyvideo.getTime2() && !"".equals(tblSafetyvideo.getTime2().trim())) {
			condition.put("time2",tblSafetyvideo.getTime2());
		}

		int num = adminService.findSafetyVideoInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page)-1)*Integer.valueOf(limit),Integer.valueOf(limit));
		List<TblSafetyvideo> tblSafetyVideoList = adminService.findAllSafetyVideoInfo(condition,rowBounds);
		if(tblSafetyVideoList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblSafetyVideoList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/deleteSafetyVideoInfo")
	public void deleteSafetyVideoInfo(TblSafetyvideo tblSafetyvideo,HttpServletRequest request, HttpServletResponse response)
	{
		int num = adminService.deleteSafetyVideoInfo(tblSafetyvideo.getSafetyvideoid());
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}
}
