package com.great.kindergarten.teacher.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.resultbean.DateTable;
import com.great.kindergarten.teacher.resultbean.PickUpInfoDetailPage;

import com.great.kindergarten.teacher.service.TeacherService;
import com.great.kindergarten.util.DateUtil;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.*;

@Controller
@RequestMapping(value="/teacher")
public class TeacherController {
	private String vcode;
	private TblTeacher tblTeacher1;
	private  int cid;
	private TblWork tblWork;
	private  TblClass tblClass;
	//    private TblWorkrelease tblWorkrelease;
	@Resource
	private TeacherService teacherService;
	@Resource
	private TblCourse tblCourse;
	@Resource
	private CourseTable courseTable;
	@Resource
	private TblWorkrelease tblWorkrelease;
	@Resource
	private TblSafetyvideo tblSafetyvideo;
	@Resource
	private TblSafetyConfig tblSafetyConfig;
	//结果集的处理
	@Resource
	DateTable dateTable;
	@Resource
	private TblPhoto tblPhoto;

	@RequestMapping(value="/main")
	public String showMainView(){
		return "mainjsp/main";
	}



	//跳转路径
	@RequestMapping(value="/toUrl/{url}")
	public String getUrl(@PathVariable(value = "url") String path)
	{
		return "teacherjsp/" + path;
	}

