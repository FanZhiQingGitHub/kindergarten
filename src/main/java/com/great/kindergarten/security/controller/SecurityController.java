package com.great.kindergarten.security.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.security.annotation.SecuritySystemLog;
import com.great.kindergarten.security.resultbean.*;
import com.great.kindergarten.security.service.SecurityService;
import com.great.kindergarten.util.DateUtil;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/security")
public class SecurityController {
    private String securitycode;
    private String securityname;
    private String kindername;

    @Resource
    private SecurityService securityService;

    @RequestMapping("/path/{url}")
    public String showView(@PathVariable(value = "url") String path) {
        return "securityjsp/" + path;
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
            securitycode = builder.toString();
            request.getSession().setAttribute("securitycode", securitycode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @SecuritySystemLog(operationType = "登录", operationName = "安防员登录")
    @RequestMapping("/securityLogin")
    public void securityLogin(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response) {
        securityname = tblSecurity.getSecurityname();
        String securitypwd = MD5Utils.md5(tblSecurity.getSecuritypwd());
        String code = tblSecurity.getCode();
        Boolean confirm = code.equalsIgnoreCase(securitycode);
        if (confirm) {
            TblSecurity securitystatus = securityService.findSecurityStatus(securityname);
            if ("启用".equals(securitystatus.getSecuritystatus())) {
                TblSecurity Security = securityService.securityLogin(securityname, securitypwd);
                if (null != Security) {
                    List<TblSecurity> tblSecurityList = new ArrayList<>();
                    tblSecurityList.add(Security);
                    kindername = (String) request.getSession().getAttribute("kindername");
                    List<TblCampus> tblCampusList = securityService.findKinderNews(kindername);
                    request.getSession().setAttribute("tblCampusList", tblCampusList);
                    request.getSession().setAttribute("securityname", securityname);
                    request.getSession().setAttribute("tblSecurityList", tblSecurityList);
                    ResponseUtils.outHtml(response, "success");
                }
            } else {
                ResponseUtils.outHtml(response, "notmen");
            }
        } else {
            ResponseUtils.outHtml(response, "codeerror");
        }
    }

    @RequestMapping("/checkOldPwd")
    public void checkOldPwd(HttpServletRequest request, HttpServletResponse response) {
        String oldpwd = request.getParameter("oldSecuritypwd");
        String oldSecuritypwd = MD5Utils.md5(oldpwd);//旧密码
        TblSecurity tblSecurity = securityService.findSecurityId(securityname);
        if (oldSecuritypwd.equals(tblSecurity.getSecuritypwd())) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @SecuritySystemLog(operationType = "修改", operationName = "安防员修改密码")
    @RequestMapping("/updateSecuritypwd")
    public void updateHealtherpwd(HttpServletRequest request, HttpServletResponse response) {
        TblSecurity tblSecurity = securityService.findSecurityId(securityname);
        String confrimpwd = request.getParameter("confrimSecuritypwd");
        String securitypwd = MD5Utils.md5(confrimpwd);
        Boolean flag = securityService.updateSecurityPwd(securitypwd, tblSecurity.getSecurityid().toString());
        if (flag) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @RequestMapping("/findExistSecurityName")
    public void findExistSecurityName(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response) {
        Integer num = securityService.findExistSecurityName(tblSecurity.getSecurityname());
        if (num > 0) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "notmen");
        }
    }

    //重置安防员密码
    @SecuritySystemLog(operationType = "修改", operationName = "安防员重置密码")
    @RequestMapping("/resetSecuritypwd")
    public void resetSecuritypwd(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response) {
        request.getSession().setAttribute("securityname", tblSecurity.getSecurityname());
        Boolean flag = securityService.resetSecuritypwd(tblSecurity.getSecurityname(), tblSecurity.getSecurityphone());
        if (flag) {
            request.getSession().removeAttribute("securityname");//重置成功后清除掉
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    //查找宝宝班级信息
    @RequestMapping("/findStuClassInfo")
    public void findStuClassInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Gson g = new Gson();
        List<TblClass> tblClassList = securityService.findAllClass();//查找所有班级信息，用于接送信息班级下拉框查询
        if (0 != tblClassList.size()) {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            Object[] info = tblClassList.toArray();
            String result = g.toJson(info);
            response.getWriter().print(result);
        } else {
            response.getWriter().print("error");
        }
    }

    //孩子接送信息，不含考勤
    @RequestMapping("/showPickUpInfo")
    public void showPickUpInfo(PickUpInfoPage pickUpInfoPage, DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String liketime = request.getParameter("key1");//接送时间
        String likeName = request.getParameter("key2");//学生姓名
        String likeCName = request.getParameter("key3");//班级姓名
        Object liketime1 = null;
        Object liketime2 = null;

        if (liketime != null) {
            String[] arr = liketime.split("~ ");
            liketime1 = arr[0];
            liketime2 = arr[arr.length - 1];
        }
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        Object time1 = null;
        Object time2 = null;
        String uStuName = null;
        String cName = null;
        if (null != liketime1 && !"".equals(((String) liketime1).trim())) {
            time1 = liketime1;
        }
        if (null != liketime2 && !"".equals(((String) liketime2).trim())) {
            time2 = liketime2;
        }

        if (null != likeName && !"".equals(likeName.trim())) {
            uStuName = likeName;
        }

        if (null != likeCName && !"".equals(likeCName.trim()) && !"请选择".equals(likeCName)) {
            cName = likeCName;
        }
        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        pickUpInfoPage.setPage(minpage);
        pickUpInfoPage.setLimit(maxpage);
        pickUpInfoPage.setTime1(time1);
        pickUpInfoPage.setTime2(time2);
        pickUpInfoPage.setuStuName(uStuName);
        pickUpInfoPage.setcName(cName);
        List<TblStudent> tblStudentList = securityService.findALLPickUpInfo(pickUpInfoPage);
        if (0 != tblStudentList.size()) {
            Integer count = securityService.findALLPickUpInfoCount(pickUpInfoPage).intValue();
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(count);
            dateWrite.setData(tblStudentList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            request.getSession().setAttribute("uStuName", uStuName);
            ResponseUtils.outJson(response, dateWrite);
        } else {
            dateWrite.setMsg("亲，暂无相关数据(注：如果是时间搜索，请选择周一至周日的时间进行查询，谢谢！)");
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }

    }

    //孩子详细接送信息，含考勤
    @RequestMapping("/showPickUpDetailInfo")
    public void showPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage, DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws IOException {
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
        List<TblDate> tblDateList = securityService.findALLPickUpDetailInfo(pickUpInfoDetailPage);
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

    //查找所有宝宝信息
    @RequestMapping("/findAllStuInfo")
    public void findAllStuInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson g = new Gson();
        List<TblStudent> tblStudentList = securityService.findAllStuInfo();//查找所有宝宝信息，用于电子围栏宝宝名称下拉框查询
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

    //查找所选择宝宝的默认坐标信息(备用)
    @RequestMapping("/findStuLngLatInfo")
    public void findStuLngLatInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentid = request.getParameter("studentid");
        String studentname = request.getParameter("studentname");
        String studentbrith = request.getParameter("studentbrith");
        Gson g = new Gson();
        List<TblStudent> tblStudentList = securityService.findStuLngLetInfo(studentid, studentname, studentbrith);//查找所有宝宝信息，用于电子围栏宝宝名称下拉框查询
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
    }

    //查找宝宝轨迹
    @RequestMapping("/findStuTrack")
    public void findStuTrack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String studentid = request.getParameter("studentid");
        String studentname = request.getParameter("studentname");
        String studentbrith = request.getParameter("studentbrith");
        Gson g = new Gson();
        List<TblStuTrack> tblStuTrackList = securityService.findStuTrack(studentid);//查找所选宝宝轨迹信息
        if (0 != tblStuTrackList.size()) {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            Object[] info = tblStuTrackList.toArray();
            String result = g.toJson(info);
            response.getWriter().print(result);
        } else {
            response.getWriter().print("error");
        }
    }

    //记录学生越界报警信息
    @SecuritySystemLog(operationType = "增加", operationName = "宝宝越界报警信息记录")
    @RequestMapping("/addAlarmLogInfo")
    public void addAlarmLogInfo(TblAlarmLog tblAlarmLog, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String studentid = request.getParameter("studentid");
        String studentname = request.getParameter("studentname");
        String lnginfo = request.getParameter("lnginfo");
        String latinfo = request.getParameter("latinfo");
        Gson g = new Gson();
        String alarmlogarea = null;
        String lng = null;
        String lat = null;

        String a = lnginfo.split("\\.")[0];
        String b = lnginfo.split("\\.")[1];
        if (b.length() == 4) {
            b += 0;
            lng = a + "." + b;
        } else {
            lng = lnginfo;
        }

        String c = latinfo.split("\\.")[0];
        String d = latinfo.split("\\.")[1];
        if (d.length() == 4) {
            d += 0;
            lat = c + "." + d;
        } else {
            lat = latinfo;
        }

        if (lng.equals("118.192697") && lat.equals("24.488705")) {
            alarmlogarea = "西门";
        } else if (lng.equals("118.192697") && lat.equals("24.48854")) {
            alarmlogarea = "东门";
        } else if (lng.equals("118.19320") && lat.equals("24.48892")) {
            alarmlogarea = "北门";
        } else if (lng.equals("118.19320") && lat.equals("24.48828")) {
            alarmlogarea = "南门";
        }
        TblKinder tblKinder = securityService.findKinderId(kindername);
        tblAlarmLog.setKinderid(tblKinder.getKinderid());
        tblAlarmLog.setAlarmlogarea(alarmlogarea);
        tblAlarmLog.setAlarmlogtime(new Date());
        tblAlarmLog.setAlarmlogname("越界");
        tblAlarmLog.setStudentname(studentname);
        tblAlarmLog.setSid(Integer.valueOf(studentid));
        List<TblAlarmLog> tblAlarmLogList = new ArrayList<>();
        tblAlarmLogList.add(tblAlarmLog);
        Boolean flag = securityService.addAlarmLogInfo(tblAlarmLogList);//查找所有宝宝信息，用于电子围栏宝宝名称下拉框查询
        if (flag) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    //报警信息
    @RequestMapping("/showAlarmInfo")
    public void showAlarmInfo(AlarmLogPage alarmLogPage, DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String liketime = request.getParameter("key1");//接送时间
        Object liketime1 = null;
        Object liketime2 = null;

        if (liketime != null) {
            String[] arr = liketime.split("~ ");
            liketime1 = arr[0];
            liketime2 = arr[arr.length - 1];
        }
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        Object time1 = null;
        Object time2 = null;
        if (null != liketime1 && !"".equals(((String) liketime1).trim())) {
            time1 = liketime1;
        }
        if (null != liketime2 && !"".equals(((String) liketime2).trim())) {
            time2 = liketime2;
        }

        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;

        alarmLogPage.setKindername(kindername);
        alarmLogPage.setPage(minpage);
        alarmLogPage.setLimit(maxpage);
        alarmLogPage.setTime1(time1);
        alarmLogPage.setTime2(time2);

        List<TblAlarmLog> tblAlarmLogList = securityService.findAlarmInfo(alarmLogPage);
        if (0 != tblAlarmLogList.size()) {
            Integer count = securityService.findAlarmInfoCount(alarmLogPage).intValue();
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(count);
            dateWrite.setData(tblAlarmLogList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            if (kindername == null) {
                dateWrite.setMsg("亲，您需要登录幼儿园账号后才可以查看该信息！");
            } else {
                dateWrite.setMsg("亲，暂无相关数据(注：如果是时间搜索，请选择周一至周日的时间进行查询，谢谢！)");
            }
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }

    }

    //新增电子围栏
    @SecuritySystemLog(operationType = "新增", operationName = "安防员新增幼儿园电子围栏")
    @RequestMapping("/addCoordinate")
    public void addCoordinate(HttpServletRequest request, HttpServletResponse response) {
        Gson g = new Gson();
        String msg = request.getParameter("TblCoordinate");
        TblCoordinate tblCoordinate = g.fromJson(msg, TblCoordinate.class);
        TblKinder tblKinder = securityService.findKinderId(kindername);
        List<TblCoordinate> tblCoordinateList = tblCoordinate.getCoordinatelist();
        for (int i = 0; i < tblCoordinateList.size(); i++) {
            tblCoordinateList.get(i).setKinderid(tblKinder.getKinderid());
        }
        Boolean flag = securityService.addCoordinate(tblCoordinateList);
        if (flag) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    //查找电子围栏坐标
    @RequestMapping("/findCoordinate")
    public void findCoordinate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson g = new Gson();
        if (kindername == null) {
            response.getWriter().print("notkindername");
        } else {
            TblKinder tblKinder = securityService.findKinderId(kindername);
            List<TblCoordinate> tblCoordinateList = securityService.findCoordinate(tblKinder.getKinderid().toString());
            if (0 != tblCoordinateList.size()) {
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                Object[] info = tblCoordinateList.toArray();
                String result = g.toJson(info);
                response.getWriter().print(result);
            } else {
                response.getWriter().print("error");
            }
        }
    }

    //查出幼儿园的电子围栏信息
    @RequestMapping("/findLngLatInfo")
    public void findLngLatInfo(DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String kindername = request.getParameter("kindername");
        List<TblCoordinate> tblCoordinateList = securityService.findLngLatInfo(kindername);
        if (0 != tblCoordinateList.size()) {
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(0);
            dateWrite.setData(tblCoordinateList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            if (kindername == null) {
                dateWrite.setMsg("亲，您需要登录幼儿园账号后才可以查看该信息！");
            } else {
                dateWrite.setMsg("亲，暂无相关数据！");
            }
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }
    }

    //修改电子围栏坐标
    @SecuritySystemLog(operationType = "修改", operationName = "安防员修改幼儿园电子围栏")
    @RequestMapping("/updateMealInfo")
    public void updateMealInfo(TblCoordinate tblCoordinate, HttpServletRequest request, HttpServletResponse response) {
        //需要幼儿园账号找出ID
        Gson g = new Gson();
        String msg = request.getParameter("TblCoordinate");
        tblCoordinate = g.fromJson(msg, TblCoordinate.class);
        List<TblCoordinate> tblCoordinateList = tblCoordinate.getCoordinatelist();
        TblKinder tblKinder = securityService.findKinderId(kindername);//查出幼儿园id
        Boolean flag = securityService.deleteLngLatInfo(tblKinder.getKinderid());
        if (flag) {
            Boolean flag1 = securityService.addCoordinate(tblCoordinateList);
            if (flag1) {
                ResponseUtils.outHtml(response, "success");
            } else {
                ResponseUtils.outHtml(response, "error");
            }
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @RequestMapping("/showMonitorInfo")
    public void showMonitorInfo(DateWrite dateWrite, MonitorPage monitorPage, HttpServletRequest request, HttpServletResponse response) throws Exception {

        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));

        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        monitorPage.setKindername(kindername);
        monitorPage.setPage(minpage);
        monitorPage.setLimit(maxpage);
        List<TblMonitor> tblMonitorList = securityService.findALLMonitorInfo(monitorPage);
        if (0 != tblMonitorList.size()) {
            Integer count = securityService.findALLMonitorInfoCount(monitorPage).intValue();
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(count);
            dateWrite.setData(tblMonitorList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            if (kindername == null) {
                dateWrite.setMsg("亲，您需要登录幼儿园账号后才可以查看该信息！");
            } else {
                dateWrite.setMsg("亲，暂无相关数据！");
            }
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }
    }


    @RequestMapping("/showClassInfo")
    public void showClassInfo(DateWrite dateWrite, ClassPage classPage, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));

        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        classPage.setKindername(kindername);
        classPage.setPage(minpage);
        classPage.setLimit(maxpage);

        List<TblClass> tblClassList = securityService.findClassInfo(classPage);
        if (0 != tblClassList.size()) {
            Integer count = securityService.findClassInfoCount(classPage).intValue();
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(count);
            dateWrite.setData(tblClassList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            if (kindername == null) {
                dateWrite.setMsg("亲，您需要登录幼儿园账号后才可以查看该信息！");
            } else {
                dateWrite.setMsg("亲，暂无相关数据！");
            }
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }
    }

    //查找所有的监控区域
    @RequestMapping("/findAllMonitorCP")
    public void findAllMonitorCP(MonitorTreeInfo monitorTreeInfo, HttpServletRequest request, HttpServletResponse response) {
        String classid = request.getParameter("classid");

        List<TblClamon> tblClamonList1 = securityService.findAllMonitorname();
        List<TblClamon> tblClamonList2 = securityService.findMonitornameByClassID(Integer.valueOf(classid));
        Map menuMap = new LinkedHashMap();
        menuMap.put("menu", tblClamonList1);
        menuMap.put("mid", tblClamonList2);
        if (0 != menuMap.size()) {
            ResponseUtils.outJson(response, menuMap);
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @SecuritySystemLog(operationType = "修改", operationName = "安防员配置班级家长直播权限")
    @RequestMapping("/updateMonitorCP")
    public void updateMonitorCP(TblMonitorname tblMonitorname, HttpServletRequest request, HttpServletResponse response) {
        Gson g = new Gson();
        String msg = request.getParameter("TblMonitorname");
        tblMonitorname = g.fromJson(msg, TblMonitorname.class);
        List tblMonitornameList = tblMonitorname.getTblMonitornameList();
        Integer classid = tblMonitorname.getClassid();
        List<Map<String, Integer>> list = new ArrayList();
        for (int i = 0; i < tblMonitornameList.size(); i++) {
            Map<String, Integer> menuMap = new LinkedHashMap();
            Double id = (Double) tblMonitornameList.get(i);
            String[] arr = id.toString().split("\\.");
            String num = arr[0];
            menuMap.put("cid", classid);
            menuMap.put("mnid", Integer.valueOf(num));
            list.add(menuMap);
        }
        Boolean flag = null;
        Integer count = securityService.findMonitorInfoCont(classid).intValue();
        if (count > 0) {
            flag = securityService.deleteMnId(classid);
            if (flag) {
                flag = securityService.updateTblClamon(list);
                if (flag) {
                    ResponseUtils.outHtml(response, "success");
                } else {
                    ResponseUtils.outHtml(response, "error");
                }
            } else {
                ResponseUtils.outHtml(response, "error");
            }
        } else {
            flag = securityService.updateTblClamon(list);
            if (flag) {
                ResponseUtils.outHtml(response, "success");
            } else {
                ResponseUtils.outHtml(response, "error");
            }
        }
    }

    @RequestMapping("/showMonitorInfoMag")
    public void showMonitorInfoMag(DateWrite dateWrite, MonitorPage monitorPage, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String liketime = request.getParameter("key1");//视频时间
        String likeName = request.getParameter("key2");//视频名称
        Object liketime1 = null;
        Object liketime2 = null;

        if (liketime != null) {
            String[] arr = liketime.split("~ ");
            liketime1 = arr[0];
            liketime2 = arr[arr.length - 1];
        }
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        Object time1 = null;
        Object time2 = null;
        String monitormvname = null;
        if (null != liketime1 && !"".equals(((String) liketime1).trim())) {
            time1 = liketime1;
        }
        if (null != liketime2 && !"".equals(((String) liketime2).trim())) {
            time2 = liketime2;
        }
        if (null != likeName && !"".equals(likeName.trim())) {
            monitormvname = likeName;
        }

        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        monitorPage.setKindername(kindername);
        monitorPage.setTime1(time1);
        monitorPage.setTime2(time2);
        monitorPage.setMonitormvname(monitormvname);
        monitorPage.setPage(minpage);
        monitorPage.setLimit(maxpage);
        List<TblMonitor> tblMonitorList = securityService.findALLMonitorInfoMag(monitorPage);
        if (0 != tblMonitorList.size()) {
            Integer count = securityService.findALLMonitorInfoCountMag(monitorPage).intValue();
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(count);
            dateWrite.setData(tblMonitorList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            if (kindername == null) {
                dateWrite.setMsg("亲，您需要登录幼儿园账号后才可以查看该信息！");
            } else {
                dateWrite.setMsg("亲，暂无相关数据！");
            }
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        }
    }

}
