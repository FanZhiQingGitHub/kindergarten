package com.great.kindergarten.parent.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.MealPage;
import com.great.kindergarten.parent.annotation.ParentSystemLog;
import com.great.kindergarten.parent.service.ParentService;
import com.great.kindergarten.security.resultbean.MonitorPage;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import com.great.kindergarten.security.service.SecurityService;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/parent")
public class ParentController {

    private String parentname;

    //考勤新增用
    //获取今天的日期
    String timeamdate = null;
    //当前时间段
    String ct = null;
    //上午打卡时间段
    String timeam = null;
    //下午打卡时间段
    String timepm = null;
    //查是否存在当前周的日期区间
    Boolean flagDate = null;
    //上午考勤新增
    Boolean flagAm = null;
    //下午考勤新增
    Boolean flagPm = null;
    //日期区间id
    Integer dateid = null;
    //学生id
    Integer studentid = null;
    //星期一的日期
    String monday = null;
    //星期二的日期
    String sunday = null;
    //今天是星期几
    String today = null;

    @Resource
    private ParentService parentService;
    @Resource
    private SecurityService securityService;


    @RequestMapping("/toUrl/{url}")
    public String toUrl(@PathVariable String url, HttpServletRequest request) {
        return "parentJsp/" + url;
    }





    @RequestMapping("/findCampusBulletinAll")
    @ResponseBody
    public TableDate findCampusBulletinAll(HttpServletRequest request){

        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        //数据解析
        String campusinfoname = request.getParameter("campusinfoname");
        String beginTime = request.getParameter("beginTime");
        String overTime = request.getParameter("overTime");
        String page = request.getParameter("page");
        String limit = request.getParameter("limit");

        int pageInt = Integer.valueOf(page);
        int limitInt = Integer.valueOf(limit);

        Map<String, Object> map = new HashMap<>();

        if (null != overTime && "" != overTime)
        {
            map.put("overTime", overTime);
        }
        if (null != beginTime && "" != beginTime)
        {
            map.put("beginTime", beginTime);
        }

        if (null != campusinfoname && "" != campusinfoname)
        {
            map.put("campusinfoname", campusinfoname);
        }

        map.put("kid", parent.getKid());
        int pages = (pageInt - 1) * limitInt;
        int limits = limitInt;
        map.put("pageInt", pages);
        map.put("limitInt", limits);
        //数据查询返回
        return parentService.findCampusBulletinAll(map);
    }












    //重置密码
    @RequestMapping("/resetParentpwd")
    public void resetParentpwd(HttpServletRequest request, HttpServletResponse response) {
        String parentname = request.getParameter("parentname");
        String parentphone = request.getParameter("parentphone");
        request.getSession().setAttribute("parentname",parentname);//存这个是因为没有登录，没有用户名，所以需要存一下，记录系统日志
        Integer num = parentService.findExistParentName(parentname);
        if(num > 0){
            Boolean flag = parentService.resetParentpwd(parentname,parentphone);
            if(flag){
                request.getSession().removeAttribute("parentname");//重置成功后清除掉
                ResponseUtils.outHtml(response,"success");
            }else {
                ResponseUtils.outHtml(response,"error");
            }
        }else {
            ResponseUtils.outHtml(response,"notmen");
        }
    }


