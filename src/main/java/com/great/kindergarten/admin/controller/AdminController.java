package com.great.kindergarten.admin.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.great.kindergarten.admin.annotation.AdminSystemLog;
import com.great.kindergarten.admin.javabean.DataResult;
import com.great.kindergarten.admin.javabean.MenuTreeInfo;
import com.great.kindergarten.admin.javabean.RectorKinderBean;
import com.great.kindergarten.admin.javabean.TblStatistics;
import com.great.kindergarten.admin.service.AdminService;
import com.great.kindergarten.admin.service.SystemLogService;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.util.GsonUtils;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.*;

/**
 * @author LXC
 */

@Controller
@RequestMapping("/admin")
public class AdminController
{
	private String admincode;

	@Resource
	private AdminService adminService;

	@Resource
	private SystemLogService systemLogService;

	@RequestMapping("/toUrl/{url}")
	public String matchUrl(@PathVariable("url") String url)
	{
		return "/adminjsp/" + url;
	}


	@RequestMapping("/loginCode")
	public void checkCode(HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			int width = 60;
			int height = 30;
			//随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
            String data = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789";
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
			for (int i = 0; i < 4; i++)
			{
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
			for (int j = 0, n = random.nextInt(100); j < n; j++)
			{
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
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	@RequestMapping("/selectresetAdminPwd")
	public void selectresetAdminPwd(String adminame, HttpServletRequest request , HttpServletResponse response)
	{
		Integer num =adminService.findExistAdminName(adminame);
		if(num > 0)
		{
			ResponseUtils.outHtml(response,"success");
		}else{
			ResponseUtils.outHtml(response,"notmen");
		}
	}


	/**
	 * 重置密码
	 * @param tblAdmin
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "修改",operationName = "重置管理员账号密码")
	@RequestMapping("/resetAdminPwd")
	public void resetAdminPwd(TblAdmin tblAdmin, HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("adminname",tblAdmin.getAdminname());
		Boolean flag = adminService.resetAdminPwd(tblAdmin.getAdminname(),tblAdmin.getAdminphone());
		if(flag){
			request.getSession().removeAttribute("adminname");//重置成功后清除掉
			ResponseUtils.outHtml(response,"success");
		}else {
			ResponseUtils.outHtml(response,"error");
		}
	}

	/**
	 * 管理员登录校验
	 * @param tblAdmin
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
    @AdminSystemLog(operationType = "登录",operationName = "管理员登录")
	@RequestMapping("/checkLogin")
	public void login(TblAdmin tblAdmin, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		boolean flag = admincode.equalsIgnoreCase(tblAdmin.getCode());
		if (flag)
		{
			String adminstatus = adminService.findAdminStatus(tblAdmin.getAdminname());
			if ("启用".equals(adminstatus))
			{
				if (tblAdmin.getAdminname() != null && !"".equals(tblAdmin.getAdminname().trim()) && tblAdmin.getAdminpwd() != null && !"".equals(tblAdmin.getAdminpwd().trim()))
				{
					String adminpwd = MD5Utils.md5(tblAdmin.getAdminpwd());
					tblAdmin.setAdminpwd(adminpwd);
					tblAdmin = adminService.adminLogin(tblAdmin);
					if (tblAdmin != null)
					{
						HashMap<String, List<TblMenu>> menuMap = adminService.findMenus(tblAdmin.getAdminname());

						List<String> teacherNewList = adminService.findAllJob();

						List<String> parentNewList = adminService.findParentJob();

						List<String> parameterNewList = adminService.findAllParameterType();

						List<String> roleNewList = adminService.findAllRoleName();

						List<String> readNewList = adminService.findAllReadBookName();

						List<TblKinder> kinderList = adminService.findKinder();

						List<String> tblClassList = adminService.findAllClassName();

						List<TblMenu> stairMenuList = adminService.findStairMenu();

						List<TblRole> roleList = adminService.findRoleInfo();

						req.getSession().setAttribute("kinderList", kinderList);
						req.getSession().setAttribute("tblClassList", tblClassList);
						req.getSession().setAttribute("roleList", roleList);
						req.getSession().setAttribute("stairMenuList", stairMenuList);
						req.getSession().setAttribute("parentNewList", parentNewList);
						req.getSession().setAttribute("menuMap", menuMap);
						req.getSession().setAttribute("roleNewList", roleNewList);
						req.getSession().setAttribute("parameterNewList", parameterNewList);
						req.getSession().setAttribute("teacherNewList", teacherNewList);
						req.getSession().setAttribute("teacherNewList", teacherNewList);
						req.getSession().setAttribute("readNewList", readNewList);

						String rolename = adminService.findRoleByRid(tblAdmin.getRid());
						req.getSession().setAttribute("rolename", rolename);
						req.getSession().setAttribute("tblAdmin", tblAdmin);
						req.getSession().setAttribute("adminname", tblAdmin.getAdminname());
						ResponseUtils.outHtml(res, "success");
					} else
					{
						ResponseUtils.outHtml(res, "pwderror");
					}
				} else
				{
					ResponseUtils.outHtml(res, "error");
				}
			} else
			{
				ResponseUtils.outHtml(res, "notman");
			}
		} else
		{
			ResponseUtils.outHtml(res, "codeerror");
		}
	}

	/**
	 * 查找当前在线用户信息
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/selectAdminInfo")
	public void selectAdminInfo(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String adminname = (String) request.getSession().getAttribute("adminname");
		List<TblAdmin> tblAdminList = adminService.findAdminByName(adminname);
		if (tblAdminList != null)
		{
			ResponseUtils.outJson(response, GsonUtils.getgsonUtils().toStr(tblAdminList));
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}


	/**
	 * 管理员账号管理
	 * @param page
	 * @param limit
	 * @param tblAdmin
	 * @param dataResult
	 * @param req
	 * @param res
	 * @throws IOException
	 */
	@RequestMapping("/adminMgrInfo")
	public void adminMgrInfo(String page, String limit, TblAdmin tblAdmin, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblAdmin.getAdminname() && !"".equals(tblAdmin.getAdminname().trim()))
		{
			condition.put("adminname", tblAdmin.getAdminname());
		}

		if (null != tblAdmin.getRolename() && !"".equals(tblAdmin.getRolename().trim()))
		{
			condition.put("rolename", tblAdmin.getRolename());
		}

		if (null != tblAdmin.getAdminstatus() && !"".equals(tblAdmin.getAdminstatus().trim()))
		{
			condition.put("adminstatus", tblAdmin.getAdminstatus());
		}

		if (null != tblAdmin.getTime1() && !"".equals(tblAdmin.getTime1().trim()))
		{
			condition.put("time1", tblAdmin.getTime1());
		}

		if (null != tblAdmin.getTime2() && !"".equals(tblAdmin.getTime2().trim()))
		{
			condition.put("time2", tblAdmin.getTime2());
		}

		int num = adminService.findAdminCount(condition);

		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));

		List<TblAdmin> tblMenuList = adminService.findAllAdmin(condition, rowBounds);

		if (tblMenuList != null)
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

	/**
	 * 新增管理员
	 * @param tblAdmin
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@AdminSystemLog(operationType = "新增",operationName = "新增管理员")
	@RequestMapping("/addAdminInfos")
	public void addAdminInfos(TblAdmin tblAdmin, HttpServletRequest request, String rolename , HttpServletResponse response) throws Exception
	{
		if (tblAdmin != null)
		{
			if(rolename != null)
			{
				tblAdmin.setRid(adminService.findIdByRoleName(rolename));
			}
			tblAdmin.setAdminstatus("启用");
			tblAdmin.setCreatetime(new Date());
			tblAdmin.setAdminheadurl("image/adminimg/img/head.jpg");
			if(tblAdmin.getAdminpwd() != null)
			{
				tblAdmin.setAdminpwd(MD5Utils.md5(tblAdmin.getAdminpwd()));
			}
			int num = adminService.addAdminInfos(tblAdmin);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "修改",operationName = "修改管理员信息")
	@RequestMapping("/updateAdminInfos")
	public void updateAdminInfos(TblAdmin tblAdmin, HttpServletRequest request, String rolename , HttpServletResponse response) throws Exception
	{
		if (tblAdmin != null)
		{
			if(rolename != null)
			{
				tblAdmin.setRid(adminService.findIdByRoleName(rolename));
			}
			if(tblAdmin.getAdminpwd() != null)
			{
				tblAdmin.setAdminpwd(MD5Utils.md5(tblAdmin.getAdminpwd()));
			}

			int num = adminService.updateAdminInfos(tblAdmin);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "删除",operationName = "删除管理员信息")
	@RequestMapping("/deleteAdmin")
	public void deleteAdmin(TblAdmin tblAdmin, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblAdmin != null)
		{
			int num = adminService.deleteAdmin(tblAdmin.getAdminid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 校验用户名
	 * @param tblAdmin
	 * @param request
	 * @param response
	 */
	@RequestMapping("/checkAdminName")
	public void checkAdminName(TblAdmin tblAdmin, HttpServletRequest request, HttpServletResponse response)
	{
		List<TblAdmin> tblAdminList = adminService.checkAdminName(tblAdmin.getAdminname());
		if (tblAdminList.isEmpty())
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	@AdminSystemLog(operationType = "修改",operationName = "禁用管理员账号")
	@RequestMapping("/forbiddenAdmin")
	public void forbiddenAdmin(TblAdmin tblAdmin, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblAdmin != null)
		{
			tblAdmin.setAdminstatus("禁用");
			int num = adminService.updateAdminStatus(tblAdmin);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "修改",operationName = "启用管理员账号")
	@RequestMapping("/openAdmin")
	public void openAdmin(TblAdmin tblAdmin, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblAdmin != null)
		{
			tblAdmin.setAdminstatus("启用");
			int num = adminService.updateAdminStatus(tblAdmin);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	/**
	 * 主页左侧菜单栏
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/treeMenu")
	public void treeDemo(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String adminname = (String) request.getSession().getAttribute("adminname");
		List<TblMenu> list = adminService.findMenuByName(adminname);
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(GsonUtils.getgsonUtils().toStr(list));
		response.getWriter().flush();
		response.getWriter().close();
	}


	/**
	 * 菜单管理
	 * @param page
	 * @param limit
	 * @param tblMenu
	 * @param dataResult
	 * @param req
	 * @param res
	 * @throws IOException
	 */
	@RequestMapping("/menuMgrInfo")
	public void menuMgrInfo(String page, String limit, TblMenu tblMenu, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblMenu.getmName() && !"".equals(tblMenu.getmName().trim()))
		{
			condition.put("mName", tblMenu.getmName());
		}

		if (null != tblMenu.getpName() && !"".equals(tblMenu.getpName().trim()))
		{
			condition.put("pName", tblMenu.getpName());
		}

		int num = adminService.findMenuCount(condition);

		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));

		List<TblMenu> list = new ArrayList<>();
		list = adminService.findAllMenu(condition, rowBounds);

		String supName = null;
		TblMenu menu = null;
		List<TblMenu> tblMenuList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++)
		{
			menu = new TblMenu();
			menu.setMenuid(list.get(i).getMenuid());
			menu.setMenuname(list.get(i).getMenuname());
			menu.setMenuurl(list.get(i).getMenuurl());
			menu.setSort(list.get(i).getSort());
			supName = adminService.findSuperierMenu(list.get(i).getMenuid());
			if (supName == null)
			{
				menu.setSupMenu(null);
			} else
			{
				menu.setSupMenu(supName);
			}
			tblMenuList.add(menu);
		}