	@RequestMapping(value="/loginCode")
	public void cherkCode(HttpServletRequest request, HttpServletResponse response) {
		try {
			int width = 60;
			int height = 30;
			String data = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
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
				g.fillRect(random.nextInt(width), random.nextInt(height), 1, 1);//随机噪音点
			}
			/**3 获得随机数据，并保存session*/
			vcode = builder.toString();
			request.getSession().setAttribute("vcode", vcode);
			//.. 生成图片发送到浏览器 --相当于下载
			ImageIO.write(image, "jpg", response.getOutputStream());
			response.getOutputStream().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/teacherLogin")
	@ResponseBody
	public  String teacherMain(TblTeacher tblTeacher,HttpServletRequest request){
		System.out.println("tblTeacher="+tblTeacher);
		String str=null;
		//        密码加密
		String teacherpwd = MD5Utils.md5(tblTeacher.getTeacherpwd());
		tblTeacher.setTeacherpwd(teacherpwd);
		System.out.println("teacherpwd="+teacherpwd);
		//        获取验证码
		String code = tblTeacher.getCode();
		//        验证码判定是否一致
		Boolean confirm = code.equalsIgnoreCase(vcode);
		System.out.println("验证码是否一致="+confirm);
		if (confirm) {
			//            获取名字查询状态
			System.out.println("教师="+tblTeacher.getTeachername());
			String teacherStatus = teacherService.findTeacherStatus(tblTeacher.getTeachername());
			System.out.println("状态teacherStatus="+teacherStatus);
			if (teacherStatus.equals("启用")){
				System.out.println("登录="+teacherStatus);
				//                登录 获取全部信息
				tblTeacher1 = teacherService.findTeacher(tblTeacher);
				//        根据cid 查找班级名称信息
				cid=tblTeacher1.getCid();
				System.out.println("cid="+cid);
				tblClass = teacherService.findClassAll(cid);

				System.out.println("tblClass="+tblClass);
				List<TblTeacher> tblTeacherList=new ArrayList<>();

				if (null!=tblTeacher1){

					request.getSession().setAttribute("teachername",tblTeacher1.getTeachername());
					//                    存信息到页面显示
					request.getSession().setAttribute("classname",tblClass.getClassname());
					tblTeacherList.add(tblTeacher1);
					System.out.println("tblTeacherList个人信息="+tblTeacherList);
					request.getSession().setAttribute("tblTeacher1",tblTeacher1);
					request.getSession().setAttribute("tblTeacherList",tblTeacherList);

					str="success";
				}else {
					str="error";
				}

			}else {
				str="notmen";
			}

		}else {
			str="codeerror";
		}
		return str;
	}
	//修改密码
	@RequestMapping(value="/updateTeacherPwd")
	@ResponseBody
	public String updateTeacherPwd(String oldTeacherPwd, String teacherPwd, HttpServletRequest request){

		String str=null;
		//        查询旧密码
		String oldTeachererPwd1 = MD5Utils.md5(oldTeacherPwd);//旧密码
		String teacherPwd1 = MD5Utils.md5(teacherPwd);//新密码
		//        根据教师id 查找信息
		int teacherid=tblTeacher1.getTeacherid();
		TblTeacher tblTeacher2 = teacherService.checkPwd(teacherid);
		if(oldTeachererPwd1.equals(tblTeacher2.getTeacherpwd())){
			//            根据id 修改密码
			String teacherid1 = Integer.toString(teacherid);
			Boolean flag=teacherService.updateTeacherPwd(teacherPwd1,teacherid1);
			if(flag){
				str="success";

			}else {
				str="error";
			}
		}else {
			str="sureError";
		}
		return str;
	}

	//本周课程表

	@RequestMapping(value="/thisWeekCourse")
	@ResponseBody
	public DateTable thisWeekCourse(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException
	{
		//根据老师获取班级id
		cid=tblTeacher1.getCid();
		System.out.println("cid="+cid);
		String currentmonday = "1";
		String currentsonday = "7";
		String startdate = request.getParameter("key1");//周一日期
		String enddate = request.getParameter("key2");//周日日期
		String mondaydate = null;
		String sundaydate = null;
		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
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
		dataHashMap.put("mondaydate", mondaydate);
		dataHashMap.put("sundaydate", sundaydate);
		if (0!= cid)
		{
			dataHashMap.put("cid", cid);
		}
		//根据班级id，当前时间查找课程信息
		List<TblCourse> tblCourseList = teacherService.findCourseByTodayCid(dataHashMap);
		if (0 != tblCourseList.size())
		{
			dateTable.setCode(0);
			dateTable.setMsg(" ");
			dateTable.setCount(5);
			dateTable.setData(tblCourseList);
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			//			ResponseUtils.outJson(response, dateTable);
			return dateTable;
		} else
		{
			dateTable.setCode(201);
			dateTable.setMsg("无数据");
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			//			ResponseUtils.outJson(response, dateTable);
			//			return dateTable;
		}

		return dateTable;
	}


	//    查询所有班级
	@RequestMapping(value="/selectClass")
	@ResponseBody
	public List<TblClass> selectClass(HttpServletRequest request){
		System.out.println("selectClass进来");
		List<TblClass> tblClassList = teacherService.findClassName();

		request.getSession().setAttribute("tblClassList",tblClassList);
		System.out.println("所有tblClassList="+tblClassList);
		return tblClassList;
	}
	//查找所有安全视频名称
	@RequestMapping(value="/selectVideoName")
	@ResponseBody
	public List<TblSafetyvideo> selectVideoName(HttpServletRequest request){
		List<TblSafetyvideo> tblSafetyvideoList=teacherService.findVideoName();
		request.getSession().setAttribute("tblSafetyvideoList",tblSafetyvideoList);
		System.out.println("所有tblSafetyvideoList="+tblSafetyvideoList);
		return tblSafetyvideoList;
	}


	//    发布作业

	@RequestMapping(value="/workRelease",produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> workRelease(@RequestParam("file") MultipartFile file,String classname, HttpServletRequest request,HttpServletResponse response){
		TblClass tblClass =new TblClass();
		tblClass.setClassname(classname);
		//查询发布作业表中最后一个id 插入的为id+1
		Integer workreleaseid =teacherService.findFinallyWorkreleaseid();

		if(null!=workreleaseid){
			workreleaseid +=1;
		}else {
			workreleaseid =1;
		}

		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay = df.format(new Date());
		//实际路径
		String path1=  request.getSession().getServletContext().getRealPath("/workRelease/"+classname+"/"+nowDay+"/"+workreleaseid) ;
		System.out.println("path1="+path1);
		System.out.println("classname="+classname);
		try
		{
			//根据班级名查找id
			Integer classid = teacherService.findClassidByName(tblClass);
			System.out.println("下拉框班级="+classname);
			System.out.println("下拉框班级id="+classid);
			//是得到上传时的文件名。
			String filename = file.getOriginalFilename().toString();
			System.out.println("filename="+filename);

			//通过切割文件名，拿到扩展名即 .docx
			String[] arr = filename.split("\\.");
			System.out.println("arr="+arr);
			String filetype = "." + arr[arr.length - 1];
			System.out.println("filetype="+filetype);
			Long size = file.getSize();
			Long maxsize = 107374182400L;
			if(size > maxsize) {
				ResponseUtils.outHtml(response, "文件过大");
			}else {
				// 重命名文件,获取路径
				String path=path1+"/"+filename;
				System.out.println("path="+path);
				//创建文件
				File tempFile=new File(path);
				if(!tempFile.exists()){
					tempFile.mkdirs();
				}
				// 将接收的文件保存到指定文件中
				file.transferTo(tempFile);
				//添加数据到数据表
				tblWorkrelease.setWorkreleasedetail(filename);
				tblWorkrelease.setWorklocation("workRelease@"+classname+"@@"+nowDay+"@@@"+workreleaseid+"@@@@"+filename);

				tblWorkrelease.setCid(classid);
				Boolean flag = teacherService.addFileInfo(tblWorkrelease);
				if(flag){
					//upload要求返回的数据格式
					Map<String, Object> uploadData = new HashMap<String, Object>();
					uploadData.put("code", "0");
					uploadData.put("msg", "");
					//将文件路径返回
					uploadData.put("data", "{}");
					System.out.println(uploadData);
					ResponseUtils.outJson(response,uploadData);
					//                        return uploadData;
				}
			}

		} catch (IOException e)
		{
			e.printStackTrace();
		}


		return null;
	}
	//    查看作业

	@RequestMapping(value="/checkWorkTable")
	@ResponseBody
	public CourseTable checkWorkTable(HttpServletRequest request, HttpServletResponse response){
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		int pageInt1 = Integer.valueOf(page);
		int limitInt =Integer.valueOf(limit);
		int pageInt=(pageInt1-1)*limitInt;
		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
		dataHashMap.put("pageInt",pageInt);
		dataHashMap.put("limitInt",limitInt);
		//        根据cid 查找班级名称信息
		int cid=tblTeacher1.getCid();
		System.out.println("cid="+cid);

		//            查询作业总数
		Integer count=teacherService.findWorkCount(cid);
		dataHashMap.put("cid",cid);
		System.out.println("count="+count);

		//查看作业表
		List<TblWork>  tblWorkList = teacherService.findWorkTable(dataHashMap);
		System.out.println("tblWorkList="+tblWorkList);
		if(null!=tblWorkList){
			courseTable.setCode(0);
			courseTable.setMsg("");
			courseTable.setCount(count);
			courseTable.setData(tblWorkList);
			return courseTable;
		}

		return null;
	}
	//    打分

	@RequestMapping(value="/workScore")
	@ResponseBody
	public String workScore(String score,Integer sid,Integer workreleaseid)
	{
		//打分
		String str=null;
		String sid1 = Integer.toString(sid);
		String workreleaseid1 = Integer.toString(workreleaseid);
		boolean flag=teacherService.workScore(score,sid1,workreleaseid1);
		if(flag){
			str="success";
		}else {
			str="error";
		}

		return str;
	}
	//安全教育配置表
	@RequestMapping(value="/safetyVideoTable")
	@ResponseBody
	public CourseTable safetyVideoTable(HttpServletRequest request, HttpServletResponse response){
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		int pageInt1 = Integer.valueOf(page);
		int limitInt =Integer.valueOf(limit);
		int pageInt=(pageInt1-1)*limitInt;
		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
		dataHashMap.put("pageInt",pageInt);
		dataHashMap.put("limitInt",limitInt);
		dataHashMap.put("cid",cid);
		//            查询视频总数
		Integer count=teacherService.findSafetyCount(dataHashMap);
		System.out.println("count="+count);

		//	    查看视频表
		List<TblSafetyConfig>  tblSafetyConfigList = teacherService.findSafetyTable(dataHashMap);
		System.out.println("tblSafetyConfigList="+tblSafetyConfigList);
		if(null!=tblSafetyConfigList){
			courseTable.setCode(0);
			courseTable.setMsg("");
			courseTable.setCount(count);
			courseTable.setData(tblSafetyConfigList);
			//	        ResponseUtils.outJson(response,courseTable);
			return courseTable;
		}

		return null;
	}
	//上传视频

	@RequestMapping(value="/uploadVideo")
	@ResponseBody
	public Map<String, Object> uploadVideo(@RequestParam("file") MultipartFile file,String classname, HttpServletRequest request,HttpServletResponse response)
	{
		System.out.println("上传视频进来");
		String startDate1=request.getParameter("startDate");
		String endDate1=request.getParameter("endDate");
		//
		System.out.println("startDate="+startDate1);
		System.out.println("endDate="+endDate1);
		//	    String时间格式转化为date
		//创建DateFormat的对象，在构造器中传入跟要转换的String字符串相同格式的
		//	    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate = null;
		Date endDate=null;
		try {
			//转换的过程中可能会抛出ParseException，必须抛出或者捕获处理
			startDate = dateFormat.parse(startDate1);
			endDate = dateFormat.parse(endDate1);

			System.out.println("转换后的startDate类型=" + startDate);
			System.out.println("转换后的endDate类型=" + endDate);
			tblSafetyvideo.setSafetyvideotime(startDate);
			tblSafetyvideo.setSafetyfinishtime(endDate);
			System.out.println("tblSafetyvideo1="+tblSafetyvideo);
		} catch (ParseException e) {}
		try
		{
			//		    String path1  = request.getContextPath();
			String path1 = request.getRealPath("/") ;
			System.out.println("path1="+path1);
			//是得到上传时的文件名。
			String filename = file.getOriginalFilename().toString();
			System.out.println("filename="+filename);
			//		    //获取当前时间
			//		    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			//		    String filetime = df.format(new Date());
			//通过切割文件名，拿到扩展名即 .docx
			String[] arr = filename.split("\\.");
			System.out.println("arr="+arr);
			String filetype = "." + arr[arr.length - 1];
			System.out.println("filetype="+filetype);
			Long size = file.getSize();
			Long maxsize = 107374182400L;
			if(size > maxsize) {
				//            ResponseUtils.outHtml(response, "文件过大");
			}else {
				//文件存放位置
				//			  path1=path1+"Videos/";
				String path=path1+filename;
				System.out.println("path="+path);
				//			    上传文件
				file.transferTo(new File(path));
				//添加数据到数据表
				tblSafetyvideo.setSafetyvideoname(filename);
				tblSafetyvideo.setVideoadd("Videos/"+filename);

				System.out.println("tblSafetyvideo="+tblSafetyvideo);
				Boolean flag = teacherService.uploadVideo(tblSafetyvideo);
				System.out.println("上传成功="+flag);
				if(flag){
					//upload要求返回的数据格式
					Map<String, Object> uploadData = new HashMap<String, Object>();

					uploadData.put("code", "0");
					uploadData.put("msg", "");
					//将文件路径返回
					uploadData.put("data", "{}");
					System.out.println(uploadData);
					ResponseUtils.outJson(response,uploadData);
					//                        return uploadData;
				}
			}

		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	//新增安全教育配置

	@RequestMapping(value="/addSafetyConfig")
	@ResponseBody
	public String addSafetyConfig(HttpServletRequest request){
		String classname=request.getParameter("classname");
		String safetyvideoname=request.getParameter("safetyvideoname");
		String startDate1=request.getParameter("startDate");
		String endDate1=request.getParameter("endDate");
		//
		System.out.println("startDate="+startDate1);
		System.out.println("endDate="+endDate1);
		System.out.println("safetyvideoname="+safetyvideoname);
		//	    String时间格式转化为date
		//创建DateFormat的对象，在构造器中传入跟要转换的String字符串相同格式的
		//	    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate = null;
		Date endDate=null;
		try {
			//转换的过程中可能会抛出ParseException，必须抛出或者捕获处理
			startDate = dateFormat.parse(startDate1);
			endDate = dateFormat.parse(endDate1);

			System.out.println("转换后的startDate类型=" + startDate);
			System.out.println("转换后的endDate类型=" + endDate);
			tblSafetyConfig.setSafetyvideotime(startDate);
			tblSafetyConfig.setSafetyfinishtime(endDate);

		} catch (ParseException e) {}

		//根据班级名查id
		TblClass tblClass =new TblClass();
		tblClass.setClassname(classname);
		System.out.println("classname="+classname);
		//根据班级名查找id
		Integer classid = teacherService.findClassidByName(tblClass);
		System.out.println("下拉框班级id="+classid);
		//根据视频名查id
		tblSafetyvideo.setSafetyvideoname(safetyvideoname);
		Integer safetyvideoid = teacherService.findSafetyvideoidByName(tblSafetyvideo);
		tblSafetyConfig.setSafetyvideoid(safetyvideoid);
		tblSafetyConfig.setClassname(classname);
		tblSafetyConfig.setSafetyvideoname(safetyvideoname);
		tblSafetyConfig.setClassid(classid);
		System.out.println("tblSafetyConfig="+tblSafetyConfig);
		//		新增安全配置
		boolean flag=teacherService.addSafetyConfig(tblSafetyConfig);
		String string=null;
		if(flag){
			string ="success";
		}
		return string;
	}
	//查看配置试题
	@RequestMapping(value="/SafetyTestQuestion")
	public String playVideo(HttpServletRequest request){
		//        获取要做哪套题
		Integer safetyVideoId =  Integer.valueOf(request.getParameter("safetyVideoId"));

		//查询出对应的题目列表
		List<TblSafetyvtq> subject= teacherService.findSafetyTestQuestionList(safetyVideoId);
		//给请求加上题目
		request.setAttribute("subject",subject);
		//转发
		return "parentJsp/SafetyTestQuestion";
	}
	//问题完成情况
	@RequestMapping(value="/questionFinishTable")
	@ResponseBody
	public CourseTable questionFinishTable(HttpServletRequest request, HttpServletResponse response){
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		int pageInt1 = Integer.valueOf(page);
		int limitInt =Integer.valueOf(limit);
		int pageInt=(pageInt1-1)*limitInt;
		//		查询条件
		String startDate = request.getParameter("startDate");//选中日期
		String endDate = request.getParameter("endDate");//选中日期
		String finishStatus = request.getParameter("finishStatus");//完成状态

		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
		if (null != startDate && !"".equals(startDate.trim())) {
			dataHashMap.put("startDate", startDate);
		}
		if (null != endDate && !"".equals(endDate.trim())) {
			dataHashMap.put("endDate", endDate);
		}
		if (null != finishStatus && !"".equals(finishStatus.trim())) {
			dataHashMap.put("finishStatus", finishStatus);
		}
		dataHashMap.put("pageInt",pageInt);
		dataHashMap.put("limitInt",limitInt);
		int cid=tblTeacher1.getCid();
		dataHashMap.put("cid",cid);

		// 查询试题完成情况总数
		Integer count=teacherService.findSafetytqCount(dataHashMap);


		//		查询试题完成情况
		List<TblSafetyFinish>  tblSafetyFinishList = teacherService.findSafetytqTable(dataHashMap);
		System.out.println("tblSafetyFinishList="+tblSafetyFinishList);
		if(null!=tblSafetyFinishList){
			courseTable.setCode(0);
			courseTable.setMsg("");
			courseTable.setCount(count);
			courseTable.setData(tblSafetyFinishList);
			//				        ResponseUtils.outJson(response,courseTable);
			return courseTable;
		}
		return null;
	}
	//班级考勤

	@RequestMapping(value="/classAttendanceTable")
	@ResponseBody
	public CourseTable classAttendanceTable(HttpServletRequest request, HttpServletResponse response){
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		int pageInt1 = Integer.valueOf(page);
		int limitInt =Integer.valueOf(limit);
		int pageInt=(pageInt1-1)*limitInt;
		//		查询条件
		String studentname = request.getParameter("studentname");//学生姓名
		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
		if (null != studentname && !"".equals(studentname.trim())) {
			dataHashMap.put("studentname", studentname);
		}

		dataHashMap.put("pageInt",pageInt);
		dataHashMap.put("limitInt",limitInt);
		//查找班级id
		int cid=tblTeacher1.getCid();
		dataHashMap.put("cid",cid);
		System.out.println("班级考勤1cid="+cid);
		// 根据cid查班级人数
		Integer count=teacherService.findStudentCount(dataHashMap);
		System.out.println("班级考勤1count="+count);

		//		根据cid查班级人员数据
		List<TblStudent>  tblStudentList = teacherService.findStudent(dataHashMap);
		System.out.println("tblStudentList="+tblStudentList);
		if(null!=tblStudentList){
			System.out.println("班级考勤count="+count);
			courseTable.setCode(0);
			courseTable.setMsg("");
			courseTable.setCount(count);
			courseTable.setData(tblStudentList);
			//				        ResponseUtils.outJson(response,courseTable);
			return courseTable;
		}
		return null;
	}
	//学生考勤
	//	孩子详细接送信息，含考勤
	@RequestMapping(value="/showPickUpDetailInfo")
	//	    @ResponseBody
	public void showPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage, DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Gson g = new Gson();
		String currentmonday = "1";
		String currentsonday = "7";
		String dafultsid = request.getParameter("sid");//本周学生id
		String startdate = request.getParameter("startdate");//周一日期
		String enddate = request.getParameter("enddate");//周日日期
		String sid = request.getParameter("studentid");//上下周 学生id

		String mondaydate = null;
		String sundaydate = null;

		if (null != startdate && null != enddate) {
			mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(startdate));
			sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(enddate));
		} else {
			mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(currentmonday));
			sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(currentsonday));
		}
		pickUpInfoDetailPage.setMondaydate(mondaydate);
		pickUpInfoDetailPage.setSundaydate(sundaydate);

		if (null != sid) {
			pickUpInfoDetailPage.setStudentid(Integer.valueOf(sid));
		} else {
			pickUpInfoDetailPage.setStudentid(Integer.valueOf(dafultsid));
		}
		List<TblDate> tblDateList = teacherService.findALLPickUpDetailInfo(pickUpInfoDetailPage);
		if (0 != tblDateList.size()) {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			Object[] info = tblDateList.toArray();
			String result = g.toJson(info);
			response.getWriter().print(result);


		} else {
			response.getWriter().print("error");
		}
	}