    @RequestMapping("/showMonitorInfo")
    public void showMonitorInfo(DateWrite dateWrite, MonitorPage monitorPage, HttpServletRequest request, HttpServletResponse response) throws Exception {
        //显示幼儿园直播列表

        //取得是谁要进行操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        Integer limit = Integer.valueOf(request.getParameter("limit"));

        Integer page = Integer.valueOf(request.getParameter("page"));


        Integer maxpage = limit;
        Integer minpage = (page - 1) * limit;

        monitorPage.setLimit(maxpage);
        monitorPage.setPage(minpage);
        monitorPage.setKindername(parent.getKindername());


        List<TblMonitor> tblMonitorList = securityService.findALLMonitorInfo(monitorPage);
        if (0 != tblMonitorList.size()) {
            Integer count = securityService.findALLMonitorInfoCount(monitorPage).intValue();
            dateWrite.setMsg(" ");
            dateWrite.setCode(0);
            dateWrite.setCount(count);
            dateWrite.setData(tblMonitorList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            if(parent.getKindername() == null){
                dateWrite.setMsg("亲，您需要登录幼儿园账号后才可以查看该信息！");
            }else {
                dateWrite.setMsg("亲，暂无相关数据！");
            }
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }
    }

    @RequestMapping("/findPhotosByCid")
    @ResponseBody
    public TableDate findPhotosByCid(SearchCondition searchCondition){
        //根据根据班级id找到相册信息
        //返回查找的结果
        return parentService.findPhotosByCid(searchCondition);
    }



    @RequestMapping("/readBook")
	@ResponseBody
	public PageBean<TblReadmag> readBook(HttpServletRequest request){
        //获取要读的页面还有哪本书
          Integer readId = Integer.valueOf(request.getParameter("readId"))  ;
        Integer page  = Integer.valueOf(request.getParameter("nowPage"));
            //数据返回

		return parentService.readBook(readId,page);
	}



    @RequestMapping("/findReadList")
    public String findReadList(HttpServletRequest request){

        //当前页码
        Integer curPage=null;
        //判断是否有当前页码
        if(request.getParameter("curPage")!=null)
        {
            curPage= Integer.valueOf(request.getParameter("curPage"));
        }else {
            curPage=1;
        }

        PageBean<TblReadmag> pageBean =parentService.findReadList(curPage,10);

        request.setAttribute("pageBean",pageBean);

        return "parentJsp/ParentChildReading";
    }




    @RequestMapping("/findExaminationByStudentId")
    @ResponseBody
    public TableDate findExaminationByStudentId(SearchCondition searchCondition){
        //根据学生id找到体检信息
        //返回查找的结果
        return parentService.findExaminationByStudentId(searchCondition);
    }





    @RequestMapping("/findRecipeInfo")
    @ResponseBody
    public TableDate findRecipeInfo(String mealId){
        //找到食谱信息并返回
        Integer id = Integer.valueOf(mealId);
        //返回查找的结果
        return parentService.findRecipeInfo(id);
    }




    @RequestMapping("/findAllMealInfo")
    @ResponseBody
    public TableDate findAllMealInfo(SearchCondition searchCondition , HttpServletRequest request){
        //找到所有的食谱
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        searchCondition.setName(parent.getKid()+"");
        //返回查找的结果
        return parentService.findAllMealInfo(searchCondition);
    }



    @RequestMapping("/showPickUpDetailInfo")
    @ResponseBody
    public void showPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Gson g = new Gson();
        String currentmonday = "1";
        String currentsonday = "7";
        String dafultsid = request.getParameter("sid");
        String startdate = request.getParameter("startdate");//周一日期
        String enddate = request.getParameter("enddate");//周日日期
        String sid = request.getParameter("studentid");//学生id

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

        List<TblStutime> tblDateList = parentService.findPickUpDetailInfo(pickUpInfoDetailPage);

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


    @RequestMapping("/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置下载的文件名
        String url = request.getParameter("url");

        String pack = url.split("@")[0];

        String className = url.split("@@")[0].split("@")[1];

        String dayTime = url.split("@@@")[0].split("@@")[1];

        String id = url.split("@@@@")[0].split("@@@")[1];

        String downFileName = url.split("@@@@")[1];

        //获取文件的实际路径
        String databasePath = "/" + pack + "/" + className + "/" + dayTime  +"/" + id+"/" +downFileName ;


        //路径
        //得到要下载的文件
        File file = new File(request.getServletContext().getRealPath(databasePath));
        HttpHeaders headers = new HttpHeaders();
        //设置文件下载头
        //为了解决中文名称乱码问题
        String fileName = new String(file.getName().getBytes("UTF-8"), "iso-8859-1");
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.CREATED);
    }


