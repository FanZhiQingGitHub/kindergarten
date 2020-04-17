package com.great.kindergarten.teacher.controller;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.teacher.service.TeacherService;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.springframework.boot.system.ApplicationHome;
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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
    private String vcode;
    private TblTeacher tblTeacher1;
    private  int cid;
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

    @RequestMapping("/main")
    public String showMainView(){
        return "mainjsp/main";
    }



    //跳转路径
    @RequestMapping("/toUrl/{url}")
    public String getUrl(@PathVariable(value = "url") String path)
    {
        return "teacherjsp/" + path;
    }

    @RequestMapping("/loginCode")
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

    @RequestMapping("/teacherLogin")
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
                TblClass tblClass = teacherService.findClassAll(cid);

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
    @RequestMapping("/updateTeacherPwd")
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

    //课程表

    @RequestMapping("/courseTable")
    @ResponseBody
    public CourseTable courseTable(HttpServletRequest request, HttpServletResponse response){
        String page=request.getParameter("page");
        String limit=request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt =Integer.valueOf(limit);
        int pageInt=(pageInt1-1)*limitInt;

        List<TblCourse> tblCourseList=new ArrayList<>();

//            查询用户总数
            Integer count=teacherService.findCount();
//            查询用户数据
             tblCourseList = teacherService.findCourse(cid);
            System.out.println("tblCourseList="+tblCourseList);
            if(null!=tblCourseList){
                courseTable.setCode(0);
                courseTable.setMsg("");
                courseTable.setCount(count);
                courseTable.setData(tblCourseList);
                return courseTable;
            }

        return null;
    }
//    查询所有班级
    @RequestMapping("/selectClass")
    @ResponseBody
    public List<TblClass> selectClass(HttpServletRequest request){
        System.out.println("selectClass进来");
        List<TblClass> tblClassList = teacherService.findClassName();

	    request.getSession().setAttribute("tblClassList",tblClassList);
        System.out.println("所有tblClassList="+tblClassList);
            return tblClassList;
    }
	//查找所有安全视频名称
	@RequestMapping("/selectVideoName")
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

//        String classname=request.getParameter("classname");
	    TblClass tblClass =new TblClass();
	    tblClass.setClassname(classname);
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
                //获取当前时间
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                String filetime = df.format(new Date());
                //通过切割文件名，拿到扩展名即 .docx
                String[] arr = filename.split("\\.");
	            System.out.println("arr="+arr);
                String filetype = "." + arr[arr.length - 1];
	            System.out.println("filetype="+filetype);
                Long size = file.getSize();
                Long maxsize = 107374182400L;
                if(size > maxsize) {
                    //            ResponseUtils.outHtml(response, "{\"code\":4, \"msg\":\"\", \"data\":{}}");
                }else {
                    //文件存放位置
                    String path="D:\\java\\IdeaProjects\\kindergarten\\src\\main\\webapp\\workRelease"+ filename;

                    file.transferTo(new File("D:\\java\\IdeaProjects\\kindergarten\\src\\main\\webapp\\workRelease\\"+ filename));
                    //添加数据到数据表
                    tblWorkrelease.setWorkreleasedetail(filename);
                    tblWorkrelease.setWorklocation(path);
                    //            tblWorkrelease.setWorkreleasetime(filetime);
                    tblWorkrelease.setCid(classid);
                    //            保存数据
//                    List<TblWorkrelease> workreleaseList = new ArrayList<>();
//                    workreleaseList.add(tblWorkrelease);
                    System.out.println("tblWorkrelease="+tblWorkrelease);
                    Boolean flag = teacherService.addFileInfo(tblWorkrelease);
                    System.out.println("上传成功="+flag);
                    if(flag){
                        //upload要求返回的数据格式
	                    Map<String, Object> uploadData = new HashMap<String, Object>();
                        //JSONArray data = JSONArray.fromObject(dir.getPath());
                        uploadData.put("code", "0");
                        uploadData.put("msg", "");
                        //将文件路径返回
                        uploadData.put("data", "{\'src\':\'"+path+"\'}");
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
        //        根据cid 查找班级名称信息
        int cid=tblTeacher1.getCid();
        System.out.println("cid="+cid);
//        TblClass tblClass = teacherService.findClassAll(cid);
//        System.out.println("tblClass="+tblClass);

//        request.getSession().setAttribute("classname",tblClass.getClassname());
        //            查询用户总数
        Integer count=teacherService.findWorkCount(cid);
        //            查询用户数据
	    System.out.println("count="+count);
	    //查询班级作业所有信息
	    TblWork tblWork= teacherService.findWork(cid);
	    System.out.println("tblWork="+tblWork);
//	    查看作业表
        List<TblWork>  tblWorkList = teacherService.findWorkTable(tblWork);
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
	public String workScore(String score,Integer sid)
	{
		//打分
		String str=null;
		String sid1 = Integer.toString(sid);
		boolean flag=teacherService.workScore(score,sid1);
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
        //            查询视频总数
        Integer count=teacherService.findSafetyCount();
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

	@RequestMapping("/addSafetyConfig")
	@ResponseBody
	public String addSafetyConfig(HttpServletRequest request){
    	String classname=request.getParameter("classname");
		String safetyvideoname=request.getParameter("safetyvideoname");
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
	@RequestMapping("/SafetyTestQuestion")
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
}
