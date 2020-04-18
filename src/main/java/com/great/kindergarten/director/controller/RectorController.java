package com.great.kindergarten.director.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.resultbean.DateTable;
import com.great.kindergarten.director.resultbean.TblScTInfo;
import com.great.kindergarten.director.service.KinderService;
import com.great.kindergarten.director.service.RectorService;
import com.great.kindergarten.security.service.SecurityService;
import com.great.kindergarten.util.DateUtil;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import com.great.kindergarten.websocket.domain.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

/**
 * @author JK
 */
@Controller
@RequestMapping("/director")
public class RectorController
{
	private String vcode;

	@Resource
	private RectorService rectorService;

	@Resource
	private KinderService kinderService;

	@Resource
	private SecurityService securityService;

	@Resource
	TblRector tblRector;

	@Resource
	TblKinder tblKinder;

	@Resource
	TblCourse tblCourse;
	//	@Resource
	//	TblTeacher tblTeacher;
	//结果集的处理
	@Resource
	DateTable dateTable;

	//	管理路径跳转的问题--前台的界面(路径/toUrl/*)
	@RequestMapping("/toUrl/{id}")
	public String matchUrl(@PathVariable("id") String id)
	{
		System.out.println("id=" + id);
		return "/directorjsp/" + id;
	}

	//验证码的登录
	@RequestMapping("/loginCode")
	public void cherkCode(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		int width = 68;
		int height = 22;
		System.out.println("进来这个方法里面=========================");
		//BufferedImage将图片存入缓存中，有三个构造方法，此处的三个参数为图片的宽，高，以及创建的图像类型。
		BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		//为bi创建图形上下文
		Graphics g = bi.getGraphics();
		//设置颜色，此处调用的构造方法是基于RGB数值作为参数的
		Color c = new Color(237, 230, 194);
		//设置颜色
		g.setColor(c);
		//该方法用于填充指定的矩形，参数是坐标和宽高
		g.fillRect(0, 0, width, height);

		//编写随机获取验证码的部分

		//将字符串转换为字符数组
		char[] ch = "abcdefghjklmnopqrstuvwxyz023456789".toCharArray();
		//随机类，在本程序中只使用了 int nextInt(int n) 方法，作用是生成一个0-n的伪随机int值
		Random r = new Random();

		int len = ch.length, index;

		//给图中绘制噪音点，让图片不那么好辨别
		for (int j = 0, n = r.nextInt(50); j < n; j++)
		{
			g.setColor(Color.RED);
			g.fillRect(r.nextInt(width), r.nextInt(height), 1, 1);//随机噪音点
		}
		//用于存储随机生成的四位验证码
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < 4; i++)
		{
			//从0-len随机获取一个作为下标
			index = r.nextInt(len);
			//随机获取颜色
			g.setColor(new Color(r.nextInt(200), r.nextInt(150), r.nextInt(255)));

			//在图形中绘制指定的String，参数对应要绘制的String以及坐标
			g.drawString(ch[index] + " ", (i * 15) + 3, 18);

			//将内容添加到StringBuffer
			sb.append(ch[index]);
		}