    @RequestMapping("/upload")
    @ResponseBody
    public UpLoadReturn upload(MultipartFile file, HttpServletRequest request) {

        //取得是谁要进行操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        Integer sid = Integer.valueOf(request.getParameter("sid"));
        String sName = request.getParameter("sName");
        String workName = request.getParameter("workName");
        String name = sName.split("</")[0].split(">")[1];
        Integer cid = Integer.valueOf(request.getParameter("cid"));
        String workReleaseId = request.getParameter("workreleaseid");

        OutputStream os = null;
        InputStream inputStream = null;
        String fileName = null;
        String filePath = null;

        //获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String dayTime = df.format(new Date());

        String path = request.getServletContext().getRealPath("/homeWork/" + workReleaseId + "/" + dayTime);

        UpLoadReturn res = new UpLoadReturn();
        try {
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
            os = new FileOutputStream(filePath);
            // 开始读取
            while ((len = inputStream.read(bs)) != -1) {
                os.write(bs, 0, len);
            }

            //数据库存储路径
            String databasePath = "homeWork@" +workReleaseId + "@@" + dayTime + "@@@" + fileName;


            //数据库插入操作
            TblWork tblWork = new TblWork();
            tblWork.setWorkreleasedetail(workName);
            tblWork.setWorkresult("完成");
            tblWork.setWfinishtime(new Date());
            tblWork.setWorkurl(databasePath);
            tblWork.setSid(sid);
            tblWork.setStudentname(name);
            tblWork.setCid(cid);
            tblWork.setWorkreleaseid(workReleaseId);
            tblWork.setPid(parent.getParentId());
            tblWork.setParentname(parent.getParentName());

            //判断是要覆盖还是第一次提交
            if (parentService.findSameWorkInsertRecord(tblWork) == 0) {
                parentService.uploadHomeWork(tblWork);
            } else {
                parentService.updateWorkUrl(tblWork);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 完毕，关闭所有链接
            try {
                os.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return res;
    }


    @RequestMapping("/kidHomeWorkList")
    @ResponseBody
    public TableDate kidHomeWorkList(HttpServletRequest request, SearchCondition searchCondition) {
//    查询家长的孩子的作业列表方法
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        Integer cid = Integer.valueOf(request.getParameter("cid"));
        //设置查找人id
        searchCondition.setParentId(parent.getParentId());

        //返回查找的结果
        return parentService.kidHomeWorkList(searchCondition, cid);
    }

    @RequestMapping("/getKids")
    @ResponseBody
    public Result getKids(HttpServletRequest request) {
//    查询家长id 查询孩子列表
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        //返回查找的结果
        return parentService.getKids(parent.getParentId());
    }


    @RequestMapping("/recordScore")
    @ResponseBody
    public Result recordScore(HttpServletRequest request) {
        Result result = new Result();
        //获取信息
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        Integer videoId = Integer.valueOf(request.getParameter("videoId"));
        Integer score = Integer.valueOf(request.getParameter("score"));

//        调用插入数据信息
        if (parent != null) {
            if (parentService.recordScore(parent.getParentId(), videoId, score)) {
                //成功返回状态
                result.setSuccess(true);
            }
        }
        return result;
    }


    @RequestMapping("/parentSafetyTestList")
    @ResponseBody
    public TableDate parentSafetyTestList(HttpServletRequest request, SearchCondition searchCondition) {
//    查询家长安全视频列表方法
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        //设置查找人id
        searchCondition.setParentId(parent.getParentId());
        //返回查找的结果
        return parentService.parentSafetyTestList(searchCondition);
    }

    @RequestMapping("/SafetyTestQuestion")
    public String playVideo(HttpServletRequest request) {
//        获取要做哪套题
        Integer safetyVideoId = Integer.valueOf(request.getParameter("safetyVideoId"));

        //查询出对应的题目列表
        List<TblSafetyvtq> subject = parentService.findSafetyTestQuestionList(safetyVideoId);
        //给请求加上题目
        request.setAttribute("subject", subject);
        //转发
        return "parentJsp/SafetyTestQuestion";
    }


    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        //移除当前在线的家长
        request.getSession().removeAttribute("onlineParent");
        return "parentJsp/parentLogin";
    }

    @RequestMapping("/updateParentPwd")
    @ResponseBody
    public Result updateParentPwd(HttpServletRequest request) {
        //取得是谁要执行修改密码操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        //数据的获取与转化
        String md5oldPwd = MD5Utils.md5(request.getParameter("parentOldPwd"));
        String md5newPwd = MD5Utils.md5(request.getParameter("parentNewPwd"));
        //调用service处理数据返回
        return parentService.updateParentPwd(parent.getParentId(), md5oldPwd, md5newPwd);
    }


    @RequestMapping("/loginCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) {
        try {
            int width = 60;
            int height = 30;
            String data = "QWERTYUIPASDFGHJKLZXCVBNMqwertyuipasdfghjklzxcvbnm123456789";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
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
            String parentcode = builder.toString();
            request.getSession().setAttribute("parentcode", parentcode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

//    @ParentSystemLog(operationType = "登陆", operationName = "家长登陆")
    @RequestMapping("/Login")
    @ResponseBody
    public Result parentLogin(HttpServletRequest request, String parentName, String parentPwd, String code) {

        Result loginResult = new Result();

        //判断验证码是否正确
        if (code.equalsIgnoreCase((String) request.getSession().getAttribute("parentcode"))) {
            //判断是否登陆成功

            if (parentName != null && parentPwd != null) {
                String loginPwd = MD5Utils.md5(parentPwd);
                TblParent loginParent = parentService.parentLogin(parentName, loginPwd);
                parentname = parentName;
                if (loginParent != null) {
                    //返回ajax数据跳转到家长端首页
                    loginResult.setData("/parent/toUrl/parentMain");
                    //设置结果为成功 前台用来判断
                    loginResult.setSuccess(true);
                    //session中存储家长信息
                    List<TblCampus> tblCampusList = securityService.findKinderNews(loginParent.getKindername());
                    request.getSession().setAttribute("tblCampusList", tblCampusList);
                    request.getSession().setAttribute("onlineParent", loginParent);
                    request.getSession().setAttribute("parentname", parentname);
                    //返回信息给ajax
                    return loginResult;
                } else {
                    //返回告知账号或者密码错误
                    loginResult.setMsg("loginFailed");
                }
            } else {
                //返回告知账号或者密码错误
                loginResult.setMsg("loginFailed");
            }

        } else {
            //返回告知验证码错误
            loginResult.setMsg("codeError");
        }
        return loginResult;
    }



    //-------------人脸识别考勤---------------

    @RequestMapping("/regFaceId")
    @ResponseBody
  public Result regFaceId(HttpServletRequest request, HttpServletResponse response) {
        //注册人脸方法
        Result result = new Result();

        String face = request.getParameter("face");

        //获取信息
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        //String name
        if (FaceRecognitionUtils.faceRegister(face, parent.getParentId())){
            result.setSuccess(true);
        }

        return result;
    }

    //新增考勤-------------------------------------------------------------------------------------------
     /*
    1.日期
    2.家长类型（妈妈或者爸爸）
    3.当前时间段：如8:30
    4.需要判断是上午还是下午
    5.需要pmid                                                    registered
    6.需要孩子id
    7.需要日期区间id（需要添加本周一到本周日） --完成
    8.如果下午或上午没打卡的话默认要插入请假或者其它默认数据
     */
    @RequestMapping("/addStuTime")
    public void addStuTime(TblDate tblDate, TblStutime tblStutime, HttpServletRequest request, HttpServletResponse response) throws ParseException {

        String face = request.getParameter("face");

        //获取信息
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        //人脸识别成功
        if (FaceRecognitionUtils.identify(face,parent.getParentId())){
            //设置日期格式（当天日期）
            SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
            timeamdate = date.format(new Date());
            //本周日期
            monday = DateUtil.getMondayOfThisWeek(1);
            sunday = DateUtil.getSundayOfThisWeek(7);
            //查询是否存在本周一和周日的日期
            List<TblDate> tblDateList = parentService.findDateInfo(monday, sunday);
            Date dt = new Date();
            today = DateUtil.getWeekOfDate(dt);
            if (today.equals("星期六") || today.equals("星期日")) {
                System.out.println("不进行新增考勤");
                ResponseUtils.outHtml(response, "notadd");
            } else {
                if (0 == tblDateList.size()) {
                    //如果不存在本周一和周日的日期
                    System.out.println("不存在本周一和周日的日期");
                    tblDate.setMonday(date.parse(monday));
                    tblDate.setSunday(date.parse(sunday));
                    List<TblDate> dateList = new ArrayList<>();
                    flagDate = parentService.addDateInfo(dateList);
                    if (flagDate) {
                        System.out.println("日期区间新增成功");
                        //新增考勤
                        addStudentTime(tblDate, tblStutime, request, response);
                    } else {
                        System.out.println("日期区间新增失败");
                        ResponseUtils.outHtml(response, "errorinfo");
                    }
                } else {
                    System.out.println("存在本周一和周日的日期");
                    //新增考勤
                    addStudentTime(tblDate, tblStutime, request, response);
                }
            }
        }else {
            //人脸识别失败
            ResponseUtils.outHtml(response, "failure");
        }

    }

    /**
     * 增加学生打卡时间方法
     * @param tblDate
     * @param tblStutime
     * @param request
     * @param response
     */
    private void addStudentTime(TblDate tblDate, TblStutime tblStutime, HttpServletRequest request, HttpServletResponse response) {
        System.out.println("新增考勤信息");
        Calendar now = Calendar.getInstance();//获取时间段
        List<TblDate> DateList = parentService.findDateInfo(monday, sunday);//查询本周日期区间的id
        for (TblDate tbldate : DateList) {
            dateid = tbldate.getDateid();//日期id
            System.out.println("日期区间的id=" + dateid);
        }

        List<TblParent> tblParentList = parentService.findParentStuInfo(parentname);//查询父母亲的信息和宝宝id
        for (int i = 0; i < tblParentList.size(); i++) {
            parentname = tblParentList.get(i).getParentName();
            studentid = tblParentList.get(i).getStudentid();
        }

        Integer hh = now.get(Calendar.HOUR_OF_DAY);//获取当前是几点
        Integer mm = now.get(Calendar.MINUTE);//获取当前是几点几分钟

        if (hh <10) {
            if(mm < 10){
                ct = "0" + hh + ":" +"0"+mm;
            }else {
                ct = "0" + hh + ":" +mm;
            }
        }else {
            if(mm <10 ){
                ct = hh + ":" +"0"+mm;
            }else {
                ct = hh + ":" +mm;
            }
        }

        System.out.println("ct=" + ct);
        System.out.println("timeamdate=" + timeamdate);

        if (ct.compareTo("12:00") < 0) {
//        if (ct.compareTo("12:00") > 0) {
            timeam = ct;
            System.out.println("上午打卡的时间段=" + timeam);//上午打卡的时候同时新增当天日期
            tblStutime.setWeekinfo(today);
            tblStutime.setTimeamdate(timeamdate);
            tblStutime.setTimeam(timeam);
            tblStutime.setPnameam(parentname);

            TblStutime tblStutime1 = parentService.findPmTimeId(timeamdate);
            if (tblStutime1 == null) {
                System.out.println("下午考勤表中不存在今天的日期");
                System.out.println("timeamdate="+timeamdate);
                parentService.addPmDate(timeamdate);
                TblStutime tblStutime2 = parentService.findPmTimeId(timeamdate);

                System.out.println("tblStutime2=" + tblStutime2);
                System.out.println("当天下午的考勤id=" + tblStutime2.getTimepmid());
                tblStutime.setPmid(tblStutime2.getTimepmid());//今天下午的考勤表id
                tblStutime.setSid(studentid);
                tblStutime.setDid(dateid);
                System.out.println("上午tblStutime1=" + tblStutime);

                List<TblStutime> AmList = new ArrayList<>();
                AmList.add(tblStutime);
                TblStutime tblStutime3 = parentService.findExistDate(timeamdate);//查询是否今天有打过卡（即查上午考勤表中有没有今天的日期）
                if (null != tblStutime3) {
                    System.out.println("今天上午已经打过卡了");
                    System.out.println("AmList=" + AmList);
                    Boolean flag = parentService.updateAmAttendance(timeam, parentname, timeamdate);
                    if (flag) {
                        ResponseUtils.outHtml(response, "amsuccess");
                    } else {
                        ResponseUtils.outHtml(response, "errorinfo");
                    }
                } else {
                    flagAm = parentService.addAmAttendance(AmList);
                    if (flagAm) {
                        ResponseUtils.outHtml(response, "amsuccess");
                    } else {
                        ResponseUtils.outHtml(response, "errorinfo");
                    }
                }
            } else {
                System.out.println("下午考勤表中存在今天的日期");
                TblStutime tblStutime2 = parentService.findPmTimeId(timeamdate);
                System.out.println("当天下午的考勤id=" + tblStutime2.getTimepmid());
                tblStutime.setPmid(tblStutime2.getTimepmid());//今天下午的考勤表id
                tblStutime.setSid(studentid);
                tblStutime.setDid(dateid);
                System.out.println("上午tblStutime2=" + tblStutime);
                List<TblStutime> AmList = new ArrayList<>();
                AmList.add(tblStutime);

                TblStutime tblStutime3 = parentService.findExistDate(timeamdate);//查询是否今天有打过卡（即查上午考勤表中有没有今天的日期）
                if (null != tblStutime3) {
                    System.out.println("今天上午已经打过卡了");
                    System.out.println("AmList=" + AmList);
                    Boolean flag = parentService.updateAmAttendance(timeam, parentname, timeamdate);
                    if (flag) {
                        ResponseUtils.outHtml(response, "amsuccess");
                    } else {
                        ResponseUtils.outHtml(response, "errorinfo");
                    }
                } else {
                    flagAm = parentService.addAmAttendance(AmList);
                    if (flagAm) {
                        ResponseUtils.outHtml(response, "amsuccess");
                    } else {
                        ResponseUtils.outHtml(response, "errorinfo");
                    }
                }
            }
        } else {
            TblStutime tblStutime1 = parentService.findPmTimeId(timeamdate);
            if (tblStutime1 == null) {
                System.out.println("下午考勤表中不存在今天的日期");
                timepm = ct;
                System.out.println("下午打卡的时间段=" + timepm);
                tblStutime.setTimepmdate(timeamdate);
                tblStutime.setTimepm(timepm);
                tblStutime.setPnamepm(parentname);
                System.out.println("下午tblStutime3=" + tblStutime);
                List<TblStutime> PmList = new ArrayList<>();
                PmList.add(tblStutime);
                flagPm = parentService.addPmAttendanceAll(PmList);
                if (flagPm) {
                    ResponseUtils.outHtml(response, "pmsuccess");
                } else {
                    ResponseUtils.outHtml(response, "errorinfo");
                }
            } else {
                System.out.println("下午考勤表中存在今天的日期");
                System.out.println("今天下午已经打过卡了");
                timepm = ct;
                System.out.println("下午打卡的时间段=" + timepm);
                tblStutime.setTimepmdate(timeamdate);
                tblStutime.setTimepm(timepm);
                tblStutime.setPnamepm(parentname);
                System.out.println("下午tblStutime3=" + tblStutime);
                List<TblStutime> PmList = new ArrayList<>();
                PmList.add(tblStutime);
                flagPm = parentService.addPmAttendance(PmList);
                if (flagPm) {
                    ResponseUtils.outHtml(response, "pmsuccess");
                } else {
                    ResponseUtils.outHtml(response, "errorinfo");
                }
            }
        }
    }

    //查找所有宝宝信息
    @RequestMapping("/findAllStuInfo")
    public void findAllStuInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson g = new Gson();
        List<TblStudent> tblStudentList = parentService.findAllStuInfo(parentname);//查找所有宝宝信息，用于请假页面宝宝名称下拉框查询
        if (0 != tblStudentList.size()) {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            Object[] info = tblStudentList.toArray();
            String result = g.toJson(info);
            response.getWriter().print(result);
        } else {
            response.getWriter().print("error");
        }
    } //查找所有学生信息

    //新增请假信息
    @RequestMapping("/addLeaveInfo")
    public void addLeaveInfo(TblDate tblDate, TblStutime tblStutime, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentid = request.getParameter("studentid");
        String parentname = request.getParameter("parentname");
        String leaveDate = request.getParameter("leaveDate");
        String time = request.getParameter("time");

        System.out.println("studentid=" + studentid);
        System.out.println("parentname=" + parentname);
        System.out.println("leaveDate=" + leaveDate);
        System.out.println("time=" + time);

        SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式（当天日期）
        Date dt = new Date();
        String today = DateUtil.getWeekOfDate(dt);//获取今天是星期几
        String date = DateUtil.getMondaySundayByDate(leaveDate);//获取请假日期所在周的周一和周日的日期
        String[] arr = date.split("&");
        String monday = arr[0];//周一
        String sunday = arr[arr.length - 1];//周日

        System.out.println("monday="+monday);
        System.out.println("sunday="+sunday);

        List<TblDate> tblDateList = parentService.findDateInfo(monday, sunday);//查询是否存在本周一和周日的日期
        if (today.equals("星期六") || today.equals("星期日")) {
            System.out.println("周末不需要进行请假");
            ResponseUtils.outHtml(response, "notadd");
        } else {
            if (0 == tblDateList.size()) { //如果不存在本周一和周日的日期
                System.out.println("不存在本周一和周日的日期");
                tblDate.setMonday(dft.parse(monday));
                tblDate.setSunday(dft.parse(sunday));
                List<TblDate> dateList = new ArrayList<>();
                flagDate = parentService.addDateInfo(dateList);
                if (flagDate) {
                    System.out.println("日期区间新增成功");
                    addStuLeaveInfo(tblDate, tblStutime, leaveDate, time, monday ,sunday,request, response);
                } else {
                    System.out.println("日期区间新增失败");
                    ResponseUtils.outHtml(response, "error");
                }
            } else {
                System.out.println("存在本周一和周日的日期");
                addStuLeaveInfo(tblDate, tblStutime, leaveDate, time, monday ,sunday,request, response);
            }
        }
    }

    private void addStuLeaveInfo(TblDate tblDate, TblStutime tblStutime, String leaveDate, String time,  String monday , String sunday,HttpServletRequest request, HttpServletResponse response) {
        //日期区间新增成功或者查出存在的话，查出该区间的id
        List<TblDate> DateList = parentService.findDateInfo(monday, sunday);//查询本周日期区间的id
        for (TblDate tbldate : DateList) {
            dateid = tbldate.getDateid();//日期id
        }
        System.out.println("日期区间的id=" + dateid);

        TblStutime tblStutimeAm = parentService.findAmTimeId(leaveDate);//查看下午考勤表中是否存在今天的日期
        TblStutime tblStutimePm = parentService.findPmTimeId(leaveDate);//查看下午考勤表中是否存在今天的日期

        if (time.equals("上午")) {
            if (null != tblStutimeAm) {
                System.out.println("上午考勤表中存在今天的日期");
                System.out.println("update上午考勤信息");
                Boolean flag = parentService.updateAmAttendance("请假", "无", leaveDate);
                if (flag) {
                    ResponseUtils.outHtml(response, "success");
                } else {
                    ResponseUtils.outHtml(response, "error");
                }
            } else {
                System.out.println("insert上午考勤信息");
                tblStutime.setWeekinfo(today);
                tblStutime.setTimeamdate(leaveDate);
                tblStutime.setTimeam("请假");
                tblStutime.setPnameam("无");
                if (null == tblStutimePm) {
                    System.out.println("下午考勤表中不存在今天的日期");
                    parentService.addPmDate(leaveDate);
                    TblStutime tblStutime1 = parentService.findPmTimeId(leaveDate);
                    System.out.println("当天下午的考勤id=" + tblStutime1.getTimepmid());
                    tblStutime.setPmid(tblStutime1.getTimepmid());
                    tblStutime.setSid(Integer.valueOf(studentid));
                    tblStutime.setDid(dateid);
                    List<TblStutime> AmList = new ArrayList<>();
                    AmList.add(tblStutime);
                    flagAm = parentService.addAmAttendance(AmList);
                    if (flagAm) {
                        ResponseUtils.outHtml(response, "success");
                    } else {
                        ResponseUtils.outHtml(response, "error");
                    }
                }else {
                    System.out.println("下午考勤表中存在今天的日期");
                    TblStutime tblStutime1 = parentService.findPmTimeId(leaveDate);
                    System.out.println("当天下午的考勤id=" + tblStutime1.getTimepmid());
                    tblStutime.setPmid(tblStutime1.getTimepmid());
                    tblStutime.setSid(Integer.valueOf(studentid));
                    tblStutime.setDid(dateid);
                    List<TblStutime> AmList = new ArrayList<>();
                    AmList.add(tblStutime);
                    flagAm = parentService.addAmAttendance(AmList);
                    if (flagAm) {
                        ResponseUtils.outHtml(response, "success");
                    } else {
                        ResponseUtils.outHtml(response, "error");
                    }
                }
            }
        } else if (time.equals("下午")) {
            if (null != tblStutimePm) { //下午考勤表中存在今天的日期
                System.out.println("下午考勤表中存在今天的日期");
                System.out.println("update下午考勤信息");
                Boolean flag = parentService.updatePmAttendance("请假", "无", leaveDate);
                if (flag) {
                    ResponseUtils.outHtml(response, "success");
                } else {
                    ResponseUtils.outHtml(response, "error");
                }
            } else {
                System.out.println("insert考勤信息");
                tblStutime.setTimepmdate(leaveDate);
                tblStutime.setTimepm("请假");
                tblStutime.setPnamepm("无");
                List<TblStutime> PmList = new ArrayList<>();
                PmList.add(tblStutime);
                Boolean flag = parentService.addPmAttendanceAll(PmList);
                if (flag) {
                    ResponseUtils.outHtml(response, "success");
                } else {
                    ResponseUtils.outHtml(response, "error");
                }
            }
        }
    }

}