	//班级信息
	@RequestMapping(value="/classInfo")
	@ResponseBody
	public CourseTable classInfo(HttpServletRequest request, HttpServletResponse response){
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		int pageInt1 = Integer.valueOf(page);
		int limitInt =Integer.valueOf(limit);
		int pageInt=(pageInt1-1)*limitInt;
		//		查询条件
		String studentname = request.getParameter("studentname");//学生姓名
		String startDate = request.getParameter("startDate");//选中日期
		String endDate = request.getParameter("endDate");//选中日期
		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
		if (null != startDate && !"".equals(startDate.trim())) {
			dataHashMap.put("startDate", startDate);
		}
		if (null != endDate && !"".equals(endDate.trim())) {
			dataHashMap.put("endDate", endDate);
		}

		dataHashMap.put("pageInt",pageInt);
		dataHashMap.put("limitInt",limitInt);
		//查找班级id
		int cid=tblTeacher1.getCid();
		dataHashMap.put("cid",cid);
		System.out.println("班级考勤1cid="+cid);
		// 根据cid查班级人数
		Integer count=teacherService.findStudentCount(dataHashMap);
		System.out.println("班级考勤1count="+count);

		//		根据cid查班级人员数据
		List<TblStudent>  tblStudentList = teacherService.findStudent(dataHashMap);
		System.out.println("tblStudentList="+tblStudentList);
		if(null!=tblStudentList){
			System.out.println("班级考勤count="+count);
			courseTable.setCode(0);
			courseTable.setMsg("");
			courseTable.setCount(count);
			courseTable.setData(tblStudentList);
			//				        ResponseUtils.outJson(response,courseTable);
			return courseTable;
		}
		return null;

	}
	//新增班级相册

