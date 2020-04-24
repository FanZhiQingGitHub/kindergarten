package com.great.kindergarten.director.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.annotation.RectorSystemLog;
import com.great.kindergarten.director.resultbean.DateTable;
import com.great.kindergarten.director.resultbean.TblScTInfo;
import com.great.kindergarten.director.service.KinderService;
import com.great.kindergarten.director.service.RectorService;
import com.great.kindergarten.security.annotation.SecuritySystemLog;
import com.great.kindergarten.security.service.SecurityService;
import com.great.kindergarten.util.DateUtil;
import com.great.kindergarten.util.FaceRecognitionUtils;
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
	//	private String vcode;

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
		try
		{
			int width = 60;
			int height = 30;
			//            String data = "QWERTYUOPASDFGHJKLZXCVBNMqwertyuopasdfghjkzxcvbnm023456789";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
			String data = "0000";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
			Random random = new Random();//随机类
			//1 创建图片数据缓存区域（核心类）
			BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);//创建一个彩色的图片
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
				g.fillRect(random.nextInt(width), random.nextInt(height), 1, 1);//随机噪音点
			}
			/**3 获得随机数据，并保存session*/
			String PicCode = builder.toString();
			request.getSession().setAttribute("PicCode", PicCode);
			//.. 生成图片发送到浏览器 --相当于下载
			ImageIO.write(image, "jpg", response.getOutputStream());
			response.getOutputStream().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	//登录判断
	@RectorSystemLog(operationType = "登录", operationName = "园长登录")
	@RequestMapping("/directorLogin")
	public void directorLogin(String username, String userpwd, String code, HttpServletRequest request, HttpServletResponse response)
	{
		tblRector.setRectorname(username);
		String md5pwd = MD5Utils.md5(userpwd);
		System.out.println("密码是：" + md5pwd);
		tblRector.setRectorpwd(md5pwd);

		System.out.println("username="+username);
		System.out.println("userpwd="+userpwd);

		TblRector tblRectors = rectorService.findRector(tblRector);
		System.out.println(tblRectors);
		if (null != tblRectors)
		{
			String rectorstatus = tblRectors.getRectorstatus();
			if (rectorstatus.equals("启用"))
			{
				request.getSession().setAttribute("logintblRector", tblRectors);
				//存这个是因为没有登录，没有用户名，所以需要存一下，记录系统日志
				request.getSession().setAttribute("rectorname", tblRectors.getRectorname());
				String PicCode = (String) request.getSession().getAttribute("PicCode");
				code = code.toLowerCase();
				if (code.equals(PicCode))
				{
					TblKinder tblKinder = rectorService.selectkinderId(tblRectors.getRectorid());
					if (null != tblKinder)
					{
						//查看对应的校园公告内容
						Map<String, Object> map = new HashMap<>();
						map.put("kid", tblKinder.getKinderid());
						map.put("pageInt", 0);
						map.put("limitInt", 5);

						System.out.println("校园公告信息=" + map);
						List<TblCampus> tblCampusinfoList = kinderService.findCampusBulletinAll(map);
						request.getSession().setAttribute("tblCampusList", tblCampusinfoList);
					}
					System.out.println("前台验证码成功！");
					ResponseUtils.outHtml(response, "success");
				} else
				{
					System.out.println("前台验证码失败！");
					ResponseUtils.outHtml(response, "codeerror");
				}
			} else
			{
				System.out.println("前台用户是不是启用！");
				ResponseUtils.outHtml(response, "notmen");
			}
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//查看对应的园所校园公告
	@RequestMapping("/selectCampus")
	public void selectCampus(HttpServletRequest request, HttpServletResponse response)
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			Map<String, Object> map = new HashMap<>();
			map.put("kid", tblKinder.getKinderid());
			map.put("pageInt", 0);
			map.put("limitInt", 5);

			System.out.println("校园公告信息=" + map);
			List<TblCampus> tblCampusinfoList = kinderService.findCampusBulletinAll(map);
			request.getSession().setAttribute("tblCampusList", tblCampusinfoList);
			if (tblCampusinfoList.size() > 0)
			{
				ResponseUtils.outHtml(response, "success");
			} else
			{
				ResponseUtils.outHtml(response, "error");
			}
		}
	}


	//	重置密码--查询是否有对应的用户
	@RequestMapping("/selectresetRectorPwd")
	public void selectresetRectorPwd(String rectorname, HttpServletRequest request, HttpServletResponse response)
	{
		Integer num = rectorService.findExistRectorName(rectorname);
		if (num > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "notmen");
		}
	}


	//	重置密码--进行重置
	@RectorSystemLog(operationType = "重置密码", operationName = "园长重置密码")
	@RequestMapping("/resetRectorPwd")
	public void resetRectorPwd(String rectorname, String rectorphone, HttpServletRequest request, HttpServletResponse response)
	{
		request.getSession().setAttribute("rectorname", rectorname);//存这个是因为没有登录，没有用户名，所以需要存一下，记录系统日志
		boolean result = rectorService.resetRectorPwd(rectorname, rectorphone);
		if (result)
		{
			request.getSession().removeAttribute("rectorname");//重置成功后清除掉
			ResponseUtils.outHtml(response, "success");
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

	//更新密码
	@RectorSystemLog(operationType = "修改密码", operationName = "园长修改密码")
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

	/*
	 * 园所审批--判断名称是不是重复
	 * */
	@RequestMapping("/selectKinderName")
	public void selectKinderName(String kindername, HttpServletRequest request, HttpServletResponse response)
	{
		TblKinder tblKinder = kinderService.selectKinderName(kindername);
		if (null != tblKinder)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	/*
	 * 园所审批--判断账号是不是重复
	 * */
	@RequestMapping("/selectKinderAccount")
	public void selectKinderAccount(String kinderacount, HttpServletRequest request, HttpServletResponse response)
	{
		TblKinder tblKinder = kinderService.selectKinderAccount(kinderacount);
		if (null != tblKinder)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}
	//园所申请审批--判断是不是有对应的园所，如果有就不进入添加
	@RequestMapping("/checkApproval")
	public void checkApproval(String kinderacount, HttpServletRequest request, HttpServletResponse response)
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		if (null == tblKinder)
		{
			System.out.println("没有对应的园所信息");
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所申请审批
	@RectorSystemLog(operationType = "园所申请审批", operationName = "园长申请园所")
	@RequestMapping("/directorReg")
	public void directorReg(TblKinder tblKinder, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		//添加园所所有信息--补充信息
		tblKinder.setKinderstatus("未审批");
		tblKinder.setKinderregtime(new Date());
		String md5pwd = MD5Utils.md5(tblKinder.getKinderpwd());
		tblKinder.setKinderpwd(md5pwd);
		//添加园长的ID到园所
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");
		tblKinder.setRecid(tblR.getRectorid());

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

	//教师管理--信息查询和显示
	@RequestMapping("/selectTeacherManage")
	public void selectTeacherManage(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());
			//前端传过来的值通过-json里面去查看
			String page = request.getParameter("page");
			String limit = request.getParameter("limit");
			String teachername = request.getParameter("teachername");
			int pageInt = Integer.valueOf(page);
			int limitInt = Integer.valueOf(limit);

			System.out.println("教师名是=" + teachername);

			//获取对应的id值
			Map<String, Object> map = new HashMap<>();
			if (null != teachername && "" != teachername)
			{
				map.put("teachername", teachername);
			}
			if (0 != tblKinder.getKinderid())
			{
				map.put("kinderid", tblKinder.getKinderid());
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}

	}

	//园所-----教师信息----进行对应的删除操作
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

	//教师管理--判断修改的教师名是不是重复的名字
	@RequestMapping("/selectTeacherName")
	public void selectTeacherName(String teachername, HttpServletRequest request, HttpServletResponse response)
	{
		TblTeacher tblTeacher = rectorService.selectTeacherName(teachername);
		if (null != tblTeacher)
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
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
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
			tblTeacher.setKinderid(tblKinder.getKinderid());
			tblTeacher.setTeacherstatus("启用");
			tblTeacher.setCid(-1);
			System.out.println("申请教师=" + tblTeacher);
			int result = rectorService.addTeacherForm(tblTeacher);
			if (result > 0)
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

	/*
	 * 幼儿管理
	 * */
	//幼儿信息的显示
	@RequestMapping("/selectChildrenManagement")
	public void selectChildrenManagement(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());
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
			if (0 != tblKinder.getKinderid())
			{
				map.put("kid", tblKinder.getKinderid());
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//幼儿管理--判断修改的幼儿名是不是重复的名字
	@RequestMapping("/selectStudentName")
	public void selectStudentName(String studentname, HttpServletRequest request, HttpServletResponse response)
	{
		TblStudent tblStudent = rectorService.selectStudentName(studentname);
		if (null != tblStudent)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//	幼儿信息的增加
	@RequestMapping("/addChildrenForm")
	protected void addChildrenForm(TblStudent tblStudent, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			tblStudent.setStudenttime(new Date());
			tblStudent.setStudentstatus("启用");
			tblStudent.setStudentlng("118.19320");
			tblStudent.setStudentlat("24.48854");
			tblStudent.setKid(tblKinder.getKinderid());
			tblStudent.setPid(-1);
			tblStudent.setCid(-1);

			int result = rectorService.addChildrenForm(tblStudent);
			if (result > 0)
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

	//园所----幼儿信息进行对应的删除操作
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
		String studentadd = request.getParameter("studentadd");

		tblStudent.setStudentid(studentids);
		tblStudent.setStudentname(studentname);
		tblStudent.setStudentsex(studentsex);
		tblStudent.setStudentbrith(studentbrith);
		tblStudent.setStudentadd(studentadd);

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
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());
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
			map.put("kid", tblKinder.getKinderid());
			int pages = (pageInt - 1) * limitInt;
			int limits = limitInt;
			map.put("pageInt", pages);
			map.put("limitInt", limits);

			System.out.println("家长信息=" + map);

			System.out.println("请获取园所ID：" + tblKinder.getKinderid());
			//查找对应的幼儿园的孩子信息--下拉框的显示
			Map<String, Object> mapStu = new HashMap<>();

//			Integer kid = tblKinder.getKinderid();
			mapStu.put("kid",tblKinder.getKinderid());
			mapStu.put("pid",-1);

			List<TblStudent> tblStudentList = rectorService.findChildrenParentAll(mapStu);
			System.out.println("请获取孩子的信息：" + tblStudentList);
			request.getSession().setAttribute("tblStudentList", tblStudentList);

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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//家长信息--判断修改的家长名是不是重复的名字
	@RequestMapping("/selectParentName")
	public void selectParentName(String parentName, HttpServletRequest request, HttpServletResponse response)
	{
		TblParent tblParent = rectorService.selectParentName(parentName);
		if (null != tblParent)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//	家长信息的增加
	@RequestMapping("/addParentForm")
	protected void addParentForm(TblParent tblParent, String studentname, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
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
			tblParent.setKid(tblKinder.getKinderid());
			tblParent.setKindername(tblKinder.getKindername());
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
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());
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
			map.put("kid", tblKinder.getKinderid());
			int pages = (pageInt - 1) * limitInt;
			int limits = limitInt;
			map.put("pageInt", pages);
			map.put("limitInt", limits);

			System.out.println("班级信息=" + map);

			System.out.println("请获取园所ID：" + tblKinder.getKinderid());
			//查找对应的教师的班级信息--下拉框的显示
			Map<String, Object> mapStu = new HashMap<>();
			mapStu.put("kinderid",tblKinder.getKinderid());
			mapStu.put("cid",-1);
			List<TblTeacher> tblTeacherList = kinderService.findTeacherClassAll(mapStu);
			System.out.println("请获取班主任的信息：" + tblTeacherList);
			request.getSession().setAttribute("tblTeacherList", tblTeacherList);

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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
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
		if (dafultsid != null && "" != dafultsid)
		{
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
		} else
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

	//课程表-新增对应的课程表信息
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
	//判断修改的班级名是不是重复的名字
	@RequestMapping("/selectClassName")
	public void selectClassName(String classname, HttpServletRequest request, HttpServletResponse response)
	{
		TblClass tblClass = kinderService.selectClassName(classname);
		if (null != tblClass)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//班级管理的新增记录内容
	@RequestMapping("/addClassForm")
	protected void addClassForm(TblClass tblClass, String teachername, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			System.out.println("班级的添加信息显示：" + tblClass + teachername);
			tblClass.setClassregtime(new Date());
			tblClass.setKid(tblKinder.getKinderid());
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

	//班级成员管理--查询显示
	@RequestMapping("/selectClassMemberManagement")
	public void selectClassMemberManagement(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());

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
			map.put("kid", tblKinder.getKinderid());
			int pages = (pageInt - 1) * limitInt;
			int limits = limitInt;
			map.put("pageInt", pages);
			map.put("limitInt", limits);

			System.out.println("班级成员信息=" + map);

			//查找对应的班级的班级信息--下拉框的显示
			List<TblClass> tblClassList = kinderService.findAllClassAll(tblKinder.getKinderid());
			System.out.println("请获取班级的信息：" + tblClassList);
			request.getSession().setAttribute("tblClassList", tblClassList);

			//查找对应的幼儿园的孩子信息--下拉框的显示
//			List<TblStudent> tblStudentList = rectorService.findChildrenParentAll(tblKinder.getKinderid());
			Map<String, Object> mapStu = new HashMap<>();

			//			Integer kid = tblKinder.getKinderid();
			mapStu.put("kid",tblKinder.getKinderid());
			mapStu.put("cid",-1);
			List<TblStudent> tblStudentList = rectorService.findChildrenParentAll(mapStu);
			System.out.println("请获取孩子的信息：" + tblStudentList);
			request.getSession().setAttribute("tblStudentList", tblStudentList);

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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
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
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());
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
			map.put("kid", tblKinder.getKinderid());
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
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
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			tblCampus.setCampustime(new Date());
			tblCampus.setKid(tblKinder.getKinderid());
			int result = kinderService.addCampusBulletin(tblCampus);
			if (result > 0)
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

	//校园公告删除
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

	//校园公告-更新对应表格
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
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());

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
			map.put("kid", tblKinder.getKinderid());
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
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
			System.out.println("输出的考勤信息是=" + tblTertimeList);
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
	@RequestMapping("/selectInfoType")
	protected void selectInfoType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindernameInfo", tblKinder.getKindername());
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	@RequestMapping("/addInfoType")
	protected void addInfoType(String infotypename, String kindername, TblInfotype tblInfotype, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		System.out.println("消息添加的时候=" + kindername);
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

	//查询对应的消息信息显示
	@RequestMapping("/selectSchoolMessageMe")
	public void selectSchoolMessageMe(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//记得在前面要加上对应的园所ID的值
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
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
			map.put("kid", tblKinder.getKinderid());
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}
	}

	//不同端的消息显示
	//查询对应的消息信息显示
	@RequestMapping("/selectSchoolMessage")
	public void selectSchoolMessage(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//记得在前面要加上对应的园所ID的值
		//获取到对应的园长ID值
		Integer kid = (Integer) request.getSession().getAttribute("kid");

//		TblKinder tblKinder = rectorService.selectkinderId(kid);

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
			map.put("kid", kid);
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


	//新增教师考勤-------------------------------------------------------------------------------------------
	/*
	 * 对应的教师考勤的新增
	 * 1.日期
        2.当前时间段：如8:30
        3.需要判断是上午还是下午
        4.需要日期区间id（需要添加本周一到本周日）--对应到教师ID
        5.如果下午或上午没打卡的话默认要插入请假或者其它默认数据
	 * */
	@RequestMapping("/addTeaAttendTime")
	public void addTeaAttendTime(TblTeacherAttend tblTeacherAttend, TblTertime tblTertime, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		String face = request.getParameter("face");

		//注册好了之后--进行对应的信息的添加使用
		//		FaceRecognitionUtils.faceRegister(face, "testPhoto1");
		//		System.out.println("face=" + face);

		FaceRecognitionUtils.identify(face, null);

		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式（当天日期）
		String timeamdate = date.format(new Date());
		//本周日期
		String monday = DateUtil.getMondayOfThisWeek(1);
		String sunday = DateUtil.getSundayOfThisWeek(7);
		//查找是不是有对应的教师的ID存在对应的表里面
		//（1）根据教师端登录的时候--获取到对应的教师iD值
		TblTeacher tblTeacher1 = (TblTeacher) request.getSession().getAttribute("tblTeacher1");

		Integer teacherid = tblTeacher1.getTeacherid();
		//（2）查询对应的表里面有没有该字段
		List<TblTeacherAttend> tblTeaAttList = kinderService.findTeaAtteByTid(teacherid);

		Date dt = new Date();
		String today = DateUtil.getWeekOfDate(dt);
		if (today.equals("星期六") && today.equals("星期日"))
		{
			System.out.println("不进行新增考勤");
			ResponseUtils.outHtml(response, "notadd");
		} else
		{
			if (0 == tblTeaAttList.size())
			{ //如果不存在本周一和周日的日期---对应的该时间段的教师id值
				System.out.println("不存在本周一和周日的日期--对应的该时间段的教师id值");
				//				date.parse(monday)
				tblTeacherAttend.setTattendbegin(monday);
				tblTeacherAttend.setTattendover(sunday);
				tblTeacherAttend.setTid(teacherid);
				boolean flagDate = kinderService.addDateTeaAttend(tblTeacherAttend);
				if (flagDate)
				{
					System.out.println("日期区间新增成功");
					addTeaAttendTimeTo(tblTeacherAttend, teacherid, tblTertime, request, response);//新增教师考勤
				} else
				{
					System.out.println("日期区间新增失败");
					ResponseUtils.outHtml(response, "errorinfo");
				}
			} else
			{
				tblTeacherAttend.setTattendover(sunday);
				tblTeacherAttend.setTid(teacherid);
				//对应的要修改时间表的字段值
				boolean flag = kinderService.updateDateTeaAttend(tblTeacherAttend);

				System.out.println("存在本周一和周日的日期--的教师ID的话");

				addTeaAttendTimeTo(tblTeacherAttend, teacherid, tblTertime, request, response);//新增教师考勤
			}
		}
	}

	//添加考勤上下午信息记录对应的方法
	private void addTeaAttendTimeTo(TblTeacherAttend tblTeacherAttend, Integer teacherid, TblTertime tblTertime, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式（当天日期）
		String timePmdate = date.format(new Date());
		System.out.println("方法==新增教师考勤信息id=" + teacherid);
		//获取时间段
		Calendar now = Calendar.getInstance();
		List<TblTeacherAttend> tblTeaAttList = kinderService.findTeaAtteByTid(teacherid);
		Integer dateid = 0;
		for (TblTeacherAttend tblTeaAttend : tblTeaAttList)
		{
			dateid = tblTeaAttend.getTattendid();//教师考勤日期表id
			System.out.println("教师考勤日期区间的id=" + dateid);
		}
		System.out.println("获取当前的时间段是=" + now);
		Integer hh = now.get(Calendar.HOUR_OF_DAY);//获取当前是几点
		Integer mm = now.get(Calendar.MINUTE);//获取当前是几点几分钟
		String hm = null;
		String nmm = null;
		String hmm = null;
		//分钟
		if (mm < 10)
		{
			nmm = "0" + mm;
		} else
		{
			nmm = "" + mm;
		}
		//小时
		if (hh < 10)
		{
			hmm = "0" + hh;
		} else
		{
			hmm = "" + hh;
		}
		hm = hmm + ":" + nmm;
		System.out.println("时间是=" + hm);
		//早上的打卡
		if (hm.compareTo("12:00") < 0)
		{
			//（3）查找上午是否有过添加该字段了-
			// ---如果有的话，就进行对应的修改
			//---没有的话，就进行对应的添加
			Map<String, Object> map = new HashMap<>();
			map.put("tertime", timePmdate);
			map.put("taid", dateid);
			TblTertime tblTertime1 = kinderService.findAfternoon(map);

			if (tblTertime1 == null)
			{
				System.out.println("上午考勤信息中不存在今天的日期");
				//上午打卡的时候同时新增当天日期
				System.out.println("上午打卡的时间段=" + hm);
				tblTertime.setTertime(new Date());
				tblTertime.setTertimedate1(hm);
				tblTertime.setTaid(dateid);
				System.out.println("上午tblTertime1=" + tblTertime);
				boolean flag = kinderService.addAmTerTimeMsg(tblTertime);
				if (flag)
				{
					ResponseUtils.outHtml(response, "amsuccess");
				} else
				{
					ResponseUtils.outHtml(response, "errorinfo");
				}
			} else
			{
				System.out.println("上午考勤表中存在今天的日期");
				System.out.println("今天上午已经打过卡了");
				System.out.println("上午打卡的时间段=" + hm);
				//				tblTertime.setTertime(new Date());
				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(timePmdate));
				tblTertime.setTertimedate1(hm);
				tblTertime.setTaid(dateid);
				System.out.println("上午tblTertime1=" + tblTertime);
				//对应的表字段进行更新
				boolean flagPm = kinderService.updateAmTerTimeMsg(tblTertime);
				System.out.println("判断的boolean=" + flagPm);
				if (flagPm)
				{
					ResponseUtils.outHtml(response, "amsuccess");
				} else
				{
					ResponseUtils.outHtml(response, "errorinfo");
				}
			}
		}
		//中午的打卡
		else if (hm.compareTo("12:00") > 0 && hm.compareTo("13:40") < 0)
		{
			//（2）查找中午是否有过添加该字段了
			// ---如果有的话，就进行对应的修改
			//---没有的话，就进行对应的添加
			Map<String, Object> map = new HashMap<>();
			map.put("tertime", timePmdate);
			map.put("taid", dateid);
			TblTertime tblTertime1 = kinderService.findAfternoon(map);
			System.out.println(timePmdate + "是否有值=" + tblTertime1);
			if (tblTertime1 == null)
			{
				System.out.println("中午考勤信息中不存在今天的日期");
				System.out.println("中午打卡的时间段=" + hm);
				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(timePmdate));
				tblTertime.setNoon("12:01" + hm);
				tblTertime.setTaid(dateid);
				System.out.println("中午tblTertime2=" + tblTertime);
				boolean flag = kinderService.addOmTerTimeMsg(tblTertime);
				if (flag)
				{
					ResponseUtils.outHtml(response, "omsuccess");
				} else
				{
					ResponseUtils.outHtml(response, "errorinfo");
				}
			} else
			{
				System.out.println("中午考勤表中存在今天的日期");
				System.out.println("今天中午已经打过卡了");
				System.out.println("中午打卡的时间段=" + hm);
				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(timePmdate));
				tblTertime.setNoon("12:01" + hm);
				tblTertime.setTaid(dateid);
				System.out.println("中午tblTertime2=" + tblTertime);
				//对应的表字段进行更新
				boolean flagPm = kinderService.updateOmTerTimeMsg(tblTertime);
				if (flagPm)
				{
					ResponseUtils.outHtml(response, "omsuccess");
				} else
				{
					ResponseUtils.outHtml(response, "errorinfo");
				}
			}
		}
		//下午的打卡
		else
		{
			//（3）查找下午是否有过添加该字段了-
			// ---如果有的话，就进行对应的修改
			//---没有的话，就进行对应的添加
			Map<String, Object> map = new HashMap<>();
			map.put("tertime", timePmdate);
			map.put("taid", dateid);
			TblTertime tblTertime1 = kinderService.findAfternoon(map);
			System.out.println(timePmdate + "是否有值=" + tblTertime1);
			if (tblTertime1 == null)
			{
				System.out.println("下午考勤信息中不存在今天的日期");
				System.out.println("下午打卡的时间段=" + hm);
				tblTertime.setTertime(new Date());
				tblTertime.setTertimedate2(hm);
				tblTertime.setTaid(dateid);
				System.out.println("下午tblStutime3=" + tblTertime);
				boolean flag = kinderService.addPmTerTimeMsg(tblTertime);
				if (flag)
				{
					ResponseUtils.outHtml(response, "pmsuccess");
				} else
				{
					ResponseUtils.outHtml(response, "errorinfo");
				}
			} else
			{
				System.out.println("下午考勤表中存在今天的日期");
				System.out.println("今天下午已经打过卡了");
				System.out.println("下午打卡的时间段=" + hm);
				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(timePmdate));
				tblTertime.setTertimedate2(hm);
				tblTertime.setTaid(dateid);
				System.out.println("下午tblTertime3=" + tblTertime);
				//对应的表字段进行更新
				boolean flagPm = kinderService.updatePmTerTimeMsg(tblTertime);
				if (flagPm)
				{
					ResponseUtils.outHtml(response, "pmsuccess");
				} else
				{
					ResponseUtils.outHtml(response, "errorinfo");
				}
			}
		}
	}

	/*
	 * 请假的内容添加
	 * */
	@RequestMapping("/addLeaveManage")
	public void addLeaveManage(TblTeacherAttend tblTeacherAttend, TblTertime tblTertime, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		String leaveDate = request.getParameter("leaveDate");
		String time = request.getParameter("time");
		System.out.println("leaveDate=" + leaveDate);
		System.out.println("time=" + time);

		//		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式（当天日期）
		//		String timeamdate = date.format(new Date());
		//本周日期
		//		String monday = DateUtil.getMondayOfThisWeek(1);
		//		String sunday = DateUtil.getSundayOfThisWeek(7);
		//查找是不是有对应的教师的ID存在对应的表里面
		//（1）根据教师端登录的时候--获取到对应的教师iD值
		TblTeacher tblTeacher1 = (TblTeacher) request.getSession().getAttribute("tblTeacher1");

		Integer teacherid = tblTeacher1.getTeacherid();
		//（2）查询对应的表里面有没有该字段
		List<TblTeacherAttend> tblTeaAttList = kinderService.findTeaAtteByTid(teacherid);

		//		Date dt = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式（当天日期）
		//		String timeamdate = date.format(new Date());
		String today = DateUtil.getWeekOfDate(dateFormat.parse(leaveDate));
		System.out.println("请假是星期几=" + today);

		String date = DateUtil.getMondaySundayByDate(leaveDate);//获取请假日期所在周的周一和周日的日期
		String[] arr = date.split("&");
		String monday = arr[0];//周一
		String sunday = arr[arr.length - 1];//周日

		System.out.println("monday=" + monday);
		System.out.println("sunday=" + sunday);

		if (today.equals("星期六") && today.equals("星期日"))
		{
			System.out.println("周末不需要进行请假");
			ResponseUtils.outHtml(response, "notadd");
		} else
		{
			if (0 == tblTeaAttList.size())
			{ //如果不存在本周一和周日的日期---对应的该时间段的教师id值
				System.out.println("不存在本周一和周日的日期--对应的该时间段的教师id值");
				tblTeacherAttend.setTattendbegin(monday);
				tblTeacherAttend.setTattendover(sunday);
				tblTeacherAttend.setTid(teacherid);
				boolean flagDate = kinderService.addDateTeaAttend(tblTeacherAttend);
				if (flagDate)
				{
					System.out.println("日期区间新增成功");
					addLeaveManageTo(tblTeacherAttend, leaveDate, time, teacherid, tblTertime, request, response);//新增教师考勤
				} else
				{
					System.out.println("日期区间新增失败");
					ResponseUtils.outHtml(response, "errorinfo");
				}
			} else
			{
				tblTeacherAttend.setTattendover(sunday);
				tblTeacherAttend.setTid(teacherid);
				//对应的要修改时间表的字段值
				boolean flag = kinderService.updateDateTeaAttend(tblTeacherAttend);

				System.out.println("存在本周一和周日的日期--的教师ID的话");

				addLeaveManageTo(tblTeacherAttend, leaveDate, time, teacherid, tblTertime, request, response);//新增教师考勤
			}
		}
	}

	//添加请假的考勤上下午信息记录对应的方法
	private void addLeaveManageTo(TblTeacherAttend tblTeacherAttend, String leaveDate, String time, Integer teacherid, TblTertime tblTertime, HttpServletRequest request, HttpServletResponse response) throws ParseException
	{
		System.out.println("方法==新增教师考勤信息id=" + leaveDate + teacherid);
		List<TblTeacherAttend> tblTeaAttList = kinderService.findTeaAtteByTid(teacherid);
		Integer dateid = 0;
		for (TblTeacherAttend tblTeaAttend : tblTeaAttList)
		{
			dateid = tblTeaAttend.getTattendid();//教师考勤日期表id
			System.out.println("教师考勤日期区间的id=" + dateid);
		}
		//判断是不是存在过--该日期的值
		Map<String, Object> map = new HashMap<>();
		map.put("tertime", leaveDate);
		map.put("taid", dateid);
		TblTertime tblTertime1 = kinderService.findAfternoon(map);

		//转换请假的日期格式为date
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		//早上的打卡
		if (time.equals("上午"))
		{
			//（3）查找上午是否有过添加该字段了
			// ---如果有的话，就进行对应的修改
			//---没有的话，就进行对应的添加
			if (tblTertime1 == null)
			{
				System.out.println("上午考勤信息中不存在今天的日期");
				//上午打卡的时候同时新增当天日期
				System.out.println("上午打卡的时间段=" + time);
				//				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(leaveDate));
				tblTertime.setTertimedate1("请假");
				tblTertime.setTaid(dateid);
				System.out.println("上午tblTertime1=" + tblTertime);
				boolean flag = kinderService.addAmTerTimeMsg(tblTertime);
				if (flag)
				{
					ResponseUtils.outHtml(response, "success");
				} else
				{
					ResponseUtils.outHtml(response, "error");
				}
			} else
			{
				System.out.println("上午考勤表中存在今天的日期");
				System.out.println("今天上午已经打过卡了");
				System.out.println("上午打卡的时间段=" + time);
				//如果下午请过假了，上午再请假的话，---默认中午也是请假的过程
				if (tblTertime1.getTertimedate2().equals("请假"))
				{
					//					DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
					tblTertime.setTertime(format1.parse(leaveDate));
					tblTertime.setNoon("请假");
					tblTertime.setTaid(dateid);
					System.out.println("中午tblTertime=" + tblTertime);
					boolean flag = kinderService.updateOmTerTimeMsg(tblTertime);
				}
				//				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(leaveDate));
				tblTertime.setTertimedate1("请假");
				tblTertime.setTaid(dateid);
				System.out.println("上午tblTertime=" + tblTertime);
				//对应的表字段进行更新
				boolean flagPm = kinderService.updateAmTerTimeMsg(tblTertime);
				System.out.println("判断的boolean=" + flagPm);
				if (flagPm)
				{
					ResponseUtils.outHtml(response, "success");
				} else
				{
					ResponseUtils.outHtml(response, "error");
				}
			}
		}
		//下午的打卡
		else
		{
			//（3）查找下午是否有过添加该字段了-
			// ---如果有的话，就进行对应的修改
			//---没有的话，就进行对应的添加
			//			Map<String,Object> map = new HashMap<>();
			//			map.put("tertime",timePmdate);
			//			map.put("taid",dateid);
			//			TblTertime tblTertime1 = kinderService.findAfternoon(map);
			//			System.out.println(timePmdate+"是否有值="+tblTertime1);
			if (tblTertime1 == null)
			{
				System.out.println("下午考勤信息中不存在今天的日期");
				System.out.println("下午打卡的时间段=" + time);
				//			DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(leaveDate));
				tblTertime.setTertimedate2("请假");
				tblTertime.setTaid(dateid);
				System.out.println("下午tblStutime3=" + tblTertime);
				boolean flag = kinderService.addPmTerTimeMsg(tblTertime);
				if (flag)
				{
					ResponseUtils.outHtml(response, "success");
				} else
				{
					ResponseUtils.outHtml(response, "error");
				}
			} else
			{
				System.out.println("下午考勤表中存在今天的日期");
				System.out.println("今天下午已经打过卡了");
				System.out.println("下午打卡的时间段=" + time);
				if (tblTertime1.getTertimedate1().equals("请假"))
				{
					//					DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
					tblTertime.setTertime(format1.parse(leaveDate));
					tblTertime.setNoon("请假");
					tblTertime.setTaid(dateid);
					System.out.println("中午tblTertime2=" + tblTertime);
					boolean flag = kinderService.updateOmTerTimeMsg(tblTertime);
				}
				//			DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
				tblTertime.setTertime(format1.parse(leaveDate));
				tblTertime.setTertimedate2("请假");
				tblTertime.setTaid(dateid);
				System.out.println("下午tblTertime3=" + tblTertime);
				//对应的表字段进行更新
				boolean flagPm = kinderService.updatePmTerTimeMsg(tblTertime);
				if (flagPm)
				{
					ResponseUtils.outHtml(response, "success");
				} else
				{
					ResponseUtils.outHtml(response, "error");
				}
			}
		}
	}



	//	保健员管理--信息查询和显示
	@RequestMapping("/selectHealtherManage")
	public void selectHealtherManage(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());

			//前端传过来的值通过-json里面去查看
			String page = request.getParameter("page");
			String limit = request.getParameter("limit");
			String healthername = request.getParameter("healthername");
			int pageInt = Integer.valueOf(page);
			int limitInt = Integer.valueOf(limit);

			System.out.println("保健员名是=" + healthername);

			//获取对应的id值
			Map<String, Object> map = new HashMap<>();
			if (null != healthername && "" != healthername)
			{
				map.put("healthername", healthername);
			}
			if (0 != tblKinder.getKinderid())
			{
				map.put("kid", tblKinder.getKinderid());
			}
			int pages = (pageInt - 1) * limitInt;
			int limits = limitInt;
			map.put("pageInt", pages);
			map.put("limitInt", limits);

			System.out.println("用户信息=" + map);
			List<TblHealther> tblHealthers = rectorService.findHealtherAll(map);
			System.out.println("输出成功" + tblHealthers.toString());

			if (0 != tblHealthers.size())
			{
				Integer count = rectorService.findHealtherAllCount(map).intValue();
				System.out.println("输出次数：" + count);
				dateTable.setCode(0);
				dateTable.setMsg(" ");
				dateTable.setCount(count);
				dateTable.setData(tblHealthers);
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}

	}

	//园所-----保健员信息----进行对应的删除操作
	@RequestMapping("/delHealtherTable")
	public void delHealtherTable(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("healtherid");
		System.out.println("删除servlet" + id);
		int healtherid = Integer.valueOf(id);

		int result = rectorService.delHealtherTable(healtherid);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//保健员管理--判断修改的保健员是不是重复的名字
	@RequestMapping("/selectHealtherName")
	public void selectHealtherName(String healthername, HttpServletRequest request, HttpServletResponse response)
	{
		TblHealther tblHealther = rectorService.selectHealtherName(healthername);
		if (null != tblHealther)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----保健员信息----更新对应表格的内容的值
	@RequestMapping("/updateHealtherTable")
	public void updateHealtherTable(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String healtherid = request.getParameter("healtherid");
		System.out.println("内容是=" + healtherid);
		int healtherids = Integer.valueOf(healtherid);
		System.out.println("servlet=" + healtherids);
		String healthername = request.getParameter("healthername");

		tblHealther.setHealtherid(healtherids);
		tblHealther.setHealthername(healthername);

		System.out.println("内容是=" + tblHealther);
		int result = rectorService.updateHealtherById(tblHealther);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----保健员信息----添加对应的表格的信息
	@RequestMapping("/addHealtherForm")
	protected void addHealtherForm(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			//使用的密码是默认的密码
			String md5pwd = MD5Utils.md5("123456");
			tblHealther.setHealtherpwd(md5pwd);
			tblHealther.setKid(tblKinder.getKinderid());
			tblHealther.setHealtherstatus("启用");
			tblHealther.setRid(6);
			System.out.println("申请教师=" + tblHealther);
			int result = rectorService.addHealtherForm(tblHealther);
			if (result > 0)
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

	//安防员管理--信息查询和显示
	@RequestMapping("/selectSecurityManage")
	public void selectSecurityManage(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			request.getSession().setAttribute("kindername", tblKinder.getKindername());
			//前端传过来的值通过-json里面去查看
			String page = request.getParameter("page");
			String limit = request.getParameter("limit");
			String securityname = request.getParameter("securityname");
			int pageInt = Integer.valueOf(page);
			int limitInt = Integer.valueOf(limit);

			System.out.println("安防员名是=" + securityname);

			//获取对应的id值
			Map<String, Object> map = new HashMap<>();
			if (null != securityname && "" != securityname)
			{
				map.put("securityname", securityname);
			}
			if (0 != tblKinder.getKinderid())
			{
				map.put("kid", tblKinder.getKinderid());
			}
			int pages = (pageInt - 1) * limitInt;
			int limits = limitInt;
			map.put("pageInt", pages);
			map.put("limitInt", limits);

			System.out.println("用户信息=" + map);
			List<TblSecurity> tblSecurities = rectorService.findSecurityAll(map);
			System.out.println("输出成功" + tblSecurities.toString());

			if (0 != tblSecurities.size())
			{
				Integer count = rectorService.findSecurityAllCount(map).intValue();
				System.out.println("输出次数：" + count);
				dateTable.setCode(0);
				dateTable.setMsg(" ");
				dateTable.setCount(count);
				dateTable.setData(tblSecurities);
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
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("该账户未申请园所或未通过审批，请先操作后再进入!!!");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			ResponseUtils.outJson(response, dateTable);
		}

	}

	//园所-----安防员信息----进行对应的删除操作
	@RequestMapping("/delSecurityTable")
	public void delSecurityTable(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String id = request.getParameter("securityid");
		System.out.println("删除servlet" + id);
		int securityid = Integer.valueOf(id);

		int result = rectorService.delSecurityTable(securityid);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//安防员管理--判断修改的安防员名是不是重复的名字
	@RequestMapping("/selectSecurityName")
	public void selectSecurityName(String securityname, HttpServletRequest request, HttpServletResponse response)
	{
		TblSecurity tblSecurity = rectorService.selectSecurityName(securityname);
		if (null != tblSecurity)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----安防员信息----更新对应表格的内容的值
	@RequestMapping("/updateSecurityTable")
	public void updateSecurityTable(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String securityid = request.getParameter("securityid");
		System.out.println("内容是=" + securityid);
		int securityids = Integer.valueOf(securityid);
		System.out.println("servlet=" + securityids);
		String securityname = request.getParameter("securityname");
		tblSecurity.setSecurityid(securityids);
		tblSecurity.setSecurityname(securityname);

		System.out.println("内容是=" + tblSecurity);
		int result = rectorService.updateSecurityById(tblSecurity);
		if (result > 0)
		{
			ResponseUtils.outHtml(response, "success");
		} else
		{
			ResponseUtils.outHtml(response, "error");
		}
	}

	//园所-----安防员信息----添加对应的表格的信息
	@RequestMapping("/addSecurityForm")
	protected void addSecurityForm(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//获取到对应的园长ID值
		TblRector tblR = (TblRector) request.getSession().getAttribute("logintblRector");

		TblKinder tblKinder = rectorService.selectkinderId(tblR.getRectorid());
		//判断是不是有对应的园所
		if (null != tblKinder && tblKinder.getKinderstatus().equals("通过"))
		{
			//使用的密码是默认的密码
			String md5pwd = MD5Utils.md5("123456");
			tblSecurity.setSecuritypwd(md5pwd);
			tblSecurity.setKid(tblKinder.getKinderid());
			tblSecurity.setSecuritystatus("启用");
			tblSecurity.setRid(5);
			System.out.println("申请安防员=" + tblSecurity);
			int result = rectorService.addSecurityForm(tblSecurity);
			if (result > 0)
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

}