		//将验证码信息放入session中用于验证
		request.getSession().setAttribute("PicCode", sb.toString());
		//将文件流输出，参数要写入的RenderedImage，输出的文件格式，输出到的ImageOutputStream
		ImageIO.write(bi, "JPG", response.getOutputStream());
	}

	//登录判断
	@RequestMapping("/directorLogin")
	public void loginCode(String username, String userpwd, String code, HttpServletRequest request, HttpServletResponse response)
	{
		//        request.getSession().setAttribute("username", username);
		tblRector.setRectorname(username);
		String md5pwd = MD5Utils.md5(userpwd);
		System.out.println("密码是：" + md5pwd);
		tblRector.setRectorpwd(md5pwd);

		TblRector tblRectors = rectorService.findRector(tblRector);
		System.out.println(tblRectors);
		if (null != tblRectors)
		{
			String rectorstatus =  tblRectors.getRectorstatus();
			if(rectorstatus.equals("启用")){
				request.getSession().setAttribute("logintblRector", tblRectors);
				String PicCode = (String) request.getSession().getAttribute("PicCode");
				code = code.toLowerCase();
				if (code.equals(PicCode))
				{
					String kindername = (String) request.getSession().getAttribute("kindername");
					List<TblCampus> tblCampusList = securityService.findKinderNews(kindername);
					request.getSession().setAttribute("tblCampusList", tblCampusList);
					System.out.println("前台验证码成功！");
					ResponseUtils.outHtml(response, "success");
				} else
				{
					System.out.println("前台验证码失败！");
					ResponseUtils.outHtml(response, "codeerror");
				}
			}else{
				System.out.println("前台用户是不是启用！");
				ResponseUtils.outHtml(response, "notmen");
			}
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//判断密码是不是一致
	@RequestMapping("/oldpassword")
	public void oldpassword(String oldpwd, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		TblRector tbs = (TblRector) request.getSession().getAttribute("logintblRector");
		tblRector.setRectorid(tbs.getRectorid());
		String md5pwd = MD5Utils.md5(oldpwd);
		System.out.println("密码是：" + oldpwd);
		tblRector.setRectorpwd(md5pwd);
		System.out.println("密码：" + tblRector);
		TblRector tblRector1 = rectorService.selectoldPwd(tblRector);
		if (null != tblRector1)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//	updatePwd更新密码
	@RequestMapping("/updatePwd")
	public void updatePwd(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		TblRector tbs = (TblRector) request.getSession().getAttribute("logintblRector");
		tblRector.setRectorid(tbs.getRectorid());
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
		String md5pwd = MD5Utils.md5(password);
		System.out.println("密码是：" + password);
		tblRector.setRectorpwd(md5pwd);
		System.out.println(tblRector + "内容是" + repassword);
		int result = rectorService.updateByIdPwd(tblRector);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "更新成功");
		} else
		{
			ResponseUtils.outHtml(response, "更新失败");
		}
	}

	//退出对应的主页--园长端退出:
	@RequestMapping("/exit")
	public void userexit(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		System.out.println("进入到对应的退出方法里面!");
		try
		{
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("charset='UTF-8'");

		//获取session对象
		HttpSession hs = request.getSession();
		//强制销毁session
		hs.invalidate();
		//重定向到登录页面
		response.sendRedirect(request.getContextPath() + "/director/toUrl/directorLogin");
	}

	//园所申请审批
	@RequestMapping("/directorReg")
	public void directorReg(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		tblKinder.setKinderstatus("未审批");
		tblKinder.setKinderregtime(new Date());
		String md5pwd = MD5Utils.md5(tblKinder.getKinderpwd());
		tblKinder.setKinderpwd(md5pwd);
		System.out.println("园所申请审批：" + tblKinder);
		int result = kinderService.addKinderMsg(tblKinder);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//对应的是园所教师信息查询和显示selectTeacherManage
	@RequestMapping("/selectTeacherManage")
	public void selectTeacherManage(HttpServletRequest request, HttpServletResponse response) throws ParseException, UnsupportedEncodingException
	{
		//前端传过来的值通过-json里面去查看
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String teachername = request.getParameter("teachername");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("教师名是=" + teachername);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != teachername && "" != teachername)
		{
			map.put("teachername", teachername);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("用户信息=" + map);
		List<TblTeacher> tblTeachers = rectorService.findTeacherAll(map);
		System.out.println("输出成功" + tblTeachers.toString());

		if (0 != tblTeachers.size())
		{
			Integer count = rectorService.findTeacherAllCount(map).intValue();
			System.out.println("输出次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblTeachers);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			//			request.getSession().setAttribute("cName", cName);
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//园所-----教师信息----进行对应的删除操作
	//删除对应表格的内容的值
	@RequestMapping("/delTeacherTable")
	public void delTable(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("teacherid");
		System.out.println("删除servlet" + id);
		int teacherid = Integer.valueOf(id);

		int result = rectorService.delTeacherTable(teacherid);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----教师信息----更新对应表格的内容的值
	@RequestMapping("/updateTeacherTable")
	public void updateTeacherTable(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String teacherid = request.getParameter("teacherid");
		System.out.println("内容是=" + teacherid);
		int teacherids = Integer.valueOf(teacherid);
		System.out.println("servlet=" + teacherids);
		String teachername = request.getParameter("teachername");
		String teacherjob = request.getParameter("teacherjob");

		if (teacherjob.equals("班主任"))
		{
			tblTeacher.setRid(4);
		} else if (teacherjob.equals("安防员"))
		{
			tblTeacher.setRid(5);
		} else if (teacherjob.equals("保健员"))
		{
			tblTeacher.setRid(6);
		}
		tblTeacher.setTeacherid(teacherids);
		tblTeacher.setTeachername(teachername);
		tblTeacher.setTeacherjob(teacherjob);


		System.out.println("内容是=" + tblTeacher);
		int result = rectorService.updateTeacherById(tblTeacher);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----教师信息----添加对应的表格的信息
	@RequestMapping("/addTeacherForm")
	protected void addTeacherForm(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String teacherjob = tblTeacher.getTeacherjob();
		if (teacherjob.equals("班主任"))
		{
			tblTeacher.setRid(4);
		} else if (teacherjob.equals("安防员"))
		{
			tblTeacher.setRid(5);
		} else if (teacherjob.equals("保健员"))
		{
			tblTeacher.setRid(6);
		}
		//使用的密码是默认的密码
		String md5pwd = MD5Utils.md5("123456");
		tblTeacher.setTeacherpwd(md5pwd);
		System.out.println("申请教师=" + tblTeacher);
		int result = rectorService.addTeacherForm(tblTeacher);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/*
	 * 幼儿管理
	 * */
	//幼儿信息的显示
	@RequestMapping("/selectChildrenManagement")
	public void selectChildrenManagement(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String studentname = request.getParameter("studentname");
		String beginTime = request.getParameter("beginTime");
		String overTime = request.getParameter("overTime");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("用户名是=" + studentname);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != studentname && "" != studentname)
		{
			map.put("studentname", studentname);
		}
		if (null != beginTime && "" != beginTime)
		{
			map.put("beginTime", beginTime);
		}
		if (null != overTime && "" != overTime)
		{
			map.put("overTime", overTime);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("用户信息=" + map);
		List<TblStudent> tblStudents = rectorService.findChildrenAll(map);

		if (0 != tblStudents.size())
		{
			Integer count = rectorService.findChildrenAllCount(map).intValue();
			System.out.println("输出幼儿次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblStudents);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			//			request.getSession().setAttribute("cName", cName);
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//	幼儿信息的增加
	@RequestMapping("/addChildrenForm")
	protected void addChildrenForm(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		tblStudent.setStudenttime(new Date());
		int result = rectorService.addChildrenForm(tblStudent);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所----幼儿信息进行对应的删除操作delTeacherTable
	@RequestMapping("/delChildrenTable")
	public void delChildrenTable(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("studentid");
		System.out.println("删除servlet" + id);
		int studentid = Integer.valueOf(id);

		int result = rectorService.delChildrenTable(studentid);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----幼儿信息----更新对应表格的内容的值
	@RequestMapping("/updateChildrenTable")
	public void updateChildrenTable(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String studentid = request.getParameter("studentid");
		System.out.println("内容是=" + studentid);
		int studentids = Integer.valueOf(studentid);
		String studentname = request.getParameter("studentname");
		String studentsex = request.getParameter("studentsex");
		String studentbrith = request.getParameter("studentbrith");

		tblStudent.setStudentid(studentids);
		tblStudent.setStudentname(studentname);
		tblStudent.setStudentsex(studentsex);
		tblStudent.setStudentbrith(studentbrith);

		System.out.println("内容是=" + tblStudent);
		int result = rectorService.updateChildrenById(tblStudent);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/*
	 *家长管理
	 * */
	//家长信息的显示
	@RequestMapping("/selectParentManagement")
	public void selectParentManagement(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String parentname = request.getParameter("parentname");
		String beginTime = request.getParameter("beginTime");
		String overTime = request.getParameter("overTime");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("家长名是=" + parentname);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != parentname && "" != parentname)
		{
			map.put("parentname", parentname);
		}
		if (null != beginTime && "" != beginTime)
		{
			map.put("beginTime", beginTime);
		}
		if (null != overTime && "" != overTime)
		{
			map.put("overTime", overTime);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("家长信息=" + map);
		List<TblParent> tblParents = rectorService.findParentAll(map);

		System.out.println("家长输出=" + tblParents);
		if (0 != tblParents.size())
		{
			Integer count = rectorService.findParentAllCount(map).intValue();
			System.out.println("输出家长次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblParents);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");

			//查找对应的幼儿园的孩子信息--下拉框的显示
			//			List<TblStudent> tblStudentList = rectorService.findChildren(map);

			List<TblStudent> tblStudentList = rectorService.findChildrenParentAll();
			System.out.println("请获取孩子的信息：" + tblStudentList);
			request.getSession().setAttribute("tblStudentList", tblStudentList);
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//	家长信息的增加
	@RequestMapping("/addParentForm")
	protected void addParentForm(TblParent tblParent, String studentname, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		System.out.println("家长的添加信息显示：" + tblParent + studentname);
		if (tblParent.getParentSon().equals("爸爸"))
		{
			tblParent.setParentSex("男");
		} else if (tblParent.getParentSon().equals("妈妈"))
		{
			tblParent.setParentSex("女");
		}
		tblParent.setParentRegTime(new Date());
		int result = rectorService.addParentForm(tblParent);
		if (result > 0)
		{
			TblParent tblParentByPid = rectorService.selectParentByPid(tblParent.getParentName());
			//修改对应的学生表的家长的外键
			Map<String, Object> map = new HashMap<>();
			if (null != studentname && "" != studentname)
			{
				map.put("studentname", studentname);
			}
			if (0 != tblParentByPid.getParentId())
			{
				map.put("pid", tblParentByPid.getParentId());
			}

			int result0 = rectorService.updateChildrenByPid(map);
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所----家长信息----删除操作
	@RequestMapping("/delParentTable")
	public void delParentTable(String studentname, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("parentId");
		System.out.println("删除servlet" + id);
		int parentId = Integer.valueOf(id);

		int result = rectorService.delParentTable(parentId);
		if (result > 0)
		{
			//			删除成功对应的家长信息
			Map<String, Object> map = new HashMap<>();
			if (null != studentname && "" != studentname)
			{
				map.put("studentname", studentname);
			}
			if (0 != parentId)
			{
				map.put("pid", null);
			}
			int result0 = rectorService.updateChildrenByPid(map);
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----家长信息----更新对应表格的内容的值
	@RequestMapping("/updateParentTable")
	public void updateParentTable(TblParent tblParent, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//先删除对应的cid的内容
		TblStudent tblStudent = rectorService.selectStudentByStudentId(tblParent.getParentId());

		Map<String, Object> map0 = new HashMap<>();
		map0.put("studentname", tblStudent.getStudentname());
		map0.put("pid", null);
		int result = rectorService.updateChildrenByPid(map0);

		String studentname = request.getParameter("studentname");
		Map<String, Object> map = new HashMap<>();
		if (null != studentname && "" != studentname)
		{
			map.put("studentname", studentname);
		}
		if (0 != tblParent.getParentId())
		{
			map.put("pid", tblParent.getParentId());
		}
		int result1 = rectorService.updateChildrenByPid(map);
		System.out.println("内容是=" + tblParent);
		int result2 = rectorService.updateParentTable(tblParent);
		if (result1 > 0 && result2 > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/*
	 *园所----课程管理--班级管理的查询用的是同一个
	 * */
	//班级信息的显示
	@RequestMapping("/selectCourseManagement")
	public void selectCourseManagement(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String classname = request.getParameter("classname");
		String beginTime = request.getParameter("beginTime");
		String overTime = request.getParameter("overTime");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("班级名是=" + classname);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != classname && "" != classname)
		{
			map.put("classname", classname);
		}
		if (null != beginTime && "" != beginTime)
		{
			map.put("beginTime", beginTime);
		}
		if (null != overTime && "" != overTime)
		{
			map.put("overTime", overTime);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("班级信息=" + map);
		List<TblTeacher> tblTeachers = kinderService.findClassTeacherAll(map);

		System.out.println("班级输出=" + tblTeachers);
		if (0 != tblTeachers.size())
		{
			Integer count = kinderService.findClassTeacherAllCount(map).intValue();
			System.out.println("输出班级次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblTeachers);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");

			//查找对应的教师的班级信息--下拉框的显示
			List<TblTeacher> tblTeacherList = kinderService.findTeacherClassAll();
			System.out.println("请获取班主任的信息：" + tblTeacherList);
			request.getSession().setAttribute("tblTeacherList", tblTeacherList);
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//课程表显示
	@RequestMapping("/showAllCourseId")
	public void showAllCourseId(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		String currentmonday = "1";
		String currentsonday = "7";
		String dafultsid = request.getParameter("classid");
		if(dafultsid!=null&&"" !=dafultsid){
			System.out.println("课程对应的信息：" + dafultsid);

			int classid = Integer.valueOf(dafultsid);

			String startdate = request.getParameter("key1");//周一日期
			String enddate = request.getParameter("key2");//周日日期
			String cid = request.getParameter("key3");//教师ID值
			String mondaydate = null;
			String sundaydate = null;

			Map<String, Object> map = new HashMap<>();
			if (null != startdate && null != enddate)
			{
				mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(startdate));
				sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(enddate));
			} else
			{
				mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(currentmonday));
				sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(currentsonday));
			}
			System.out.println("课程对应的日期时间=" + mondaydate + "~" + sundaydate);
			map.put("mondaydate", mondaydate);
			map.put("sundaydate", sundaydate);
			if (null != cid)
			{
				map.put("cid", Integer.valueOf(cid));
			} else
			{
				map.put("cid", classid);
			}
			List<TblCourse> tblCourseList = kinderService.findAllCourseName(map);
			if (0 != tblCourseList.size())
			{
				dateTable.setCode(0);
				dateTable.setMsg(" ");
				dateTable.setCount(5);
				dateTable.setData(tblCourseList);
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.setCharacterEncoding("UTF-8");
				ResponseUtils.outJson(response, dateTable);
			} else
			{
				dateTable.setCode(201);
				dateTable.setMsg("无数据");
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				response.setCharacterEncoding("UTF-8");
				ResponseUtils.outJson(response, dateTable);
			}
		}else
		{
			System.out.println("输出项目=异常情况");
			dateTable.setCode(201);
			dateTable.setMsg("刷新数据，请关闭后尝试点击配置课程");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//课程表-课程名称的修改
	@RequestMapping("/updateCourseInfo")
	public void updateCourseInfo(TblCourse tblCourse, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		String msg = request.getParameter("TblCourse");
		Gson g = new Gson();
		tblCourse = g.fromJson(msg, TblCourse.class);
		List<TblCourse> tblCourseList = tblCourse.getTblCourseList();
		String cid = null;
		String ctids = null;
		for (int k = 0; k < tblCourseList.size(); k++)
		{
			cid = tblCourseList.get(k).getCid().toString();
			ctids = tblCourseList.get(k).getCtids().toString();
		}
		System.out.println(tblCourse.getCid() + "对应的集合的值是：" + tblCourseList);
		int result = kinderService.delTblCourseInfo(Integer.parseInt(cid), Integer.parseInt(ctids));
		if (result > 0)
		{
			String info = "无";
			for (int i = 0; i < tblCourseList.size(); i++)
			{
				System.out.println("进入到对应的=" + tblCourseList);
				if ("".equals(tblCourseList.get(i).getCoursename1()))
				{
					tblCourseList.get(i).setCoursename1(info);
				}
				if ("".equals(tblCourseList.get(i).getCoursename2()))
				{
					tblCourseList.get(i).setCoursename2(info);
				}
				if ("".equals(tblCourseList.get(i).getCoursename3()))
				{
					tblCourseList.get(i).setCoursename3(info);
				}
				if ("".equals(tblCourseList.get(i).getCoursename4()))
				{
					tblCourseList.get(i).setCoursename4(info);
				}
				if ("".equals(tblCourseList.get(i).getCoursename5()))
				{
					tblCourseList.get(i).setCoursename5(info);
				}
			}

			int result2 = kinderService.addTblCourseInfo(tblCourseList);
			if (result2 > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//课程表-新增对应的额课程表信息
	@RequestMapping("/addCourseInfo")
	public void addCourseInfo(TblCoursetest tblCoursetest, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		String msg = request.getParameter("TblCourse");
		System.out.println("json的值是=" + msg);
		Gson g = new Gson();
		tblCourse = g.fromJson(msg, TblCourse.class);
		//拿对应的集合内容显示
		List<TblCourse> tblCourseList = tblCourse.getTblCourseList();
		int classid = tblCourse.getCid();

		String mealtime = tblCourse.getMondaydate();
		String time1 = null;
		String time2 = null;
		if (mealtime != null)
		{
			String[] arr = mealtime.split("~ ");
			time1 = arr[0];
			time2 = arr[arr.length - 1];
		}
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date mealstarttime = format.parse(time1);
		Date mealendtime = format.parse(time2);

		tblCoursetest.setMondaydate(mealstarttime);
		tblCoursetest.setSundaydate(mealendtime);

		Map<String, Object> map = new HashMap<>();
		map.put("mondaydate", mealstarttime);
		map.put("sundaydate", mealendtime);
		Integer ctid = kinderService.findCoursetestID(map);
		System.out.println("对应的值是=" + ctid);
		if (ctid == 0)
		{
			int result = kinderService.addCoursetestInfo(tblCoursetest);
			ctid = kinderService.findCoursetestID(map);
		}
		String info = "无";
		for (int i = 0; i < tblCourseList.size(); i++)
		{
			tblCourseList.get(i).setCtids(ctid);
			tblCourseList.get(i).setCid(classid);
			if ("".equals(tblCourseList.get(i).getCoursename1()))
			{
				tblCourseList.get(i).setCoursename1(info);
			}
			if ("".equals(tblCourseList.get(i).getCoursename2()))
			{
				tblCourseList.get(i).setCoursename2(info);
			}
			if ("".equals(tblCourseList.get(i).getCoursename3()))
			{
				tblCourseList.get(i).setCoursename3(info);
			}
			if ("".equals(tblCourseList.get(i).getCoursename4()))
			{
				tblCourseList.get(i).setCoursename4(info);
			}
			if ("".equals(tblCourseList.get(i).getCoursename5()))
			{
				tblCourseList.get(i).setCoursename5(info);
			}
		}

		int result2 = kinderService.addTblCourseInfo(tblCourseList);
		if (result2 > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}

	}

	/*
	 * 班级模块--增删改
	 * */
	//班级管理的新增记录内容
	@RequestMapping("/addClassForm")
	protected void addClassForm(TblClass tblClass, String teachername, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		System.out.println("班级的添加信息显示：" + tblClass + teachername);
		tblClass.setClassregtime(new Date());
		int result = kinderService.addClassForm(tblClass);
		if (result > 0)
		{
			TblClass tblClassInfo = kinderService.selectClassByCid(tblClass.getClassname());
			//修改对应的学生表的家长的外键
			Map<String, Object> map = new HashMap<>();
			if (null != teachername && "" != teachername)
			{
				map.put("teachername", teachername);
			}
			if (0 != tblClassInfo.getClassid())
			{
				map.put("cid", tblClassInfo.getClassid());
			}

			int result0 = kinderService.updateTeacherByCid(map);
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//班级信息----删除操作
	@RequestMapping("/delClassTable")
	public void delClassTable(String teachername, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("classid");
		System.out.println("删除servlet" + id);
		int classid = Integer.valueOf(id);

		int result = kinderService.delClassTable(classid);
		if (result > 0)
		{
			//			删除成功对应的家长信息
			Map<String, Object> map = new HashMap<>();
			if (null != teachername && "" != teachername)
			{
				map.put("teachername", teachername);
			}
			if (0 != classid)
			{
				map.put("cid", null);
			}
			int result0 = kinderService.updateTeacherByCid(map);
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//班级信息----更新对应表格值
	@RequestMapping("/updateClassTable")
	public void updateClassTable(TblClass tblClass, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//先删除对应的cid的内容
		TblTeacher tblTeachera = kinderService.selectTeacherByTeacherId(tblClass.getClassid());

		Map<String, Object> map = new HashMap<>();
		map.put("teachername", tblTeachera.getTeachername());
		map.put("cid", null);
		int result0 = kinderService.updateTeacherByCid(map);

		//再进行对应的改变值
		String teachername = request.getParameter("teachername");
		Map<String, Object> map1 = new HashMap<>();
		if (null != teachername && "" != teachername)
		{
			map1.put("teachername", teachername);
		}
		if (0 != tblClass.getClassid())
		{
			map1.put("cid", tblClass.getClassid());
		}
		int result2 = kinderService.updateTeacherByCid(map1);

		System.out.println("内容是=" + tblClass);
		int result = kinderService.updateClassTable(tblClass);
		if (result > 0 && result2 > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//班级成员管理
	@RequestMapping("/selectClassMemberManagement")
	public void selectClassMemberManagement(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String studentname = request.getParameter("studentname");
		String classname = request.getParameter("classname");
		String beginTime = request.getParameter("beginTime");
		String overTime = request.getParameter("overTime");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("班级成员名是=" + studentname + "=" + classname);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != studentname && "" != studentname)
		{
			map.put("studentname", studentname);
		}
		if (null != classname && "" != classname)
		{
			map.put("classname", classname);
		}
		if (null != beginTime && "" != beginTime)
		{
			map.put("beginTime", beginTime);
		}
		if (null != overTime && "" != overTime)
		{
			map.put("overTime", overTime);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("班级成员信息=" + map);
		List<TblScTInfo> tblScTInfoList = kinderService.findClassMemberAll(map);

		System.out.println("班级成员输出=" + tblScTInfoList);
		if (0 != tblScTInfoList.size())
		{
			Integer count = kinderService.findClassMemberAllCount(map).intValue();
			System.out.println("输出班级成员次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblScTInfoList);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");

			//			查找对应的班级的班级信息--下拉框的显示
			List<TblClass> tblClassList = kinderService.findAllClassAll();
			System.out.println("请获取班级的信息：" + tblClassList);
			request.getSession().setAttribute("tblClassList", tblClassList);

			//查找对应的幼儿园的孩子信息--下拉框的显示
			List<TblStudent> tblStudentList = rectorService.findChildrenParentAll();
			System.out.println("请获取孩子的信息：" + tblStudentList);
			request.getSession().setAttribute("tblStudentList", tblStudentList);
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//班级成员管理---新增记录
	@RequestMapping("/addClassMemberForm")
	protected void addClassMemberForm(TblStudent tblStudent, String classname, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		System.out.println("班级成员的添加信息显示：" + tblStudent + classname);
		String studentname = tblStudent.getStudentname();
		TblClass tblClassInfo = kinderService.selectClassByCid(classname);
		//修改对应的学生表的家长的外键
		Map<String, Object> map = new HashMap<>();
		if (null != studentname && "" != studentname)
		{
			map.put("studentname", studentname);
		}
		if (0 != tblClassInfo.getClassid())
		{
			map.put("cid", tblClassInfo.getClassid());
		}

		int result0 = kinderService.updateStudentByCid(map);
		if (result0 > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//班级成员信息----删除操作
	@RequestMapping("/delClassMemberTable")
	public void delClassMemberTable(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//		String id = request.getParameter("studentid");
		System.out.println("删除班级成员=" + tblStudent);
		//		int studentid = Integer.valueOf(id);

		Map<String, Object> map = new HashMap<>();
		if (null != tblStudent.getStudentname() && "" != tblStudent.getStudentname())
		{
			map.put("studentname", tblStudent.getStudentname());
		}
		map.put("cid", null);
		int result0 = kinderService.updateStudentByCid(map);
		if (result0 > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//班级信息----更新对应表格值
	@RequestMapping("/updateClassMemberTable")
	public void updateClassMemberTable(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//先删除对应的cid的内容
		//		TblTeacher tblTeachera = kinderService.selectTeacherByTeacherId(tblStudent.getStudentid());

		//		Map<String, Object> map = new HashMap<>();
		//		map.put("teachername", tblTeachera.getTeachername());
		//		map.put("cid", null);
		//		int result0 = kinderService.updateTeacherByCid(map);
		//再进行对应的改变值
		String classname = request.getParameter("classname");

		TblClass tblClass = kinderService.selectClassByCid(classname);

		Map<String, Object> map1 = new HashMap<>();
		if (null != tblStudent.getStudentname() && "" != tblStudent.getStudentname())
		{
			map1.put("studentname", tblStudent.getStudentname());
		}
		if (0 != tblClass.getClassid())
		{
			map1.put("cid", tblClass.getClassid());
		}
		int result = kinderService.updateStudentByCid(map1);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/*
	 * 校园公告管理
	 * */
	@RequestMapping("/selectCampusBulletin")
	public void selectCampusBulletin(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String campusinfoname = request.getParameter("campusinfoname");
		String beginTime = request.getParameter("beginTime");
		String overTime = request.getParameter("overTime");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("校园公告名是=" + campusinfoname);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != campusinfoname && "" != campusinfoname)
		{
			map.put("campusinfoname", campusinfoname);
		}
		if (null != beginTime && "" != beginTime)
		{
			map.put("beginTime", beginTime);
		}
		if (null != overTime && "" != overTime)
		{
			map.put("overTime", overTime);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("校园公告信息=" + map);
		List<TblCampus> tblCampusinfoList = kinderService.findCampusBulletinAll(map);

		System.out.println("校园公告输出=" + tblCampusinfoList);
		if (0 != tblCampusinfoList.size())
		{
			Integer count = kinderService.findCampusBulletinAllCount(map).intValue();
			System.out.println("输出校园公告次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblCampusinfoList);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//校园公告的增加
	@RequestMapping("/addCampusBulletin")
	protected void addCampusBulletin(TblCampus tblCampus, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		tblCampus.setCampustime(new Date());
		int result = kinderService.addCampusBulletin(tblCampus);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所----幼儿信息进行对应的删除操作delTeacherTable
	@RequestMapping("/delCampusBulletin")
	public void delCampusBulletin(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("campusinfoid");
		System.out.println("删除servlet" + id);
		int campusinfoid = Integer.valueOf(id);

		int result = kinderService.delCampusBulletin(campusinfoid);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----幼儿信息----更新对应表格的内容的值
	@RequestMapping("/updateCampusBulletin")
	public void updateCampusBulletin(TblCampus tblCampus, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String campusinfoid = request.getParameter("campusinfoid");
		System.out.println("内容是=" + campusinfoid);
		int campusinfoids = Integer.valueOf(campusinfoid);
		String campusinfoname = request.getParameter("campusinfoname");
		String campusinfodetail = request.getParameter("campusinfodetail");

		tblCampus.setCampusinfoid(campusinfoids);
		tblCampus.setCampusinfoname(campusinfoname);
		tblCampus.setCampusinfodetail(campusinfodetail);

		System.out.println("校园公告内容是=" + tblCampus);
		int result = kinderService.updateCampusBulletin(tblCampus);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//教师考勤管理--信息查询和显示
	@RequestMapping("/selectTeacherAttendManage")
	public void selectTeacherAttendManage(HttpServletRequest request, HttpServletResponse response) throws ParseException, UnsupportedEncodingException
	{
		//前端传过来的值通过-json里面去查看
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String teachername = request.getParameter("teachername");
		String teacherjob = request.getParameter("teacherjob");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("教师考勤是=" + teachername + "还有" + teacherjob);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != teachername && "" != teachername)
		{
			map.put("teachername", teachername);
		}
		if (null != teacherjob && "" != teacherjob && !teacherjob.equals("暂无"))
		{
			map.put("teacherjob", teacherjob);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("教师考勤信息=" + map);
		List<TblTeacherAttend> tblTeacherAttendList = kinderService.findTeacherAttendAll(map);
		System.out.println("教师考勤输出成功" + tblTeacherAttendList.toString());

		if (0 != tblTeacherAttendList.size())
		{
			Integer count = kinderService.findTeacherAttendAllCount(map).intValue();
			System.out.println("教师考勤输出次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblTeacherAttendList);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//教师详细考勤信息---考勤管理
	@RequestMapping("/showTeacherAttendDetail")
	public void showTeacherAttendDetail(TblTeacherAttend tblTeacherAttend, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		String currentmonday = "1";
		String currentsonday = "7";
		String dafultsid = request.getParameter("tid");

		String startdate = request.getParameter("startdate");//周一日期
		String enddate = request.getParameter("enddate");//周日日期
		String tid = request.getParameter("teacherid");//教师ID值
		String mondaydate = null;
		String sundaydate = null;

		if (null != startdate && null != enddate)
		{
			mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(startdate));
			sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(enddate));
		} else
		{
			mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(currentmonday));
			sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(currentsonday));
		}
		tblTeacherAttend.setTattendbegin(mondaydate);
		tblTeacherAttend.setTattendover(sundaydate);
		if (null != tid)
		{
			tblTeacherAttend.setTid(Integer.valueOf(tid));
		} else
		{
			tblTeacherAttend.setTid(Integer.valueOf(dafultsid));
		}
		List<TblTertime> tblTertimeList = kinderService.findALLTeacherAttendDetail(tblTeacherAttend);

		if (0 != tblTertimeList.size())
		{
			System.out.println("输出的考勤信息是="+tblTertimeList);
			ResponseUtils.outJson(response, tblTertimeList);
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}

	}

	//在线聊天的内容显示
	// 跳转到登录页面
//	@RequestMapping(value = "loginpage", method = RequestMethod.GET)
//	public ModelAndView loginpage()
//	{
//		return new ModelAndView("views/login");
//	}

	// 登录进入聊天主页面
	@RequestMapping(value = "chatLogin", method = RequestMethod.POST)
	public ModelAndView login(User loginUser, HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		// 登录操作
		// 判断是否是一个已经登录的用户，没有则登录
		if (null != session.getAttribute("loginUser"))
		{
			// 清除旧的用户
			session.removeAttribute("loginUser");
		}
		// 新登录，需要构建一个用户
		// 随机生成一个用户
		String id = UUID.randomUUID().toString();
		loginUser.setId(id);
		// 将用户放入session
		session.setAttribute("loginUser", loginUser);

		// 将登录信息放入数据库，便于协查跟踪聊天者
		System.out.println("新用户诞生了：" + loginUser);
		return new ModelAndView("redirect:mainpage");
	}

	// 跳转到聊天室页面
	@RequestMapping(value = "mainpage", method = RequestMethod.GET)
	public ModelAndView mainpage(HttpServletRequest request)
	{
		//判断，如果没有session，则跳到登录页面
		HttpSession session = request.getSession();
		if (null == session.getAttribute("loginUser"))
		{
			return new ModelAndView("directorjsp/chatlogin");
		} else
		{
			return new ModelAndView("directorjsp/chatmain");
		}
	}

	//---------------消息通知的设置
	@RequestMapping("/addInfoType")
	protected void addInfoType(String infotypename,String kindername, TblInfotype tblInfotype,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Integer kid = kinderService.selectkinderByName(kindername);
		tblInfotype.setInfotypetime(new Date());
		tblInfotype.setKid(kid);
		int result = kinderService.addInfoType(tblInfotype);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//查询对应的额消息信息显示
	@RequestMapping("/selectSchoolMessage")
	public void selectSchoolMessage(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//记得在前面要加上对应的园所ID的值

		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String infotypename = request.getParameter("infotypename");
		String beginTime = request.getParameter("beginTime");
		String overTime = request.getParameter("overTime");
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);

		System.out.println("消息通知是=" + infotypename);
		//		获取对应的id值
		Map<String, Object> map = new HashMap<>();
		if (null != infotypename && "" != infotypename)
		{
			map.put("infotypename", infotypename);
		}
		if (null != beginTime && "" != beginTime)
		{
			map.put("beginTime", beginTime);
		}
		if (null != overTime && "" != overTime)
		{
			map.put("overTime", overTime);
		}
		int pages = (pageInt - 1) * limitInt;
		int limits = limitInt;
		map.put("pageInt", pages);
		map.put("limitInt", limits);

		System.out.println("消息通知信息=" + map);
		List<TblInfotype> tblInfotypeList = kinderService.findSchoolMessageAll(map);

		System.out.println("消息通知输出=" + tblInfotypeList);
		if (0 != tblInfotypeList.size())
		{
			Integer count = kinderService.findSchoolMessageAllCount(map).intValue();
			System.out.println("输出消息通知次数：" + count);
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(count);
			dateTable.setData(tblInfotypeList);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

}