		if (tblMenuList != null)
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

	/**
	 * 新增菜单
	 * @param tblMenu
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "新增", operationName = "新增菜单")
	@RequestMapping("/addMenuItems")
	public void addMenuItems(TblMenu tblMenu, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblMenu != null)
		{
			if (tblMenu.getpName() != null && !"".equals(tblMenu.getpName().trim()) && !"请选择".equals(tblMenu.getpName()))
			{
				Integer menuId = adminService.findSidByName(tblMenu.getpName());
				tblMenu.setMenusonid(menuId);
			}
			int num = adminService.addMenuInfo(tblMenu);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 校验菜单名
	 * @param tblMenu
	 * @param request
	 * @param response
	 */
	@RequestMapping("/checkMenuName")
	public void checkMenuName(TblMenu tblMenu, HttpServletRequest request, HttpServletResponse response)
	{
		Integer menuId = adminService.checkMenuName(tblMenu.getMenuname());
		if (menuId == null)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/**
	 * 校验菜单排序号是否重复
	 * @param sort
	 * @param request
	 * @param response
	 */
	@RequestMapping("/checkMenuSort")
	public void checkMenuSort(Integer sort, HttpServletRequest request, HttpServletResponse response)
	{
		if(sort != null)
		{
			Integer menuid = adminService.checkMenuSort(sort);
			if(menuid != null)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 修改菜单
	 * @param tblMenu
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "修改", operationName = "修改菜单信息")
	@RequestMapping("/updateMenuInfo")
	public void updateMenuInfo(TblMenu tblMenu, HttpServletRequest request, HttpServletResponse response)
	{
		if(tblMenu != null)
		{
			if (tblMenu.getpName() != null && !"".equals(tblMenu.getpName().trim()) && !"请选择".equals(tblMenu.getpName()))
			{
				Integer menuId = adminService.findSidByName(tblMenu.getpName());
				tblMenu.setMenusonid(menuId);
			}
			int num = adminService.updateMenuInfo(tblMenu);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}

	}

	/**
	 * 删除菜单
	 * @param tblMenu
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "删除", operationName = "删除菜单信息")
	@RequestMapping("/deleteMenuInfo")
	public void deleteMenuInfo(TblMenu tblMenu, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblMenu != null)
		{
			Integer menusonid = adminService.findSidByMid(tblMenu.getMenuid());
			if (menusonid != null)
			{
				Integer rolemenuid = adminService.findRoleMenuIdByMid(tblMenu.getMenuid());
				adminService.deleteRoleMenu(rolemenuid);
			}
			if (tblMenu.getpName() != null && !"".equals(tblMenu.getpName().trim()) && !"请选择".equals(tblMenu.getpName()))
			{
				Integer menuId = adminService.findSidByName(tblMenu.getpName());
				tblMenu.setMenusonid(menuId);
			}
			int num = adminService.deleteMenuInfo(tblMenu.getMenuid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@RequestMapping("/checkOldPwd")
	public void checkOldPwd(HttpServletRequest request, HttpServletResponse response)
	{
		String oldadminpwd = MD5Utils.md5(request.getParameter("oldadminpwd"));
		String adminname = (String) request.getSession().getAttribute("adminname");
		TblAdmin tblAdmin = adminService.findTblAdminByName(adminname);
		if (tblAdmin.getAdminpwd().equals(oldadminpwd))
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/**
	 * 修改管理员密码
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "修改",operationName = "修改管理员账号密码")
	@RequestMapping("/updateAdminPwd")
	public void updateAdminPwd(HttpServletRequest request, HttpServletResponse response)
	{
		String oldadminpwd = MD5Utils.md5(request.getParameter("oldadminpwd"));
		String adminname = (String) request.getSession().getAttribute("adminname");
		TblAdmin tblAdmin = adminService.findTblAdminByName(adminname);
		if (tblAdmin.getAdminpwd().equals(oldadminpwd))
		{
			String adminpwd = MD5Utils.md5(request.getParameter("adminpwd"));
			int num = adminService.updateAdminPwd(adminpwd, tblAdmin.getAdminid().toString());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		} else
		{
			ResponseUtils.outHtml(response, "pwderror");
		}
	}



	/**
	 * 日志管理
	 * @param page
	 * @param limit
	 * @param tblSysLog
	 * @param dataResult
	 * @param req
	 * @param res
	 * @throws IOException
	 */
	@RequestMapping("/logMgrInfo")
	public void findLogByPage(String page, String limit, TblSyslog tblSysLog, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();

		if (null != tblSysLog.getTime1() && !"".equals(tblSysLog.getTime1().trim()))
		{
			condition.put("time1", tblSysLog.getTime1());
		}

		if (null != tblSysLog.getTime2() && !"".equals(tblSysLog.getTime2().trim()))
		{
			condition.put("time2", tblSysLog.getTime2());
		}

		int num = systemLogService.findAllCount(condition);

		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));

		List<TblSyslog> list = new ArrayList<>();
		list = systemLogService.findAllDoc(condition, rowBounds);
		if (list != null)
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

	/**
	 * 园所详情信息
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@RequestMapping("/findKinderInfoById")
	public void findKinderInfoById(TblKinder tblKinder , HttpServletRequest request, HttpServletResponse response)
	{
		if(tblKinder != null)
		{
			List<TblKinder> tblKinderList = adminService.findKinderInfoById(tblKinder.getKinderid());
			ResponseUtils.outJson(response,GsonUtils.getgsonUtils().toStr(tblKinderList));
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	@RequestMapping("/selectKinderInfoById")
	public void selectKinderInfoById(TblKinder tblKinder , HttpServletRequest request, HttpServletResponse response)
	{
		if(tblKinder != null)
		{
			List<TblKinder> tblKinderList = adminService.selectKinderInfoById(tblKinder.getKinderid());
			ResponseUtils.outJson(response,GsonUtils.getgsonUtils().toStr(tblKinderList));
		}else{
			ResponseUtils.outHtml(response,"error");
		}
	}

	/**
	 * 园所资质审批管理
	 * @param page
	 * @param limit
	 * @param tblKinder
	 * @param dataResult
	 * @param req
	 * @param res
	 * @throws IOException
	 */
	@RequestMapping("/qualifyAppInfo")
	public void findKinderByPage(String page, String limit, TblKinder tblKinder, DataResult dataResult, HttpServletRequest req, HttpServletResponse res) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();

		if (null != tblKinder.getTime1() && !"".equals(tblKinder.getTime1().trim()))
		{
			condition.put("time1", tblKinder.getTime1());
		}

		if (null != tblKinder.getTime2() && !"".equals(tblKinder.getTime2().trim()))
		{
			condition.put("time2", tblKinder.getTime2());
		}

		if (null != tblKinder.getKinderstatus() && !"".equals(tblKinder.getKinderstatus().trim()))
		{
			condition.put("kinderstatus", tblKinder.getKinderstatus());
		}

		if (null != tblKinder.getKindercode() && !"".equals(tblKinder.getKindercode().trim()))
		{
			condition.put("kindercode", tblKinder.getKindercode());
		}

		if (null != tblKinder.getKindername() && !"".equals(tblKinder.getKindername().trim()))
		{
			condition.put("kindername", tblKinder.getKindername());
		}

		int num = adminService.findAllCount(condition);

		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));

		List<TblKinder> tblKinderList = new ArrayList<>();
		tblKinderList = adminService.findAllKinder(condition, rowBounds);
		if (tblKinderList != null)
		{
			Gson gson = new GsonBuilder().serializeNulls().create();
			dataResult.setCode(0);
			dataResult.setCount(num);
			dataResult.setMsg("");
			dataResult.setData(tblKinderList);
			res.setContentType("application/json; charset=utf-8");
			res.getWriter().write(gson.toJson(dataResult));
			res.getWriter().flush();
			res.getWriter().close();
		}
	}

	@RequestMapping("/findTblKinderById")
	public void findTblKinderById(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		tblKinder = adminService.findTblKinderById(tblKinder.getKinderid());
		if (tblKinder != null)
		{
			request.getSession().setAttribute("tblKinder", tblKinder);
		}
	}

	/**
	 * 园所资质申请通过
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "审批",operationName = "园所资质申请审批已通过")
	@RequestMapping("/checkQualify")
	public void checkQualify(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		String kinderstatus = null;
		if (tblKinder != null)
		{
			int kinderid = Integer.valueOf(request.getParameter("kinderid"));
			kinderstatus = "通过";
			int num = adminService.checkQualify(kinderstatus, kinderid, sf.format(new Date()));
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		} else
		{
			ResponseUtils.outHtml(response, "codeerror");
		}
	}

	/**
	 * 园所资质申请未通过
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "审批",operationName = "园所资质申请审批被拒绝")
	@RequestMapping("/reject")
	public void reject(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		String kinderstatus = null;
		int kinderid = Integer.valueOf(request.getParameter("kinderid"));
		if (tblKinder != null)
		{
			kinderstatus = "不通过";
			int num = adminService.checkQualify(kinderstatus, kinderid, sf.format(new Date()));
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		} else
		{
			ResponseUtils.outHtml(response, "codeerror");
		}
	}

	/**
	 * 根据园所名称查找园所账号
	 * @param request
	 * @param response
	 */
	@RequestMapping("/kinderAccount")
	public void findAccountByName(HttpServletRequest request, HttpServletResponse response)
	{
		String kindername = request.getParameter("kindername");
		String kinderacount = adminService.findAccountByName(kindername);
		if (kinderacount != null && !"".equals(kinderacount.trim()))
		{
			ResponseUtils.outHtml(response, kinderacount);
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/**
	 * 管理员新增园所
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "新增",operationName = "新增园所")
	@RequestMapping("/addKinder")
	public void addKinder(TblKinder tblKinder, TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		List<TblKinder> tblKinderList = new ArrayList<>();
		List<TblRector> tblRectorList = new ArrayList<>();
		if(tblKinder != null)
		{
			tblKinder.setKinderregtime(new Date());
			tblKinder.setKinderstatus("未审批");
			tblKinder.setKindercode("启用");
			tblKinder.setKinderpwd(MD5Utils.md5(tblKinder.getKinderpwd()));

			tblRector.setRectorname(tblKinder.getKinderlp());
			tblRector.setRectorpwd(MD5Utils.md5("123456"));
			tblRector.setRectorsex("男");
			tblRector.setRectorage(30);
			tblRector.setRectoradd(tblKinder.getKinderlpadd());
			tblRector.setRectorphone(tblKinder.getKinderlpphone());
			tblRector.setRectorregtime(new Date());
			tblRector.setRectorstatus("启用");

			Integer rectorid = adminService.selectRectorName(tblKinder.getKinderlp());
			Integer recid = null;
			if(rectorid == null)
			{
				tblRectorList.add(tblRector);
				int num2 = adminService.addRector(tblRectorList);
				recid = adminService.findRectorId(tblKinder.getKinderlp(),tblKinder.getKinderlpphone());
				tblKinder.setRecid(recid);
			} else
			{
				tblKinder.setRecid(rectorid);
			}

			tblKinderList.add(tblKinder);
			int num = adminService.addKinder(tblKinderList);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 校验园所名字是否重复
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@RequestMapping("/selectKinderName")
	public void selectKinderName(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder.getKindername() != null)
		{
			Integer kinderId = adminService.findIdByKinderName(tblKinder.getKindername());
			if (kinderId != null)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 校验园所账号是否重复
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@RequestMapping("/selectKinderAccount")
	public void selectKinderAccount(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder.getKinderacount() != null)
		{
			Integer kinderId = adminService.findIdByKinderAccount(tblKinder.getKinderacount());
			if (kinderId != null)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 根据园所id查询园所信息
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@RequestMapping("/selectKinderInfo")
	public void selectKinderInfo(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder.getKinderid() != null)
		{
			List<TblKinder> tblKinderList = adminService.selectKinderInfo(tblKinder.getKinderid());
			if (tblKinderList != null)
			{
				ResponseUtils.outJson(response, GsonUtils.getgsonUtils().toStr(tblKinderList));
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "修改",operationName = "禁用园所账号")
	@RequestMapping("/forbiddenAccount")
	public void forbiddenAccount(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder != null)
		{
			tblKinder.setKindercode("禁用");
			int num = adminService.updateKinderCode(tblKinder);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "启用",operationName = "启用园所账号")
	@RequestMapping("/openAccount")
	public void openAccount(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder != null)
		{
			tblKinder.setKindercode("启用");
			int num = adminService.updateKinderCode(tblKinder);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "修改",operationName = "重置园所账号密码")
	@RequestMapping("/restKinderPwd")
	public void restKinderPwd(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder != null)
		{
			String kinderPwd = adminService.initialPwd("初始密码");
			if(kinderPwd != null)
			{
				tblKinder.setKinderpwd(kinderPwd);
			}else{
				tblKinder.setKinderpwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restKinderPwd(tblKinder);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "删除",operationName = "删除园所信息")
	@RequestMapping("/deleteKinderInfo")
	public void deleteKinderInfo(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblKinder != null)
		{
			int num = adminService.deleteKinderInfo(tblKinder);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 修改园所信息
	 * @param tblKinder
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "修改",operationName = "修改园所信息")
	@RequestMapping("/updateKinderInfo")
	public void updateKinderInfo(TblKinder tblKinder, TblRector tblRector, String name ,HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println(tblKinder);
		if (tblKinder != null)
		{
			Integer rectorid = adminService.findRectorIdByName(name);
			System.out.println("账号"+rectorid);
			tblRector.setRectorid(rectorid);
			tblRector.setRectorphone(tblKinder.getKinderlpphone());
			tblRector.setRectoradd(tblKinder.getKinderlpadd());
			tblRector.setRectorname(tblKinder.getKinderlp());

			adminService.updateRector(tblRector);
			int num = adminService.updateKinderInfo(tblKinder);

			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 角色管理
	 * @param page
	 * @param limit
	 * @param tblRole
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/roleMgrInfo")
	public void roleDemo(String page, String limit, TblRole tblRole, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblRole.getRolename() && !"".equals(tblRole.getRolename().trim()))
		{
			condition.put("rolename", tblRole.getRolename());
		}
		int num = adminService.findRoleCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblRole> roleList = adminService.findAllRoleInfo(condition, rowBounds);
		if (roleList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(roleList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	/**
	 * 修改角色信息
	 * @param tblRole
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "修改",operationName = "修改角色信息")
	@RequestMapping("/updateRoleInfo")
	public void updateRoleInfo(TblRole tblRole, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRole != null)
		{
			int num = adminService.updateRoleInfo(tblRole);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "删除",operationName = "删除角色信息")
	@RequestMapping("/deleteRoleInfo")
	public void deleteRoleInfo(TblRole tblRole, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRole != null)
		{
			int num = adminService.deleteRoleInfo(tblRole.getRoleid());
			List<TblRoleMenu> list = adminService.findRoleMenuIdByRid(tblRole.getRoleid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@RequestMapping("/checkRoleName")
	public void checkRoleName(TblRole tblRole, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRole != null)
		{
			Integer roleId = adminService.checkRoleName(tblRole.getRolename());
			if (roleId == null)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 新增角色
	 * @param tblRole
	 * @param request
	 * @param response
	 */
	@AdminSystemLog(operationType = "新增", operationName = "新增角色")
	@RequestMapping("/addRoleItems")
	public void addRoleItems(TblRole tblRole, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRole != null)
		{
			int num = adminService.addRoleInfo(tblRole);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 亲子阅读管理
	 * @param page
	 * @param limit
	 * @param tblReadmag
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/readMgrInfo")
	public void readMgrInfo(String page, String limit, TblReadmag tblReadmag, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		String readMagName = request.getParameter("readmagname");
		if (null != readMagName && !"".equals(readMagName.trim()))
		{
			condition.put("readmagname", readMagName);
		}
		if (null != tblReadmag.getTime1() && !"".equals(tblReadmag.getTime1().trim()))
		{
			condition.put("time1", tblReadmag.getTime1());
		}

		if (null != tblReadmag.getTime2() && !"".equals(tblReadmag.getTime2().trim()))
		{
			condition.put("time2", tblReadmag.getTime2());
		}

		int num = adminService.findReadCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblReadmag> readMagList = adminService.findAllReadInfo(condition, rowBounds);
		if (readMagList != null)
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


	@RequestMapping("/findReadInfoByName")
	public void findReadInfoByName(String page, String limit, TblReadmag tblReadmag, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		String readMagName = request.getParameter("readmagname");
		if (null != readMagName && !"".equals(readMagName.trim()))
		{
			condition.put("readmagname", readMagName);
		}

		int num = adminService.findReadCountByName(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblReadmag> readMagList = adminService.findReadInfoByName(condition, rowBounds);
		if (readMagList != null)
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

	@RequestMapping("/readBookInfo")
	@ResponseBody
	public PageBean<TblReadmag> readBookInfo(HttpServletRequest request){
		Integer readmagid = Integer.valueOf(request.getParameter("readmagid"))  ;
		Integer page  = Integer.valueOf(request.getParameter("nowPage"));
		return adminService.findReadBookByPage(page,1,readmagid);
	}

	@RequestMapping("/readBook")
	public void readBook(String page, String limit,TblReadmag tblReadmag, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		Integer readmagid = Integer.valueOf(request.getParameter("readmagid"));
		Integer curPage = null;
		if(page != null)
		{
			curPage = (Integer.valueOf(page) - 1) * Integer.valueOf(limit);
		}else {
			curPage = 1;
		}
		if(readmagid != null)
		{
			int num = adminService.findReadCountById(readmagid);
			List<TblReadmag> tblReadmagList = adminService.findReadInfoById(curPage,Integer.valueOf(limit),readmagid);
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblReadmagList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}



	@AdminSystemLog(operationType = "删除",operationName = "删除绘本信息")
	@RequestMapping("/deleteReadInfo")
	public void deleteReadInfo(TblReadmag tblReadmag, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblReadmag != null)
		{
			int num = adminService.deleteReadInfo(tblReadmag.getReadmagid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改绘本信息")
	@RequestMapping("/updateReadImg")
	public void updateReadImg(TblReadmag tblReadmag, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblReadmag != null)
		{
			int num = adminService.updateReadImg(tblReadmag);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "上传",operationName = "上传管理员头像")
	@RequestMapping("/uploadAdminHeadImg")
	public void uploadAdminHeadImg(@RequestParam("file") MultipartFile file, String rolename, String adminname, String adminheadurl, String adminphone, String adminsex, TblAdmin tblAdmin, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String prefix = "";
		String dateStr = "";
		if (file != null)
		{
			String originalName = file.getOriginalFilename();
			prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
			Date date = new Date();
			String uuid = UUID.randomUUID() + "";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateStr = simpleDateFormat.format(date);
			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\img\\" + "\\" + originalName;
			File files = new File(filepath);
			//打印查看上传路径
			if (!files.getParentFile().exists())
			{
				files.getParentFile().mkdirs();
			}
			TblAdmin tblAdmin1 = adminService.findTblAdminByName(adminname);
			tblAdmin.setAdminid(tblAdmin1.getAdminid());
			tblAdmin.setAdminheadurl(adminheadurl);
			tblAdmin.setAdminsex(adminsex);
			tblAdmin.setAdminphone(adminphone);
			int num = adminService.updateAdminInfo(tblAdmin);
			if (num > 0)
			{
				file.transferTo(files);
				response.getWriter().write("{\"code\":0, \"msg\":\"\", \"data\":{}}");
				response.getWriter().flush();
				response.getWriter().close();
			}

		} else
		{
			response.getWriter().write("{\"code\":1, \"msg\":\"\", \"data\":{}}");
			response.getWriter().flush();
			response.getWriter().close();
		}
	}



	@AdminSystemLog(operationType = "上传",operationName = "上传绘本图片")
	@RequestMapping("/uploadImg")
	public void upload(@RequestParam("file") MultipartFile file, String contentInfo, String pageNum, String readMagName1, TblReadmag tblReadmag, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String prefix = "";
		String dateStr = "";
		//保存上传
		if (file != null)
		{
			String originalName = file.getOriginalFilename();
			prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
			Date date = new Date();
			String uuid = UUID.randomUUID() + "";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateStr = simpleDateFormat.format(date);
			//			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\img\\" + dateStr+"\\"+uuid+"." + prefix;
			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\img\\" + "\\" + originalName;
			File files = new File(filepath);
			//打印查看上传路径
			if (!files.getParentFile().exists())
			{
				files.getParentFile().mkdirs();
			}
			Integer readmagid = adminService.findReadMagIdByName(readMagName1);
			tblReadmag.setReadmagname(readMagName1);
			tblReadmag.setReadmagurl("E:\\kindergarten\\亲子阅读");
			tblReadmag.setReadmagdetail(contentInfo);
			tblReadmag.setPhotourl("image/adminimg/img/" + originalName);
			tblReadmag.setReadmagpage(Integer.valueOf(pageNum));
			tblReadmag.setReadmagtime(date);
			tblReadmag.setRelatedid(readmagid);
			int num = adminService.addPhotoImg(tblReadmag);
			if (num > 0)
			{
				file.transferTo(files);
				response.getWriter().write("{\"code\":0, \"msg\":\"\", \"data\":{}}");
				response.getWriter().flush();
				response.getWriter().close();
			}

		} else
		{
			response.getWriter().write("{\"code\":1, \"msg\":\"\", \"data\":{}}");
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@AdminSystemLog(operationType = "上传",operationName = "重新上传绘本信息")
	@RequestMapping("/reUploadBook")
	public void reUploadBook(TblReadmag tblReadmag, HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException
	{
		if (tblReadmag != null)
		{
			tblReadmag.setReadmagtime(new Date());
			int num = adminService.reUploadBook(tblReadmag);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}

	}

	@RequestMapping("/findRoleInfo")
	public void findRoleInfo(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		List<TblRole> tblRoleList = adminService.findRoleInfo();
		List<HashMap<String, Object>> result = new ArrayList<>();
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(GsonUtils.getgsonUtils().toStr(fun(tblRoleList, result)));
		response.getWriter().flush();
		response.getWriter().close();
	}

	private Object fun(List<TblRole> list, List<HashMap<String, Object>> result)
	{
		for (TblRole tblRole : list)
		{
			HashMap<String, Object> map = new HashMap<>();
			//id，title，spread等的命名是layui需要的，所以需要把获取到的list重新遍历一遍并命名成layui需要的字段名称
			map.put("id", tblRole.getRoleid());
			map.put("title", tblRole.getRolename());
			//设置是否展开
			map.put("spread", false);
			result.add(map);
		}
		return result;
	}

	@RequestMapping("/findMenuByRoleName")
	public void findMenuByRoleName(TblRole tblRole, Integer data, HttpServletResponse response, HttpServletRequest request) throws IOException
	{
		List<TblMenu> list = adminService.findMenuByRid(data);

		for (TblMenu tblMenu : list)
		{
			//根据一级菜单获取二级菜单，并把它加入到list
			tblMenu.setChildrenList(adminService.findMenuBySonId(tblMenu.getMenuid()));
		}

		//定义一个map处理json键名问题
		List<HashMap<String, Object>> result = new ArrayList<>();
		response.setContentType("application/json; charset=utf-8");
		//		response.getWriter().write(GsonUtils.getgsonUtils().toStr(list));
		response.getWriter().write(GsonUtils.getgsonUtils().toStr(fun2(list, result)));
		response.getWriter().flush();
		response.getWriter().close();

	}

	private Object fun2(List<TblMenu> list, List<HashMap<String, Object>> result)
	{
		for (TblMenu d : list)
		{
			HashMap<String, Object> map = new HashMap<>();
			//id，title，spread等的命名是layui需要的，所以需要把获取到的list重新遍历一遍并命名成layui需要的字段名称
			map.put("id", d.getMenuid());
			map.put("title", d.getMenuname());
			//			map.put("url",d.getMurl());
			//设置是否展开
			map.put("spread", true);
			List<HashMap<String, Object>> result1 = new ArrayList<>();
			if (d.getChildrenList() != null)
			{
				//下级菜单
				List<TblMenu> children = d.getChildrenList();
				map.put("children", fun2(children, result1));
			}
			result.add(map);
		}
		return result;
	}

	/**
	 * 平台资讯管理
	 * @param page
	 * @param limit
	 * @param tblPlatforminfo
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/platformInfoMag")
	public void platformInfoMag(String page, String limit, TblPlatforminfo tblPlatforminfo, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblPlatforminfo.getPlatforminfoname() && !"".equals(tblPlatforminfo.getPlatforminfoname().trim()))
		{
			condition.put("platforminfoname", tblPlatforminfo.getPlatforminfoname());
		}
		if (null != tblPlatforminfo.getTime1() && !"".equals(tblPlatforminfo.getTime1().trim()))
		{
			condition.put("time1", tblPlatforminfo.getTime1());
		}

		if (null != tblPlatforminfo.getTime2() && !"".equals(tblPlatforminfo.getTime2().trim()))
		{
			condition.put("time2", tblPlatforminfo.getTime2());
		}

		int num = adminService.findPlatFormInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblPlatforminfo> readMagList = adminService.findAllPlatFormInfo(condition, rowBounds);
		if (readMagList != null)
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

	@AdminSystemLog(operationType = "发布",operationName = "发布平台资讯信息")
	@RequestMapping("/releasePlatFormInfo")
	public void releasePlatFormInfo(TblPlatforminfo tblPlatforminfo, HttpServletRequest request, HttpServletResponse response)
	{
		tblPlatforminfo.setPlatforminfostatus("已发布");
		int num = adminService.releasePlatFormInfo(tblPlatforminfo);
		if (num > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}


	@AdminSystemLog(operationType = "取消",operationName = "取消发布平台资讯信息")
	@RequestMapping("/cancelPlatFormInfo")
	public void cancelPlatFormInfo(TblPlatforminfo tblPlatforminfo, HttpServletRequest request, HttpServletResponse response)
	{
		tblPlatforminfo.setPlatforminfostatus("未发布");
		int num = adminService.cancelPlatFormInfo(tblPlatforminfo);
		if (num > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	@AdminSystemLog(operationType = "删除",operationName = "删除平台资讯信息")
	@RequestMapping("/deletePlatFormInfo")
	public void deletePlatFormInfo(TblPlatforminfo tblPlatforminfo, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblPlatforminfo != null)
		{
			int num = adminService.deletePlatFormInfo(tblPlatforminfo.getPlatforminfoid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "修改",operationName = "修改平台资讯信息")
	@RequestMapping("/updatePlatFormInfo")
	public void updatePlatFormInfo(TblPlatforminfo tblPlatforminfo, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblPlatforminfo != null)
		{
			int num = adminService.updatePlatFormInfo(tblPlatforminfo);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "新增",operationName = "新增平台资讯信息")
	@RequestMapping("/addPlatFormInfo")
	public void addPlatFormInfo(TblPlatforminfo tblPlatforminfo, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblPlatforminfo != null)
		{
			tblPlatforminfo.setPlatforminfotime(new Date());
			tblPlatforminfo.setPlatforminfostatus("未发布");
			int num = adminService.addPlatFormInfo(tblPlatforminfo);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 园长管理
	 * @param page
	 * @param limit
	 * @param tblRector
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/rectorMgrInfo")
	public void rectorMgrInfo(String page, String limit, TblRector tblRector, RectorKinderBean rectorKinderBean, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();

		if (null != rectorKinderBean.getRectorname() && !"".equals(rectorKinderBean.getRectorname().trim()))
		{
			condition.put("rectorname", rectorKinderBean.getRectorname());
		}

		if (null != rectorKinderBean.getKindername() && !"".equals(rectorKinderBean.getKindername().trim()))
		{
			condition.put("kindername", rectorKinderBean.getKindername());
		}

		if (null != rectorKinderBean.getRectorstatus() && !"".equals(rectorKinderBean.getRectorstatus().trim()))
		{
			condition.put("rectorstatus", rectorKinderBean.getRectorstatus());
		}

		if (null != rectorKinderBean.getTime1() && !"".equals(rectorKinderBean.getTime1().trim()))
		{
			condition.put("time1", rectorKinderBean.getTime1());
		}

		if (null != rectorKinderBean.getTime2() && !"".equals(rectorKinderBean.getTime2().trim()))
		{
			condition.put("time2", rectorKinderBean.getTime2());
		}
//		if (null != tblRector.getRectorname() && !"".equals(tblRector.getRectorname().trim()))
//		{
//			condition.put("rectorname", tblRector.getRectorname());
//		}
//
//		if (null != tblRector.getRectorstatus() && !"".equals(tblRector.getRectorstatus().trim()))
//		{
//			condition.put("rectorstatus", tblRector.getRectorstatus());
//		}
//
//		if (null != tblRector.getTime1() && !"".equals(tblRector.getTime1().trim()))
//		{
//			condition.put("time1", tblRector.getTime1());
//		}
//
//		if (null != tblRector.getTime2() && !"".equals(tblRector.getTime2().trim()))
//		{
//			condition.put("time2", tblRector.getTime2());
//		}

		int num = adminService.findRectorInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
//		List<TblRector> tblRectorList = adminService.findAllRectorInfo(condition, rowBounds);
		List<RectorKinderBean> tblRectorList = adminService.findAllRectorInfo(condition, rowBounds);
		if (tblRectorList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblRectorList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	/**
	 * 新增园长
	 * @param tblRector
	 * @param request
	 * @param response
	*/
	@AdminSystemLog(operationType = "新增",operationName = "新增园长信息")
	@RequestMapping("/addRector")
	public void addRector(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		List<TblRector> tblRectorList = new ArrayList<>();
		if (tblRector != null)
		{
			tblRector.setRectorregtime(new Date());
			tblRector.setRectorstatus("启用");
			tblRector.setRid(1);
			tblRector.setRectorpwd(MD5Utils.md5(tblRector.getRectorpwd()));
			tblRectorList.add(tblRector);
			int num = adminService.addRector(tblRectorList);
			if (num > 0)
			{
				tblRectorList.clear();
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	/**
	 * 校验新增园长名是否重复
	 * @param tblRector
	 * @param request
	 * @param response
	 */
	@RequestMapping("/selectRectorName")
	public void selectRectorName(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRector != null)
		{
			Integer rectorid = adminService.selectRectorName(tblRector.getRectorname());
			if (rectorid != null)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "禁用园长账号")
	@RequestMapping("/forbiddenRector")
	public void forbiddenRector(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRector != null)
		{
			tblRector.setRectorstatus("禁用");
			int num = adminService.updateRectorStatus(tblRector);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "启用园长账号")
	@RequestMapping("/openRector")
	public void openRector(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRector != null)
		{
			tblRector.setRectorstatus("启用");
			int num = adminService.updateRectorStatus(tblRector);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "重置园长账号密码")
	@RequestMapping("/restRectorPwd")
	public void restRectorPwd(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRector != null)
		{
			String rectorPwd = adminService.initialPwd("初始密码");

			if(rectorPwd != null)
			{
				tblRector.setRectorpwd(rectorPwd);
			}else{
				tblRector.setRectorpwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restRectorPwd(tblRector);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除园长信息")
	@RequestMapping("/deleteRector")
	public void deleteRector(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRector != null)
		{
			int num = adminService.deleteRector(tblRector.getRectorid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改园长信息")
	@RequestMapping("/updateRector")
	public void updateRector(TblRector tblRector, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblRector != null)
		{
			int num = adminService.updateRector(tblRector);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 教师管理
	 * @param page
	 * @param limit
	 * @param tblTeacher
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/teacherMgrInfo")
	public void teacherMgrInfo(String page, String limit, TblTeacher tblTeacher, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblTeacher.getTeachername() && !"".equals(tblTeacher.getTeachername().trim()))
		{
			condition.put("teachername", tblTeacher.getTeachername());
		}

		if (null != tblTeacher.getTeacherstatus() && !"".equals(tblTeacher.getTeacherstatus().trim()))
		{
			condition.put("teacherstatus", tblTeacher.getTeacherstatus());
		}

		if (null != tblTeacher.getTeacherjob() && !"".equals(tblTeacher.getTeacherjob().trim()))
		{
			condition.put("teacherjob", tblTeacher.getTeacherjob());
		}

		if (null != tblTeacher.getTime1() && !"".equals(tblTeacher.getTime1().trim()))
		{
			condition.put("time1", tblTeacher.getTime1());
		}

		if (null != tblTeacher.getTime2() && !"".equals(tblTeacher.getTime2().trim()))
		{
			condition.put("time2", tblTeacher.getTime2());
		}

		int num = adminService.findTeacherInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblTeacher> tblTeacherList = adminService.findAllTeacherInfo(condition, rowBounds);
		if (tblTeacherList != null)
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


	@AdminSystemLog(operationType = "修改",operationName = "禁用教师账号")
	@RequestMapping("/forbiddenTeacher")
	public void forbiddenTeacher(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblTeacher != null)
		{
			tblTeacher.setTeacherstatus("禁用");
			int num = adminService.updateTeacherStatus(tblTeacher);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "启用教师账号")
	@RequestMapping("/openTeacher")
	public void openTeacher(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblTeacher != null)
		{
			tblTeacher.setTeacherstatus("启用");
			int num = adminService.updateTeacherStatus(tblTeacher);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "重置教师账号密码")
	@RequestMapping("/restTeacherPwd")
	public void restTeacherPwd(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblTeacher != null)
		{
			String teacherPwd = adminService.initialPwd("初始密码");

			if(teacherPwd != null)
			{
				tblTeacher.setTeacherpwd(teacherPwd);
			}else{
				tblTeacher.setTeacherpwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restTeacherPwd(tblTeacher);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除教师信息")
	@RequestMapping("/deleteTeacher")
	public void deleteTeacher(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblTeacher != null)
		{
			int num = adminService.deleteTeacher(tblTeacher.getTeacherid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改教师信息")
	@RequestMapping("/updateTeacher")
	public void updateTeacher(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblTeacher != null)
		{
			int num = adminService.updateTeacher(tblTeacher);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 家长管理
	 * @param page
	 * @param limit
	 * @param tblParent
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/parentMgrInfo")
	public void parentMgrInfo(String page, String limit, TblParent tblParent, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblParent.getParentName() && !"".equals(tblParent.getParentName().trim()))
		{
			condition.put("parentName", tblParent.getParentName());
		}

		if (null != tblParent.getParentStatus() && !"".equals(tblParent.getParentStatus().trim()))
		{
			condition.put("parentStatus", tblParent.getParentStatus());
		}

		if (null != tblParent.getParentJob() && !"".equals(tblParent.getParentJob().trim()))
		{
			condition.put("parentJob", tblParent.getParentJob());
		}

		if (null != tblParent.getTime1() && !"".equals(tblParent.getTime1().trim()))
		{
			condition.put("time1", tblParent.getTime1());
		}

		if (null != tblParent.getTime2() && !"".equals(tblParent.getTime2().trim()))
		{
			condition.put("time2", tblParent.getTime2());
		}

		int num = adminService.findParentInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblParent> tblParentList = adminService.findAllParentInfo(condition, rowBounds);
		if (tblParentList != null)
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


	@AdminSystemLog(operationType = "修改",operationName = "禁用家长账号")
	@RequestMapping("/forbiddenParent")
	public void forbiddenParent(TblParent tblParent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParent != null)
		{
			tblParent.setParentStatus("禁用");
			int num = adminService.updateParentStatus(tblParent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "启用家长账号")
	@RequestMapping("/openParent")
	public void openParent(TblParent tblParent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParent != null)
		{
			tblParent.setParentStatus("启用");
			int num = adminService.updateParentStatus(tblParent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "重置家长账号密码")
	@RequestMapping("/restParentPwd")
	public void restParentPwd(TblParent tblParent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParent != null)
		{
			String parentPwd = adminService.initialPwd("初始密码");

			if(parentPwd != null)
			{
				tblParent.setParentPwd(parentPwd);
			}else{
				tblParent.setParentPwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restParentPwd(tblParent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除家长信息")
	@RequestMapping("/deleteParent")
	public void deleteParent(TblParent tblParent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParent != null)
		{
			int num = adminService.deleteParent(tblParent.getParentId());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改家长信息")
	@RequestMapping("/updateParent")
	public void updateParent(TblParent tblParent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParent != null)
		{
			int num = adminService.updateParent(tblParent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}



	/**
	 * 保健员管理
	 * @param page
	 * @param limit
	 * @param tblHealther
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/healtherMgrInfo")
	public void healtherMgrInfo(String page, String limit, TblHealther tblHealther, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();

		if (null != tblHealther.getHealthername() && !"".equals(tblHealther.getHealthername().trim()))
		{
			condition.put("healthername", tblHealther.getHealthername());
		}

		if (null != tblHealther.getKindername() && !"".equals(tblHealther.getKindername().trim()))
		{
			condition.put("kindername", tblHealther.getKindername());
		}

		if (null != tblHealther.getHealtherstatus() && !"".equals(tblHealther.getHealtherstatus().trim()))
		{
			condition.put("healtherstatus", tblHealther.getHealtherstatus());
		}

		if (null != tblHealther.getTime1() && !"".equals(tblHealther.getTime1().trim()))
		{
			condition.put("time1", tblHealther.getTime1());
		}

		if (null != tblHealther.getTime2() && !"".equals(tblHealther.getTime2().trim()))
		{
			condition.put("time2", tblHealther.getTime2());
		}

		int num = adminService.findHealtherInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblHealther> tblHealtherList = adminService.findAllHealtherInfo(condition, rowBounds);
		if (tblHealtherList != null)
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



	@AdminSystemLog(operationType = "修改",operationName = "禁用保健员账号")
	@RequestMapping("/forbiddenHealther")
	public void forbiddenHealther(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblHealther != null)
		{
			tblHealther.setHealtherstatus("禁用");
			int num = adminService.updateHealtherStatus(tblHealther);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "启用保健员账号")
	@RequestMapping("/openHealther")
	public void openHealther(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblHealther != null)
		{
			tblHealther.setHealtherstatus("启用");
			int num = adminService.updateHealtherStatus(tblHealther);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "重置保健员账号密码")
	@RequestMapping("/restHealtherPwd")
	public void restHealtherPwd(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblHealther != null)
		{
			String healtherPwd = adminService.initialPwd("初始密码");
			if(healtherPwd != null)
			{
				tblHealther.setHealtherpwd(healtherPwd);
			}else{
				tblHealther.setHealtherpwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restHealtherPwd(tblHealther);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除保健员信息")
	@RequestMapping("/deleteHealther")
	public void deleteHealther(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblHealther != null)
		{
			int num = adminService.deleteHealther(tblHealther.getHealtherid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改保健员信息")
	@RequestMapping("/updateHealther")
	public void updateHealther(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblHealther != null)
		{
			int num = adminService.updateHealther(tblHealther);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	//安防员管理
	@RequestMapping("/securityMgrInfo")
	public void securityMgrInfo(String page, String limit, TblSecurity tblSecurity, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();

		if (null != tblSecurity.getSecurityname() && !"".equals(tblSecurity.getSecurityname().trim()))
		{
			condition.put("securityname", tblSecurity.getSecurityname());
		}

		if (null != tblSecurity.getKindername() && !"".equals(tblSecurity.getKindername().trim()))
		{
			condition.put("kindername", tblSecurity.getKindername());
		}

		if (null != tblSecurity.getSecuritystatus() && !"".equals(tblSecurity.getSecuritystatus().trim()))
		{
			condition.put("securitystatus", tblSecurity.getSecuritystatus());
		}

		if (null != tblSecurity.getTime1() && !"".equals(tblSecurity.getTime1().trim()))
		{
			condition.put("time1", tblSecurity.getTime1());
		}

		if (null != tblSecurity.getTime2() && !"".equals(tblSecurity.getTime2().trim()))
		{
			condition.put("time2", tblSecurity.getTime2());
		}

		int num = adminService.findSecurityInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblSecurity> tblSecurityList = adminService.findAllSecurityInfo(condition, rowBounds);
		if (tblSecurityList != null)
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



	@AdminSystemLog(operationType = "修改",operationName = "禁用安防员账号")
	@RequestMapping("/forbiddenSecurity")
	public void forbiddenSecurity(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSecurity != null)
		{
			tblSecurity.setSecuritystatus("禁用");
			int num = adminService.updateSecurityStatus(tblSecurity);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "启用安防员账号")
	@RequestMapping("/openSecurity")
	public void openSecurity(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSecurity != null)
		{
			tblSecurity.setSecuritystatus("启用");
			int num = adminService.updateSecurityStatus(tblSecurity);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "重置安防员账号密码")
	@RequestMapping("/restSecurityPwd")
	public void restSecurityPwd(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSecurity != null)
		{
			String  securityPwd = adminService.initialPwd("初始密码");
			if(securityPwd != null)
			{
				tblSecurity.setSecuritypwd(securityPwd);
			}else{
				tblSecurity.setSecuritypwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restSecurityPwd(tblSecurity);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除安防员信息")
	@RequestMapping("/deleteSecurity")
	public void deleteSecurity(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSecurity != null)
		{
			int num = adminService.deleteSecurity(tblSecurity.getSecurityid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改安防员信息")
	@RequestMapping("/updateSecurity")
	public void updateSecurity(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSecurity != null)
		{
			int num = adminService.updateSecurity(tblSecurity);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	/**
	 * 学生管理
	 */
	@RequestMapping("/studentMgrInfo")
	public void studentMgrInfo(String page, String limit, TblStudent tblStudent, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblStudent.getStudentname() && !"".equals(tblStudent.getStudentname().trim()))
		{
			condition.put("studentname", tblStudent.getStudentname());
		}

		if (null != tblStudent.getStudentstatus() && !"".equals(tblStudent.getStudentstatus().trim()))
		{
			condition.put("studentstatus", tblStudent.getStudentstatus());
		}

		if (null != tblStudent.getTime1() && !"".equals(tblStudent.getTime1().trim()))
		{
			condition.put("time1", tblStudent.getTime1());
		}

		if (null != tblStudent.getTime2() && !"".equals(tblStudent.getTime2().trim()))
		{
			condition.put("time2", tblStudent.getTime2());
		}

		int num = adminService.findStudentInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblStudent> tblStudentList = adminService.findAllStudentInfo(condition, rowBounds);
		if (tblStudentList != null)
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


	@AdminSystemLog(operationType = "修改",operationName = "禁用幼儿账号")
	@RequestMapping("/forbiddenStudent")
	public void forbiddenStudent(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblStudent != null)
		{
			tblStudent.setStudentstatus("禁用");
			int num = adminService.updateStudentStatus(tblStudent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "启用幼儿账号")
	@RequestMapping("/openStudent")
	public void openStudent(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblStudent != null)
		{
			tblStudent.setStudentstatus("启用");
			int num = adminService.updateStudentStatus(tblStudent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "重置幼儿账号密码")
	@RequestMapping("/restStudentPwd")
	public void restStudentPwd(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblStudent != null)
		{
			String studentPwd = adminService.initialPwd("初始密码");
			if(studentPwd != null)
			{
				tblStudent.setStudentpwd(studentPwd);
			}else{
				tblStudent.setStudentpwd(MD5Utils.md5("123456"));
			}

			int num = adminService.restStudentPwd(tblStudent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	@AdminSystemLog(operationType = "删除",operationName = "删除幼儿信息")
	@RequestMapping("/deleteStudent")
	public void deleteStudent(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblStudent != null)
		{
			int num = adminService.deleteStudent(tblStudent.getStudentid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改幼儿信息")
	@RequestMapping("/updateStudent")
	public void updateStudent(TblStudent tblStudent, HttpServletRequest request, String classname, String kindername, HttpServletResponse response)
	{
		if(kindername != null && !kindername.equals("请选择"))
		{
			tblStudent.setKid(adminService.findIdByKinderName(kindername));
		}
		if(classname != null && !classname.equals("请选择"))
		{
			tblStudent.setCid(adminService.findIdByClassName(classname));
		}
		if (tblStudent != null)
		{
			int num = adminService.updateStudent(tblStudent);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	//安全教育管理

	@RequestMapping("/safetyEducationInfo")
	public void safetyEducationInfo(String page, String limit, TblSafetyvideo tblSafetyvideo, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblSafetyvideo.getSafetyvideoname() && !"".equals(tblSafetyvideo.getSafetyvideoname().trim()))
		{
			condition.put("safetyvideoname", tblSafetyvideo.getSafetyvideoname());
		}

		if (null != tblSafetyvideo.getTime1() && !"".equals(tblSafetyvideo.getTime1().trim()))
		{
			condition.put("time1", tblSafetyvideo.getTime1());
		}

		if (null != tblSafetyvideo.getTime2() && !"".equals(tblSafetyvideo.getTime2().trim()))
		{
			condition.put("time2", tblSafetyvideo.getTime2());
		}

		int num = adminService.findSafetyVideoInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblSafetyvideo> tblSafetyVideoList = adminService.findAllSafetyVideoInfo(condition, rowBounds);
		if (tblSafetyVideoList != null)
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

	@AdminSystemLog(operationType = "删除",operationName = "删除安全视频信息")
	@RequestMapping("/deleteSafetyVideoInfo")
	public void deleteSafetyVideoInfo(TblSafetyvideo tblSafetyvideo, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSafetyvideo != null)
		{
			int num = adminService.deleteSafetyVideoInfo(tblSafetyvideo.getSafetyvideoid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	//查找试题
	@RequestMapping("/findAllSafetyVideoItemsInfo")
	public void findAllSafetyVideoItemsInfo(TblSafetyvideo tblSafetyvideo, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSafetyvideo != null)
		{
			List<TblSafetyvtq> tblSafetyvtqList = adminService.findAllSafetyVideoItemsInfo(tblSafetyvideo.getSafetyvideoid());
			if (tblSafetyvtqList != null)
			{
				ResponseUtils.outJson(response, GsonUtils.getgsonUtils().toStr(tblSafetyvtqList));
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@RequestMapping("/videoQuestionConfiguration")
	public void videoQuestionConfiguration(String page, String limit, TblSafetyvideo tblSafetyvideo, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblSafetyvideo.getSafetyvideoname() && !"".equals(tblSafetyvideo.getSafetyvideoname().trim()))
		{
			condition.put("safetyvideoname", tblSafetyvideo.getSafetyvideoname());
		}

		if (null != tblSafetyvideo.getTime1() && !"".equals(tblSafetyvideo.getTime1().trim()))
		{
			condition.put("time1", tblSafetyvideo.getTime1());
		}

		if (null != tblSafetyvideo.getTime2() && !"".equals(tblSafetyvideo.getTime2().trim()))
		{
			condition.put("time2", tblSafetyvideo.getTime2());
		}

		int num = adminService.findSafetyVideoInfoCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblSafetyvideo> tblSafetyVideoList = adminService.findAllVideoQuestionConfigInfo(condition, rowBounds);
		if (tblSafetyVideoList != null)
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

	@AdminSystemLog(operationType = "上传", operationName = "上传视频")
	@RequestMapping("/uploadVideo")
	public void uploadVideo(@RequestParam("file") MultipartFile file, String safetyVideoName, String videoName, String videoAdd, TblSafetyvideo tblSafetyvideo, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String prefix = "";
		String dateStr = "";
		//保存上传
		if (file != null)
		{
			String originalName = file.getOriginalFilename();
			prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
			Date date = new Date();
			String uuid = UUID.randomUUID() + "";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateStr = simpleDateFormat.format(date);
			//			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\img\\" + dateStr+"\\"+uuid+"." + prefix;
			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\video\\" + "\\" + originalName;
			File files = new File(filepath);
			//打印查看上传路径
			if (!files.getParentFile().exists())
			{
				files.getParentFile().mkdirs();
			}
			tblSafetyvideo.setSafetyvideoname(safetyVideoName);
			tblSafetyvideo.setVideoadd(videoAdd);
			tblSafetyvideo.setVideoname(videoName);
			tblSafetyvideo.setSafetyvideotime(new Date());
			tblSafetyvideo.setMid(1);
			List<TblSafetyvideo> tblSafetyVideoList = new ArrayList<>();
			tblSafetyVideoList.add(tblSafetyvideo);
			int num = adminService.addSafetyVideo(tblSafetyVideoList);
			if (num > 0)
			{
				file.transferTo(files);
				tblSafetyVideoList.clear();
				response.getWriter().write("{\"code\":0, \"msg\":\"\", \"data\":{}}");
				response.getWriter().flush();
				response.getWriter().close();
			}
		} else
		{
			response.getWriter().write("{\"code\":1, \"msg\":\"\", \"data\":{}}");
			response.getWriter().flush();
			response.getWriter().close();
		}
	}


	@AdminSystemLog(operationType = "上传", operationName = "重新上传视频")
	@RequestMapping("/updateSafetyVideoInfo")
	public void updateSafetyVideoInfo(@RequestParam("file") MultipartFile file, String safetyVideoName, String videoName, String videoAdd, Integer safetyvideoid, TblSafetyvideo tblSafetyvideo, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String prefix = "";
		String dateStr = "";
		//保存上传
		if (file != null)
		{
			String originalName = file.getOriginalFilename();
			prefix = originalName.substring(originalName.lastIndexOf(".") + 1);
			Date date = new Date();
			String uuid = UUID.randomUUID() + "";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateStr = simpleDateFormat.format(date);
			String filepath = "D:\\kindergarten\\src\\main\\webapp\\image\\adminimg\\video\\" + "\\" + originalName;
			File files = new File(filepath);
			//打印查看上传路径
			if (!files.getParentFile().exists())
			{
				files.getParentFile().mkdirs();
			}
			int num = 0;
			if (safetyvideoid != null)
			{
				tblSafetyvideo.setSafetyvideoid(safetyvideoid);
				tblSafetyvideo.setSafetyvideoname(safetyVideoName);
				tblSafetyvideo.setVideoadd(videoAdd);
				tblSafetyvideo.setVideoname(videoName);
				tblSafetyvideo.setSafetyvideotime(new Date());
				num = adminService.updateSafetyVideo(tblSafetyvideo);
			}
			if (num > 0)
			{
				file.transferTo(files);
				response.getWriter().write("{\"code\":0, \"msg\":\"\", \"data\":{}}");
				response.getWriter().flush();
				response.getWriter().close();
			}
			else
			{
				response.getWriter().write("{\"code\":1, \"msg\":\"\", \"data\":{}}");
				response.getWriter().flush();
				response.getWriter().close();
			}
		}
	}


	@AdminSystemLog(operationType = "新增",operationName = "新增题目")
	@RequestMapping("/addTopic")
	public void addTopic(TblSafetyvtq tblSafetyvtq, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSafetyvtq != null)
		{
			int num = adminService.addTopic(tblSafetyvtq);
			if (num > 0)
			{
				List<TblSafetyvtq> tblSafetyvtqList = adminService.findAllSafetyVideoItemsInfo(tblSafetyvtq.getSafetyvideoid());
				ResponseUtils.outJson(response, GsonUtils.getgsonUtils().toStr(tblSafetyvtqList));
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}

	}

	@RequestMapping("/queryTopic")
	public void queryTopic(TblSafetyvtq tblSafetyvtq, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSafetyvtq != null)
		{
			List<TblSafetyvtq> tblSafetyvtqList = adminService.queryTopicById(tblSafetyvtq.getSafetyvtqid());
			if (tblSafetyvtqList != null)
			{
				ResponseUtils.outJson(response, GsonUtils.getgsonUtils().toStr(tblSafetyvtqList));
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除题目信息")
	@RequestMapping("/deleteTopic")
	public void deleteTopic(TblSafetyvtq tblSafetyvtq, String safetyVideoName, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSafetyvtq != null)
		{
			int num = adminService.deleteTopic(tblSafetyvtq);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改题目信息")
	@RequestMapping("/updateTopic")
	public void updateTopic(TblSafetyvtq tblSafetyvtq, String safetyVideoName, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblSafetyvtq != null)
		{
			int num = adminService.updateTopic(tblSafetyvtq);
			if (num > 0)
			{
				ResponseUtils.outJson(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}

	//参数配置管理
	@RequestMapping("/parameterMgrInfo")
	public void parameterMgrInfo(String page, String limit, TblParameter tblParameter, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblParameter.getParametername() && !"".equals(tblParameter.getParametername().trim()))
		{
			condition.put("parametername", tblParameter.getParametername());
		}

		if (null != tblParameter.getParametertype() && !"".equals(tblParameter.getParametertype().trim()))
		{
			condition.put("parametertype", tblParameter.getParametertype());
		}

		int num = adminService.findParameterCount(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblParameter> tblParameterList = adminService.findAllParameter(condition, rowBounds);
		if (tblParameterList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(tblParameterList);
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}


	@AdminSystemLog(operationType = "新增",operationName = "新增参数信息")
	@RequestMapping("/addParameter")
	public void addParameter(TblParameter tblParameter, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParameter != null)
		{
			List<TblParameter> tblParameterList = new ArrayList<>();
			tblParameterList.add(tblParameter);
			int num = adminService.addParameter(tblParameterList);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "删除",operationName = "删除参数信息")
	@RequestMapping("/deleteParameter")
	public void deleteParameter(TblParameter tblParameter, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParameter != null)
		{
			int num = adminService.deleteParameter(tblParameter.getParameterid());
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	@AdminSystemLog(operationType = "修改",operationName = "修改参数信息")
	@RequestMapping("/updateParameter")
	public void updateParameter(TblParameter tblParameter, HttpServletRequest request, HttpServletResponse response)
	{
		if (tblParameter != null)
		{
			int num = adminService.updateParameter(tblParameter);
			if (num > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	/**
	 * 幼儿统计
	 * @param tblExamination
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/findChildrenStatisticsInfo")
	public void findChildrenStatisticsInfo(TblExamination tblExamination, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		List<TblStatistics> childrenSexList = adminService.findChildrenSexInfo();
		List<TblStatistics> childrenAgeList = adminService.findChildrenAgeInfo();
		List<TblStatistics> childrenStatusList = adminService.findChildrenStatusInfo();

		if (!childrenSexList.isEmpty())
		{
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			String sex = GsonUtils.getgsonUtils().toStr(childrenSexList);
			String age = GsonUtils.getgsonUtils().toStr(childrenAgeList);
			String status = GsonUtils.getgsonUtils().toStr(childrenStatusList);
			String res = sex + "@" + age + "@" + status ;
			response.getWriter().print(res);
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/**
	 * 教师统计
	 * @param tblExamination
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/findTeacherStatisticsInfo")
	public void findTeacherStatisticsInfo(TblExamination tblExamination, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		List<TblStatistics> teacherSexList = adminService.findTeacherSexInfo();
		List<TblStatistics> teacherAgeList = adminService.findTeacherAgeInfo();
		if (!teacherSexList.isEmpty())
		{
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			String sex = GsonUtils.getgsonUtils().toStr(teacherSexList);
			String age = GsonUtils.getgsonUtils().toStr(teacherAgeList);
			String res = sex + "@" + age;
			response.getWriter().print(res);
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/**
	 * 园所统计
	 * @param tblExamination
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/findKinderStatisticsInfo")
	public void findKinderStatisticsInfo(TblExamination tblExamination, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		List<TblStatistics> kinderScaleList = adminService.findKinderScaleInfo();
		List<TblStatistics> kinderFundsList = adminService.findKinderFundsInfo();
		if (!kinderScaleList.isEmpty())
		{
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			String scale = GsonUtils.getgsonUtils().toStr(kinderScaleList);
			String funds = GsonUtils.getgsonUtils().toStr(kinderFundsList);
			String res = scale + "@" + funds;
			response.getWriter().print(res);
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}



	/**
	 * 权限管理
	 * @param page
	 * @param limit
	 * @param tblRole
	 * @param dataResult
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/permissionAssignmentInfo")
	public void permissionAssignmentInfo(String page, String limit, TblRole tblRole, DataResult dataResult, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HashMap<String, Object> condition = new HashMap<>();
		if (null != tblRole.getRolename() && !"".equals(tblRole.getRolename().trim()))
		{
			condition.put("rolename", tblRole.getRolename());
		}
		int num = adminService.findRoleCounts(condition);
		RowBounds rowBounds = new RowBounds((Integer.valueOf(page) - 1) * Integer.valueOf(limit), Integer.valueOf(limit));
		List<TblRole> roleList = adminService.findRoleInfos(condition, rowBounds);

		if (roleList != null)
		{
			dataResult.setCode(0);
			dataResult.setMsg("");
			dataResult.setCount(num);
			dataResult.setData(roleList);

			response.setContentType("application/json; charset=utf-8");
			response.getWriter().write(GsonUtils.getgsonUtils().toStr(dataResult));
			response.getWriter().flush();
			response.getWriter().close();
		}
	}

	@RequestMapping("/findAllMenuInfo")
	public void findAllMenu(TblRole tblRole, HttpServletRequest req, HttpServletResponse res)
	{
		List<MenuTreeInfo> menuTreeInfos = adminService.findAllMenuInfo();
		List<MenuTreeInfo> menuTreeInfos1 = adminService.findMenuByRoleID(tblRole.getRoleid());
		Map map = new LinkedHashMap();

		map.put("mid", menuTreeInfos1);
		map.put("menu", menuTreeInfos);
		if (menuTreeInfos.size() != 0)
		{
			ResponseUtils.outJson(res, map);
		} else
		{
			ResponseUtils.outHtml(res, "error");
		}
	}

	@RequestMapping("/updateMenu")
	@ResponseBody
	@AdminSystemLog(operationType = "权限配置",operationName = "用户权限分配")
	public void updateMenu(@RequestBody String msg, HttpServletRequest req, HttpServletResponse res) throws IOException
	{
		if (msg != null)
		{
			ObjectMapper mapper = new ObjectMapper();
			TblMenu menu = mapper.readValue(msg, TblMenu.class);
			Integer rid = menu.getRid();
			ArrayList fatherNodeId = (ArrayList) menu.getFatherNodeId();
			ArrayList sonNodeId = (ArrayList) menu.getSonNodeId();
			ArrayList roleMenuList = new ArrayList();
			roleMenuList.addAll(fatherNodeId);
			roleMenuList.addAll(sonNodeId);
			List<Map<String, Integer>> list = new ArrayList<>();
			for (int i = 0; i < roleMenuList.size(); i++)
			{
				Map<String, Integer> map = new LinkedHashMap<>();
				Integer mid = Double.valueOf(roleMenuList.get(i).toString()).intValue();
				map.put("rid", rid);
				map.put("mid", mid);
				list.add(map);
			}
			int num = adminService.deleteMenuId(rid);
			int num1 = adminService.updateMenu(list);
			if (num1 > 0)
			{
				ResponseUtils.outHtml(res, "success");
			} else
			{
				ResponseUtils.outHtml(res, "error");
			}
		}
	}
}