	@RequestMapping(value="/addClassPhoto")
	@ResponseBody
	public Map<String, Object> addClassPhoto (@RequestParam("file") MultipartFile file, HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		System.out.println("上传图片进来");

		String className=tblClass.getClassname();
		System.out.println("className="+className);
		String photodetail=request.getParameter("photoDetail");
		System.out.println("photodetail="+photodetail);
		//获取当前时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay = df.format(new Date());
		String path2=  request.getSession().getServletContext().getRealPath("/photos/"+className+"/"+nowDay) ;
		System.out.println("path2="+path2);
		//是得到上传时的文件名。
		String filename = file.getOriginalFilename().toString();
		System.out.println("filename="+filename);
		//		    //获取当前时间
		//通过切割文件名，拿到扩展名即 .docx
		String[] arr = filename.split("\\.");
		System.out.println("arr="+arr);
		String filetype = "." + arr[arr.length - 1];
		System.out.println("filetype="+filetype);
		Long size = file.getSize();
		Long maxsize = 107374182400L;
		if(size > maxsize) {
			ResponseUtils.outHtml(response, "文件过大");
		}

		else {
			// 重命名文件,获取路径
			String path=path2+"/"+filename;
			System.out.println("path="+path);
			//创建文件
			File tempFile=new File(path);
			if(!tempFile.exists()){
				tempFile.mkdirs();
			}
			// 将接收的文件保存到指定文件中
			file.transferTo(tempFile);
			//添加数据到数据表
			tblPhoto.setCid(cid);
			tblPhoto.setPhotodetail(photodetail);
			tblPhoto.setPhotoname(filename);
			tblPhoto.setPhotourl("photos@"+className+"@@"+nowDay+"@@@"+filename);
			System.out.println("tblPhoto"+tblPhoto);

			Boolean flag = teacherService.uploadPhoto(tblPhoto);
			System.out.println("上传成功="+flag);
			Map<String, Object> uploadData = new HashMap<String, Object>();
			if(flag){
				//upload要求返回的数据格式
				uploadData.put("code", "0");
				uploadData.put("msg", "");
				//将文件路径返回
				uploadData.put("data", "{}");
				System.out.println(uploadData);
				ResponseUtils.outJson(response,uploadData);
				//                        return uploadData;
			}
		}
		return null;
	}
	//班级相册

	@RequestMapping(value="/classphoto")
	@ResponseBody
	public CourseTable classphoto(HttpServletRequest request, HttpServletResponse response){
		String page=request.getParameter("page");
		String limit=request.getParameter("limit");
		int pageInt1 = Integer.valueOf(page);
		int limitInt =Integer.valueOf(limit);
		int pageInt=(pageInt1-1)*limitInt;
		//查询条件
		HashMap<String,Object> dataHashMap =new HashMap<>();
		dataHashMap.put("pageInt",pageInt);
		dataHashMap.put("limitInt",limitInt);
		dataHashMap.put("cid",cid);
		//            查询班级相册总数
		Integer count=teacherService.findClassPhotoCount(dataHashMap);
		System.out.println("count="+count);

		//	    查看班级相册数据
		List<TblPhoto>  tblPhotoList = teacherService.findClassPhoto(dataHashMap);
		System.out.println("tblPhotoList="+tblPhotoList);
		if(null!=tblPhotoList){
			courseTable.setCode(0);
			courseTable.setMsg("");
			courseTable.setCount(count);
			courseTable.setData(tblPhotoList);
			//	        ResponseUtils.outJson(response,courseTable);
			return courseTable;
		}

		return null;
	}


}
