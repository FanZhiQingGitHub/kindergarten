package com.great.kindergarten.teacher.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.director.resultbean.DateTable;
import com.great.kindergarten.director.service.KinderService;
import com.great.kindergarten.teacher.annotation.TeacherSystemLog;
import com.great.kindergarten.teacher.resultbean.PickUpInfoDetailPage;
import com.great.kindergarten.teacher.service.TeacherService;
import com.great.kindergarten.util.DateUtil;
import com.great.kindergarten.util.FaceRecognitionUtils;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.*;

@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {
//    private String vcode;
//    private TblTeacher tblTeacher1;
//    private int cid;
    private TblWork tblWork;
//    private TblClass tblClass;
//    private int kid;

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
    @Resource
    private TblClamsg tblClamsg;
    @Resource
    private KinderService kinderService;



    @RequestMapping(value = "/main")
    public String showMainView() {
        return "mainjsp/main";
    }


    //跳转路径
    @RequestMapping(value = "/toUrl/{url}")
    public String getUrl(@PathVariable(value = "url") String path) {
        return "teacherjsp/" + path;
    }


    //	重置密码--查询是否有对应的用户
    @RequestMapping("/selectresetTeacherPwd")
    public void selectresetTeacherPwd(String teachername, HttpServletRequest request, HttpServletResponse response) {
        Integer num = teacherService.findExistTeacherName(teachername);
        if (num > 0) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "notmen");
        }
    }

    //重置密码
    @TeacherSystemLog(operationType = "重置密码", operationName = "老师重置密码")
    @RequestMapping("/resetTeacherpwd")
    public void resetTeacherpwd(HttpServletRequest request, HttpServletResponse response) {
        String teachername = request.getParameter("teachername");
        String teacherphone = request.getParameter("teacherphone");
        request.getSession().setAttribute("teachername", teachername);//存这个是因为没有登录，没有用户名，所以需要存一下，记录系统日志
        Boolean flag = teacherService.resetTeacherpwd(teachername, teacherphone);
        if (flag) {
            request.getSession().removeAttribute("teachername");//重置成功后清除掉
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }


    @RequestMapping(value = "/loginCode")
    public void cherkCode(HttpServletRequest request, HttpServletResponse response) {
        try {
            int width = 60;
            int height = 30;
            String data = "QWERTYUIOPASDFGHJKZXCVBNMqwertyuiopasdfghjkzxcvbnm0123456789";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
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
            String vcode = builder.toString();
            request.getSession().setAttribute("vcode", vcode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    //登录

    @TeacherSystemLog(operationType = "登录", operationName = "教师登录")
    @RequestMapping(value = "/teacherLogin")
    @ResponseBody
    public String teacherMain(TblTeacher tblTeacher, HttpServletRequest request) {
        String str = null;
        //        密码加密
        String teacherpwd = MD5Utils.md5(tblTeacher.getTeacherpwd());
        tblTeacher.setTeacherpwd(teacherpwd);
        //        获取验证码
        String code = tblTeacher.getCode();
        //        验证码判定是否一致
        String vcode=(String)request.getSession().getAttribute("vcode");
        Boolean confirm = code.equalsIgnoreCase(vcode);
        if (confirm) {
            //  获取名字查询状态
            String teacherStatus = teacherService.findTeacherStatus(tblTeacher.getTeachername());
            if (teacherStatus.equals("启用")) {
                // 登录 获取全部信息
               TblTeacher tblTeacher1 = teacherService.findTeacher(tblTeacher);
                // 根据cid 查找班级名称信息
                int cid = tblTeacher1.getCid();
                int kid=tblTeacher1.getKinderid();
                TblClass tblClass = teacherService.findClassAll(cid);
                List<TblTeacher> tblTeacherList = new ArrayList<>();
                TblKinder tblKinder = teacherService.findkinderNameByKid(kid);
                String kinderName=tblKinder.getKindername();

                if (null != tblTeacher1) {
                    //查找园所动态news
                    List<TblCampus> tblCampusList = teacherService.findKinderNews(tblTeacher1.getKinderid());
                    request.getSession().setAttribute("tblCampusList", tblCampusList);
                    request.getSession().setAttribute("kid", kid);

                    request.getSession().setAttribute("kindername", kinderName);
                    request.getSession().setAttribute("teachername", tblTeacher.getTeachername());
                    // 存信息到页面显示
                    request.getSession().setAttribute("classname", tblClass.getClassname());
                    tblTeacherList.add(tblTeacher1);
                    request.getSession().setAttribute("tblTeacher", tblTeacher1);
                    request.getSession().setAttribute("tblTeacherList", tblTeacherList);

                    str = "success";
//					return "teacherjsp/teacherMain";
                } else {
                    str = "error";
                }

            } else {
                str = "notmen";
            }

        } else {
            str = "codeerror";
        }
        System.out.println("str=" + str);
        return str;
    }

    //退出登录
    @RequestMapping(value = "/teacherOut")
    public String teacherOut(HttpServletRequest request) {
//		消除session信息
//		HttpSession session = request.getSession();
//		session.invalidate();
        request.getSession().removeAttribute("teachername");
        return "teacherjsp/teacherLogin";
    }


    //修改密码
    @TeacherSystemLog(operationType = "修改", operationName = "老师修改密码")
    @RequestMapping(value = "/updateTeacherPwd")
    @ResponseBody
    public String updateTeacherPwd(String oldTeacherPwd, String teacherPwd, HttpServletRequest request) {

        String str = null;
        //        查询旧密码
        String oldTeachererPwd1 = MD5Utils.md5(oldTeacherPwd);//旧密码
        String teacherPwd1 = MD5Utils.md5(teacherPwd);//新密码
        //        根据教师id 查找信息
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int teacherid = tblTeacher1.getTeacherid();
        TblTeacher tblTeacher2 = teacherService.checkPwd(teacherid);
        //判断旧密码是否一致
        if (oldTeachererPwd1.equals(tblTeacher2.getTeacherpwd())) {
            //根据id 修改密码
            String teacherid1 = Integer.toString(teacherid);
            Boolean flag = teacherService.updateTeacherPwd(teacherPwd1, teacherid1);
            if (flag) {
                str = "success";

            } else {
                str = "error";
            }
        } else {
            str = "sureError";
        }
        return str;
    }

    //本周课程表

    @RequestMapping(value = "/thisWeekCourse")
    @ResponseBody
    public DateTable thisWeekCourse(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        //根据老师获取班级id
       TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();
        System.out.println("cid=" + cid);
        String currentmonday = "1";
        String currentsonday = "7";
        String startdate = request.getParameter("key1");//周一日期
        String enddate = request.getParameter("key2");//周日日期
        String mondaydate = null;
        String sundaydate = null;
        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        if (null != startdate && null != enddate) {
            mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(startdate));
            sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(enddate));
        } else {
            mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(currentmonday));
            sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(currentsonday));
        }
        System.out.println("课程对应的日期时间=" + mondaydate + "~" + sundaydate);
        dataHashMap.put("mondaydate", mondaydate);
        dataHashMap.put("sundaydate", sundaydate);
        if (0 != cid) {
            dataHashMap.put("cid", cid);
        }
        //根据班级id，当前时间查找课程信息
        List<TblCourse> tblCourseList = teacherService.findCourseByTodayCid(dataHashMap);
        if (0 != tblCourseList.size()) {
            dateTable.setCode(0);
            dateTable.setMsg(" ");
            dateTable.setCount(5);
            dateTable.setData(tblCourseList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            //			ResponseUtils.outJson(response, dateTable);
            return dateTable;
        } else {
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
    @RequestMapping(value = "/selectClass")
    @ResponseBody
    public List<TblClass> selectClass(HttpServletRequest request) {
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();
        System.out.println("selectClass进来cid=" + cid);

        List<TblClass> tblClassList = teacherService.findClassName(cid);

        request.getSession().setAttribute("tblClassList", tblClassList);
        System.out.println("所有tblClassList=" + tblClassList);
        return tblClassList;
    }

    //查找所有安全视频名称
    @RequestMapping(value = "/selectVideoName")
    @ResponseBody
    public List<TblSafetyvideo> selectVideoName(HttpServletRequest request) {
        List<TblSafetyvideo> tblSafetyvideoList = teacherService.findVideoName();
        request.getSession().setAttribute("tblSafetyvideoList", tblSafetyvideoList);
        System.out.println("所有tblSafetyvideoList=" + tblSafetyvideoList);
        return tblSafetyvideoList;
    }


    //    发布作业
    @TeacherSystemLog(operationType = "增加", operationName = "老师发布作业")
    @RequestMapping(value = "/workRelease", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public Map<String, Object> workRelease(@RequestParam("file") MultipartFile file, String classname, HttpServletRequest request, HttpServletResponse response) {
        TblClass tblClass = new TblClass();
        OutputStream os = null;
        InputStream inputStream = null;
        String fileName = null;
        String filePath = null;

        tblClass.setClassname(classname);
        System.out.println("发布作业classname="+classname);
        //查询发布作业表中最后一个id 插入的为id+1
        Integer workreleaseid = teacherService.findFinallyWorkreleaseid();

        if (null != workreleaseid) {
            workreleaseid += 1;
        } else {
            workreleaseid = 1;
        }

        //获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String nowDay = df.format(new Date());
        //实际路径
        String path = request.getServletContext().getRealPath("/workRelease/" + classname + "/" + nowDay + "/" + workreleaseid);


            try {
                //根据班级名查找id
                Integer classid = teacherService.findClassidByName(tblClass);
                //判断班级不为空的情况下
                if(classid==null){
                    //upload要求返回的数据格式
                    Map<String, Object> uploadData = new HashMap<String, Object>(5);
                    uploadData.put("code", "1");
                    uploadData.put("msg", "");
                    //将文件路径返回
                    uploadData.put("data", "{}");
                    System.out.println(uploadData);
                    ResponseUtils.outJson(response, uploadData);

            }else {

                    Long size = file.getSize();
                    Long maxsize = 107374182400L;
                    if (size > maxsize) {
                        ResponseUtils.outHtml(response, "文件过大");
                    } else {
                        //读取文件   输入流
                        inputStream = file.getInputStream();
                        fileName = file.getOriginalFilename();

                        // 2、保存到临时文件
                        // 1K的数据缓冲
                        byte[] bs = new byte[1024];
                        // 读取到的数据长度
                        int len;
                        // 输出的文件流保存到本地文件

                        File tempFile = new File(path);
                        //目录不存在会创建
                        if (!tempFile.exists()) {
                            tempFile.mkdirs();
                        }

                        filePath = tempFile.getPath() + File.separator + fileName;
                        //发布作业的为输出流
                        os = new FileOutputStream(filePath);
                        // 开始读取
                        while ((len = inputStream.read(bs)) != -1) {
                            os.write(bs, 0, len);
                        }
                        //添加数据到数据表
                        tblWorkrelease.setWorkreleasedetail(fileName);
                        tblWorkrelease.setWorklocation("workRelease@" + classname + "@@" + nowDay + "@@@" + workreleaseid + "@@@@" + fileName);

                        tblWorkrelease.setCid(classid);
                        Boolean flag = teacherService.addFileInfo(tblWorkrelease);
                        if (flag) {
                            //upload要求返回的数据格式
                            Map<String, Object> uploadData = new HashMap<String, Object>(5);
                            uploadData.put("code", "0");
                            uploadData.put("msg", "");
                            //将文件路径返回
                            uploadData.put("data", "{}");
                            System.out.println(uploadData);
                            ResponseUtils.outJson(response, uploadData);
                            //                        return uploadData;
                        }
                    }

                }
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
            // 完毕，关闭所有链接
            try {
                os.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


        return null;
    }
    //    查看作业

    @RequestMapping(value = "/checkWorkTable")
    @ResponseBody
    public CourseTable checkWorkTable(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);
        int pageInt = (pageInt1 - 1) * limitInt;
        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        dataHashMap.put("pageInt", pageInt);
        dataHashMap.put("limitInt", limitInt);
        //        根据cid 查找班级名称信息
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");

        int cid = tblTeacher1.getCid();
        System.out.println("cid=" + cid);

        //            查询作业总数
        Integer count = teacherService.findWorkCount(cid);
        dataHashMap.put("cid", cid);
        System.out.println("count=" + count);

        //查看作业表
        List<TblWork> tblWorkList = teacherService.findWorkTable(dataHashMap);
        System.out.println("tblWorkList=" + tblWorkList);
        if (null != tblWorkList) {
            courseTable.setCode(0);
            courseTable.setMsg("");
            courseTable.setCount(count);
            courseTable.setData(tblWorkList);
            return courseTable;
        }

        return null;
    }

    //下载作业
//	@RequestMapping(value = "/download")
//	@ResponseBody
//	public Map<String,Object> downloadOne(HttpServletRequest req,HttpServletResponse response) throws IOException{
//        //获取数据库里文件的路径
//		String fileName = req.getParameter("workUrl");// 设置文件名，根据业务需要替换成要下载的文件名
//		//分隔符获取路径
//		String pack = fileName.split("@")[0];
//		String workreleaseid = fileName.split("@@")[0].split("@")[1];
//		String dayTime = fileName.split("@@@")[0].split("@@")[1];
//		String downFileName = fileName.split("@@@")[1];
//		//获取文件的实际路径
//		String databasePath =  pack + "/" + workreleaseid + "/" + dayTime + "/" +downFileName ;
//
//
//
//
//		String downloadDir = req.getSession().getServletContext().getRealPath("/");
//		//        String savePath = req.getSession().getServletContext().getRealPath("/") +"download/";
//		downloadDir=downloadDir.substring(0,downloadDir.length()-1);
////		downloadDir=downloadDir+"\\";//下载目录
//		String realPath=downloadDir+databasePath;//
//		File file = new File(realPath);//下载目录加文件名拼接成realpath
//		if(file.exists()){ //判断文件父目录是否存在
//			response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
//
//			byte[] buffer = new byte[1024];
//			FileInputStream fis = null; //文件输入流
//			BufferedInputStream bis = null;
//
//			OutputStream os = null; //输出流
//			try {
//				os = response.getOutputStream();
//				fis = new FileInputStream(file);
//				bis = new BufferedInputStream(fis);
//				int i = bis.read(buffer);
//				while(i != -1){
//					os.write(buffer);
//					i = bis.read(buffer);
//				}
//
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			System.out.println("----------file download" + fileName);
//			try {
//				bis.close();
//				fis.close();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//
//
//		return api.returnJson(2,"fail"+realPath+fileName);
//	}
    //下载作业
    @RequestMapping("/download")
    @ResponseBody
    public ResponseEntity<byte[]> download(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取数据库里文件的路径
        String url = request.getParameter("workUrl");

        //分隔符获取路径
        String pack = url.split("@")[0];
        String workReleaseId = url.split("@@")[0].split("@")[1];
        String dayTime = url.split("@@@")[0].split("@@")[1];
        String downFileName = url.split("@@@")[1];
        //获取文件的实际路径
        String databasePath = "/" + pack + "/" + workReleaseId + "/" + dayTime + "/" + downFileName;

        //得到要下载的文件 路径
        String path = request.getServletContext().getRealPath(databasePath);
        System.out.println("path=" + path);

        File file = new File(path);

        //设置文件下载头
        HttpHeaders headers = new HttpHeaders();

        //为了解决中文名称乱码问题
        String fileName = new String(file.getName().getBytes("UTF-8"), "iso-8859-1");
        System.out.println("fileName=" + fileName);
        // 文件的属性，也就是文件叫什么
        headers.setContentDispositionFormData("attachment", fileName);
        // 内容是字节流
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        System.out.println("headers=" + headers);
        // 开始下载
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.CREATED);
    }


    //    打分

    @RequestMapping(value = "/workScore")
    @ResponseBody
    public String workScore(String score, Integer sid, Integer workreleaseid) {
        //打分
        String str = null;
        String sid1 = Integer.toString(sid);
        String workreleaseid1 = Integer.toString(workreleaseid);
        boolean flag = teacherService.workScore(score, sid1, workreleaseid1);
        if (flag) {
            str = "success";
        } else {
            str = "error";
        }

        return str;
    }

    //安全教育配置表
    @RequestMapping(value = "/safetyVideoTable")
    @ResponseBody
    public CourseTable safetyVideoTable(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);
        int pageInt = (pageInt1 - 1) * limitInt;
        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        dataHashMap.put("pageInt", pageInt);
        dataHashMap.put("limitInt", limitInt);
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid=tblTeacher1.getCid();
        dataHashMap.put("cid", cid);
        //            查询视频总数
        Integer count = teacherService.findSafetyCount(dataHashMap);
        System.out.println("count=" + count);

        //	    查看视频表
        List<TblSafetyConfig> tblSafetyConfigList = teacherService.findSafetyTable(dataHashMap);
        System.out.println("tblSafetyConfigList=" + tblSafetyConfigList);
        if (null != tblSafetyConfigList) {
            courseTable.setCode(0);
            courseTable.setMsg("");
            courseTable.setCount(count);
            courseTable.setData(tblSafetyConfigList);
            //	        ResponseUtils.outJson(response,courseTable);
            return courseTable;
        }

        return null;
    }

//	//上传视频
//	@RequestMapping(value="/uploadVideo")
//	@ResponseBody
//	public Map<String, Object> uploadVideo(@RequestParam("file") MultipartFile file,String classname, HttpServletRequest request,HttpServletResponse response)
//	{
//		System.out.println("上传视频进来");
//		String startDate1=request.getParameter("startDate");
//		String endDate1=request.getParameter("endDate");
//		//
//		System.out.println("startDate="+startDate1);
//		System.out.println("endDate="+endDate1);
//		//	    String时间格式转化为date
//		//创建DateFormat的对象，在构造器中传入跟要转换的String字符串相同格式的
//		//	    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		Date startDate = null;
//		Date endDate=null;
//		try {
//			//转换的过程中可能会抛出ParseException，必须抛出或者捕获处理
//			startDate = dateFormat.parse(startDate1);
//			endDate = dateFormat.parse(endDate1);
//
//			System.out.println("转换后的startDate类型=" + startDate);
//			System.out.println("转换后的endDate类型=" + endDate);
//			tblSafetyvideo.setSafetyvideotime(startDate);
//			tblSafetyvideo.setSafetyfinishtime(endDate);
//			System.out.println("tblSafetyvideo1="+tblSafetyvideo);
//		} catch (ParseException e) {}
//		try
//		{
//			//		    String path1  = request.getContextPath();
//			String path1 = request.getSession().getServletContext().getRealPath("/") ;
//			System.out.println("path1="+path1);
//			//是得到上传时的文件名。
//			String filename = file.getOriginalFilename().toString();
//			System.out.println("filename="+filename);
//			//		    //获取当前时间
//			//		    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//			//		    String filetime = df.format(new Date());
//			//通过切割文件名，拿到扩展名即 .docx
//			String[] arr = filename.split("\\.");
//			System.out.println("arr="+arr);
//			String filetype = "." + arr[arr.length - 1];
//			System.out.println("filetype="+filetype);
//			Long size = file.getSize();
//			Long maxsize = 107374182400L;
//			if(size > maxsize) {
//				//            ResponseUtils.outHtml(response, "文件过大");
//			}else {
//				//文件存放位置
//				//			  path1=path1+"Videos/";
//				String path=path1+filename;
//				System.out.println("path="+path);
//				//			    上传文件
//				file.transferTo(new File(path));
//				//添加数据到数据表
//				tblSafetyvideo.setSafetyvideoname(filename);
//				tblSafetyvideo.setVideoadd("Videos/"+filename);
//
//				System.out.println("tblSafetyvideo="+tblSafetyvideo);
//				Boolean flag = teacherService.uploadVideo(tblSafetyvideo);
//				System.out.println("上传成功="+flag);
//				if(flag){
//					//upload要求返回的数据格式
//					Map<String, Object> uploadData = new HashMap<String, Object>();
//
//					uploadData.put("code", "0");
//					uploadData.put("msg", "");
//					//将文件路径返回
//					uploadData.put("data", "{}");
//					System.out.println(uploadData);
//					ResponseUtils.outJson(response,uploadData);
//					//                        return uploadData;
//				}
//			}
//
//		} catch (IOException e)
//		{
//			e.printStackTrace();
//		}
//		return null;
//	}

    //新增安全教育配置
    @TeacherSystemLog(operationType = "增加", operationName = "新增安全教育配置")
    @RequestMapping(value = "/addSafetyConfig")
    @ResponseBody
    public String addSafetyConfig(HttpServletRequest request) {
        String classname = request.getParameter("classname");
        String safetyvideoname = request.getParameter("safetyvideoname");
        String startDate1 = request.getParameter("startDate");
        String endDate1 = request.getParameter("endDate");
        //
        System.out.println("startDate=" + startDate1);
        System.out.println("endDate=" + endDate1);
        System.out.println("safetyvideoname=" + safetyvideoname);
        //	    String时间格式转化为date
        //创建DateFormat的对象，在构造器中传入跟要转换的String字符串相同格式的
        //	    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date startDate = null;
        Date endDate = null;
        try {
            //转换的过程中可能会抛出ParseException，必须抛出或者捕获处理
            startDate = dateFormat.parse(startDate1);
            endDate = dateFormat.parse(endDate1);

            System.out.println("转换后的startDate类型=" + startDate);
            System.out.println("转换后的endDate类型=" + endDate);
            tblSafetyConfig.setSafetyvideotime(startDate);
            tblSafetyConfig.setSafetyfinishtime(endDate);

        } catch (ParseException e) {
        }

        //根据班级名查id
        TblClass tblClass = new TblClass();
        tblClass.setClassname(classname);
        System.out.println("classname=" + classname);
        //根据班级名查找id
        Integer classid = teacherService.findClassidByName(tblClass);
        System.out.println("下拉框班级id=" + classid);
        //根据视频名查id
        tblSafetyvideo.setSafetyvideoname(safetyvideoname);
        Integer safetyvideoid = teacherService.findSafetyvideoidByName(tblSafetyvideo);
        tblSafetyConfig.setSafetyvideoid(safetyvideoid);
        tblSafetyConfig.setClassname(classname);
        tblSafetyConfig.setSafetyvideoname(safetyvideoname);
        tblSafetyConfig.setClassid(classid);
        System.out.println("tblSafetyConfig=" + tblSafetyConfig);
        //		新增安全配置
        boolean flag = teacherService.addSafetyConfig(tblSafetyConfig);
        String string = null;
        if (flag) {
            string = "success";
        }
        return string;
    }

    //查看配置试题
    @RequestMapping(value = "/SafetyTestQuestion")
    public String playVideo(HttpServletRequest request) {
        //        获取要做哪套题
        Integer safetyVideoId = Integer.valueOf(request.getParameter("safetyVideoId"));

        //查询出对应的题目列表
        List<TblSafetyvtq> subject = teacherService.findSafetyTestQuestionList(safetyVideoId);
        //给请求加上题目
        request.setAttribute("subject", subject);
        //转发
        return "teacherjsp/SafetyTestQuestion";
    }

    //问题完成情况
    @RequestMapping(value = "/questionFinishTable")
    @ResponseBody
    public CourseTable questionFinishTable(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);
        int pageInt = (pageInt1 - 1) * limitInt;
        //		查询条件
        String startDate = request.getParameter("startDate");//选中日期
        String endDate = request.getParameter("endDate");//选中日期
        String finishStatus = request.getParameter("finishStatus");//完成状态

        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        if (null != startDate && !"".equals(startDate.trim())) {
            dataHashMap.put("startDate", startDate);
        }
        if (null != endDate && !"".equals(endDate.trim())) {
            dataHashMap.put("endDate", endDate);
        }
        if (null != finishStatus && !"".equals(finishStatus.trim())) {
            dataHashMap.put("finishStatus", finishStatus);
            System.out.println("选择完成状态=" + finishStatus);
        }
        dataHashMap.put("pageInt", pageInt);
        dataHashMap.put("limitInt", limitInt);
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();

        dataHashMap.put("cid", cid);

        // 查询试题完成情况总数
        Integer count = teacherService.findSafetytqCount(dataHashMap);


        //		查询试题完成情况
        List<TblSafetyFinish> tblSafetyFinishList = teacherService.findSafetytqTable(dataHashMap);
        System.out.println("tblSafetyFinishList=" + tblSafetyFinishList);
        if (null != tblSafetyFinishList) {
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
    @RequestMapping(value = "/classAttendanceTable")
    @ResponseBody
    public CourseTable classAttendanceTable(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);
        int pageInt = (pageInt1 - 1) * limitInt;
        //		查询条件
        String studentname = request.getParameter("studentname");//学生姓名
        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        if (null != studentname && !"".equals(studentname.trim())) {
            dataHashMap.put("studentname", studentname);
        }
        dataHashMap.put("pageInt", pageInt);
        dataHashMap.put("limitInt", limitInt);
        //查找班级id
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();

        dataHashMap.put("cid", cid);
        System.out.println("班级考勤1cid=" + cid);
        // 根据cid查班级人数
        Integer count = teacherService.findStudentCount(dataHashMap);
        System.out.println("班级考勤1count=" + count);

        //		根据cid查班级人员数据
        List<TblStudent> tblStudentList = teacherService.findStudent(dataHashMap);
        System.out.println("tblStudentList=" + tblStudentList);
        if (null != tblStudentList) {
            System.out.println("班级考勤count=" + count);
            courseTable.setCode(0);
            courseTable.setMsg("");
            courseTable.setCount(count);
            courseTable.setData(tblStudentList);
            //				        ResponseUtils.outJson(response,courseTable);
            return courseTable;
        }
        return null;
    }
    //显示学生考勤页面

    @RequestMapping(value = "/studentAttendance")
    public String studentAttendance(HttpServletRequest request) {
        System.out.println("学生考勤进去");
//		获取学生id
        String studentid = request.getParameter("studentid");//本周学生id
        System.out.println("studentid1=" + studentid);
        //对学生考勤页面隐藏input 赋值

        request.getSession().setAttribute("studentid", studentid);
        //转发
        return "teacherjsp/studentAttendance";
    }

    //学生考勤
    //	孩子详细接送信息，含考勤
    @RequestMapping(value = "/showPickUpDetailInfo")
    //	    @ResponseBody
    public void showPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Gson g = new Gson();
        String currentmonday = "1";
        String currentsonday = "7";

//		String dafultsid = request.getParameter("studentid");//本周学生id
        String startdate = request.getParameter("startdate");//周一日期
        String enddate = request.getParameter("enddate");//周日日期
        String sid = request.getParameter("studentid");//上下周 学生id
        System.out.println("学生考勤学生id=" + sid);
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
        }
        //		else {
//			pickUpInfoDetailPage.setStudentid(Integer.valueOf(dafultsid));
//		}
//
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
    @RequestMapping(value = "/classInfo")
    @ResponseBody
    public CourseTable classInfo(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);
        int pageInt = (pageInt1 - 1) * limitInt;
        //		查询条件
        String studentname = request.getParameter("studentname");//学生姓名
        String startDate = request.getParameter("startDate");//选中日期
        String endDate = request.getParameter("endDate");//选中日期
        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        if (null != startDate && !"".equals(startDate.trim())) {
            dataHashMap.put("startDate", startDate);
        }
        if (null != endDate && !"".equals(endDate.trim())) {
            dataHashMap.put("endDate", endDate);
        }

        dataHashMap.put("pageInt", pageInt);
        dataHashMap.put("limitInt", limitInt);
        //查找班级id
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");

        int cid = tblTeacher1.getCid();
        dataHashMap.put("cid", cid);
        System.out.println("班级考勤1cid=" + cid);
        // 根据cid查班级人数
        Integer count = teacherService.findStudentCount(dataHashMap);
        System.out.println("班级考勤1count=" + count);

        //		根据cid查班级人员数据
        List<TblStudent> tblStudentList = teacherService.findStudent(dataHashMap);
        System.out.println("tblStudentList=" + tblStudentList);
        if (null != tblStudentList) {
            System.out.println("班级考勤count=" + count);
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
    @TeacherSystemLog(operationType = "增加", operationName = "新增班级相册")
    @RequestMapping(value = "/addClassPhoto")
    @ResponseBody
    public Map<String, Object> addClassPhoto(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {

        OutputStream os = null;
        InputStream inputStream = null;
        String fileName = null;
        String filePath = null;



        System.out.println("上传图片进来");
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();
        TblClass tblClass = teacherService.findClassAll(cid);
        String className = tblClass.getClassname();
        System.out.println("className=" + className);
        String photodetail = request.getParameter("photoDetail");
        System.out.println("photodetail=" + photodetail);
        //获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String nowDay = df.format(new Date());
//        获取真实路径
        filePath = request.getServletContext().getRealPath("/photos/" + className + "/" + nowDay);
        Long size = file.getSize();
        Long maxsize = 107374182400L;
        if (size > maxsize) {
            ResponseUtils.outHtml(response, "文件过大");
        } else {

            inputStream = file.getInputStream();
            fileName = file.getOriginalFilename();
            // 2、保存到临时文件
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流保存到本地文件
            File tempFile = new File(filePath);
            //目录不存在会创建
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            filePath = tempFile.getPath() + File.separator + fileName;
            os = new FileOutputStream(filePath);
            // 开始读取
            while ((len = inputStream.read(bs)) != -1) {
                os.write(bs, 0, len);
            }






            //添加数据到数据表
            tblPhoto.setCid(cid);
            tblPhoto.setPhotodetail(photodetail);
            tblPhoto.setPhotoname(fileName);
            tblPhoto.setPhotourl("photos/" + className + "/" + nowDay + "/" + fileName);
            System.out.println("tblPhoto" + tblPhoto);

            Boolean flag = teacherService.uploadPhoto(tblPhoto);
            System.out.println("上传成功=" + flag);
            Map<String, Object> uploadData = new HashMap<String, Object>();
            if (flag) {
                //upload要求返回的数据格式
                uploadData.put("code", "0");
                uploadData.put("msg", "");
                //将文件路径返回
                uploadData.put("data", "{}");
                System.out.println(uploadData);
                ResponseUtils.outJson(response, uploadData);
                //                        return uploadData;
            }
        }
        return null;
    }
    //班级相册

    @RequestMapping(value = "/classphoto")
    @ResponseBody
    public CourseTable classphoto(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        int pageInt1 = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);
        int pageInt = (pageInt1 - 1) * limitInt;
        //查询条件
        HashMap<String, Object> dataHashMap = new HashMap<>();
        dataHashMap.put("pageInt", pageInt);
        dataHashMap.put("limitInt", limitInt);
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();

        dataHashMap.put("cid", cid);
        //            查询班级相册总数
        Integer count = teacherService.findClassPhotoCount(dataHashMap);
        System.out.println("count=" + count);

        //	    查看班级相册数据
        List<TblPhoto> tblPhotoList = teacherService.findClassPhoto(dataHashMap);
        System.out.println("tblPhotoList=" + tblPhotoList);
        if (null != tblPhotoList) {
            courseTable.setCode(0);
            courseTable.setMsg("");
            courseTable.setCount(count);
            courseTable.setData(tblPhotoList);
            //	        ResponseUtils.outJson(response,courseTable);
            return courseTable;
        }

        return null;
    }

    //班级通知
    @TeacherSystemLog(operationType = "增加", operationName = "新增班级通知")
    @RequestMapping(value = "/addClassMsg")
    @ResponseBody
    public String addClassMsg(HttpServletRequest request) {
        //获取通知消息内容
        String claMsgDetail = request.getParameter("claMsgDetail");
        //添加数据
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");
        int cid = tblTeacher1.getCid();

        tblClamsg.setCid(cid);
        tblClamsg.setClamsgdetail(claMsgDetail);
        tblClamsg.setSendmsgtime(new Date());
        boolean flag = teacherService.addClassMsg(tblClamsg);
        String str = null;
        if (flag) {
            str = "success";
        } else {
            str = "error";
        }
        return str;

    }

    @RequestMapping("/regFaceId")
    @ResponseBody
    public Result regFaceId(HttpServletRequest request, HttpServletResponse response) {
        //注册人脸方法
        Result result = new Result();

        String face = request.getParameter("face");

        //获取信息
        TblTeacher tblTeacher = (TblTeacher) request.getSession().getAttribute("tblTeacher");
        //String name
        if (FaceRecognitionUtils.faceRegister(face, "t" + tblTeacher.getTeacherid())) {
            result.setSuccess(true);
        }

        return result;
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


        //获取信息
        TblTeacher tblTeacher = (TblTeacher) request.getSession().getAttribute("tblTeacher");

        //注册好了之后--进行对应的信息的添加使用
        //		FaceRecognitionUtils.faceRegister(face, "testPhoto1");
        //		System.out.println("face=" + face);

        if (tblTeacher!=null){

            //人脸识别成功
            if (FaceRecognitionUtils.identify(face,"t"+tblTeacher.getTeacherid())){

                SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式（当天日期）
                String timeamdate = date.format(new Date());
                //本周日期
                String monday = DateUtil.getMondayOfThisWeek(1);
                String sunday = DateUtil.getSundayOfThisWeek(7);
                //查找是不是有对应的教师的ID存在对应的表里面
                //（1）根据教师端登录的时候--获取到对应的教师iD值
                TblTeacher tblTeacher1 = (TblTeacher) request.getSession().getAttribute("tblTeacher");

                Integer teacherid = tblTeacher1.getTeacherid();
                //（2）查询对应的表里面有没有该字段
                List<TblTeacherAttend> tblTeaAttList = kinderService.findTeaAtteByTid(teacherid);

                Date dt = new Date();
                String today = DateUtil.getWeekOfDate(dt);
                if (today.equals("星期六") || today.equals("星期日"))
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

            }else {
                //人脸识别失败
                ResponseUtils.outHtml(response, "failure");
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
        TblTeacher tblTeacher1 = (TblTeacher) request.getSession().getAttribute("tblTeacher");

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

        if (today.equals("星期六") || today.equals("星期日"))
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
    //班级消息通知
    @RequestMapping("/classMessage")

    public void classMessage(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        //记得在前面要加上对应的园所ID的值
        //获取到对应的园长ID值
        TblTeacher tblTeacher1= (TblTeacher)request.getSession().getAttribute("tblTeacher");


        Integer cid = tblTeacher1.getCid();
        System.out.println("cid="+cid);
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");
        String clamsgdetail = request.getParameter("clamsgdetail");
        String beginTime = request.getParameter("beginTime");
        String overTime = request.getParameter("overTime");
        int pageInt = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);

        System.out.println("消息通知是=" + clamsgdetail);
        //		获取对应的id值
        Map<String, Object> map = new HashMap<>();
        if (null != clamsgdetail && "" != clamsgdetail)
        {
            map.put("clamsgdetail", clamsgdetail);
        }
        if (null != beginTime && "" != beginTime)
        {
            map.put("beginTime", beginTime);
        }
        if (null != overTime && "" != overTime)
        {
            map.put("overTime", overTime);
        }
        map.put("cid", cid);
        int pages = (pageInt - 1) * limitInt;
        int limits = limitInt;
        map.put("pageInt", pages);
        map.put("limitInt", limits);

        System.out.println("班级消息通知信息=" + map);
        List<TblClamsg> tblClamsgList = teacherService.findClassMessageAll(map);

        System.out.println("消息通知输出=" + tblClamsgList);
        if (0 != tblClamsgList.size())
        {
            Integer count = teacherService.findClassMessageAllCount(map).intValue();
            System.out.println("输出消息通知次数：" + count);
            dateTable.setCode(0);
            dateTable.setMsg(" ");
            dateTable.setCount(count);
            dateTable.setData(tblClamsgList);
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
