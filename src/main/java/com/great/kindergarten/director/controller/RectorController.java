package com.great.kindergarten.director.controller;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.resultbean.DateTable;
import com.great.kindergarten.director.service.KinderService;
import com.great.kindergarten.director.service.RectorService;
import com.great.kindergarten.healther.resultbean.DateWrite;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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
import java.text.ParseException;
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
	TblRector tblRector;

	@Resource
	TblKinder tblKinder;
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
		System.out.println("进来这个方法里面=========================");
		//BufferedImage将图片存入缓存中，有三个构造方法，此处的三个参数为图片的宽，高，以及创建的图像类型。
		BufferedImage bi = new BufferedImage(68, 22, BufferedImage.TYPE_INT_RGB);
		//为bi创建图形上下文
		Graphics g = bi.getGraphics();
		//设置颜色，此处调用的构造方法是基于RGB数值作为参数的
		Color c = new Color(237, 230, 194);
		//设置颜色
		g.setColor(c);
		//该方法用于填充指定的矩形，参数是坐标和宽高
		g.fillRect(0, 0, 68, 22);

		//编写随机获取验证码的部分

		//将字符串转换为字符数组
		char[] ch = "abcdefghjklmnopqrstuvwxyz023456789".toCharArray();
		//随机类，在本程序中只使用了 int nextInt(int n) 方法，作用是生成一个0-n的伪随机int值
		Random r = new Random();

		int len = ch.length, index;

		//给图中绘制噪音点，让图片不那么好辨别
		for (int j = 0, n = r.nextInt(100); j < n; j++)
		{
			g.setColor(Color.RED);
			g.fillRect(r.nextInt(68), r.nextInt(22), 1, 1);//随机噪音点
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
			request.getSession().setAttribute("logintblRector", tblRectors);
			String PicCode = (String) request.getSession().getAttribute("PicCode");
			code = code.toLowerCase();
			if (code.equals(PicCode))
			{
				System.out.println("前台验证码成功！");
				ResponseUtils.outHtml(response, "success");
			} else
			{
				System.out.println("前台验证码失败！");
				ResponseUtils.outHtml(response, "codeerror");
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
		}
	}

	//园所-----教师信息进行对应的删除操作delTeacherTable
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
			ResponseUtils.outHtml(response, "删除成功");
		} else
		{
			ResponseUtils.outHtml(response, "删除失败");
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

		tblTeacher.setTeacherid(teacherids);
		tblTeacher.setTeachername(teachername);
		tblTeacher.setTeacherjob(teacherjob);


		System.out.println("内容是=" + tblTeacher);
		int result = rectorService.updateTeacherById(tblTeacher);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "更新成功");
		} else
		{
			ResponseUtils.outHtml(response, "更新失败");
		}
	}


	//添加对应的表格的信息
	@RequestMapping("/addTeacherForm")
	protected void addTeacherForm(TblTeacher tblTeacher, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		int result = rectorService.addTeacherForm(tblTeacher);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "新增教师成功");
		} else
		{
			ResponseUtils.outHtml(response, "新增教师失败");
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
			ResponseUtils.outHtml(response, "新增宝宝成功");
		} else
		{
			ResponseUtils.outHtml(response, "新增宝宝失败");
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
			ResponseUtils.outHtml(response, "删除宝宝资料成功");
		} else
		{
			ResponseUtils.outHtml(response, "删除宝宝资料失败");
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
			ResponseUtils.outHtml(response, "更新宝宝成功");
		} else
		{
			ResponseUtils.outHtml(response, "更新宝宝失败");
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
			//			request.getSession().setAttribute("cName", cName);
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
			if (0!=tblParentByPid.getParentId())
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

}
