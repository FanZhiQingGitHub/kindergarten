package com.great.kindergarten.security.controller;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.DateWrite;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import com.great.kindergarten.security.resultbean.PickUpInfoPage;
import com.great.kindergarten.security.service.SecurityService;
import com.great.kindergarten.security.util.DateUtil;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/security")
public class SecurityController {
    private String securitycode;
    private String securityname;

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
//            String data = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789";    //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
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

    @RequestMapping("/securityLogin")
    public void healtherLogin(TblSecurity tblSecurity, HttpServletRequest request, HttpServletResponse response) {
        securityname = tblSecurity.getSecurityname();
        String securitypwd = MD5Utils.md5(tblSecurity.getSecuritypwd());
        String code = tblSecurity.getCode();
        Boolean confirm = code.equalsIgnoreCase(securitycode);
        if (confirm) {
            String securitystatus = securityService.findSecurityStatus(securityname);
            if (securitystatus.equals("启用")) {
                TblSecurity Security = securityService.securityLogin(securityname, securitypwd);
                if (null != Security) {
                    List<TblSecurity> tblSecurityList = new ArrayList<>();
                    tblSecurityList.add(Security);
                    List<TblClass> tblClassList = securityService.findAllClass();
                    request.getSession().setAttribute("tblClassList", tblClassList);
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

    //孩子接送信息，不含考勤
    @RequestMapping("/showPickUpInfo")
    public void showPickUpInfo(PickUpInfoPage pickUpInfoPage, DateWrite dateWrite ,HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String liketime = request.getParameter("key1");//接送时间
        String likeName = request.getParameter("key2");//学生姓名
        String likeCName= request.getParameter("key3");//班级姓名

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
        pickUpInfoPage.setTime1(time1);
        pickUpInfoPage.setTime2(time2);
        pickUpInfoPage.setuStuName(uStuName);
        pickUpInfoPage.setcName(cName);
        List<TblStudent> tblStudentList = securityService.findALLPickUpInfo(pickUpInfoPage);
        System.out.println("tblStudentList="+tblStudentList);
        System.out.println("长度="+tblStudentList.size());
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
        }

    }

    //孩子详细接送信息，含考勤
    @RequestMapping("/showPickUpDetailInfo")
    public void showPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage, DateWrite dateWrite , HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String currentmonday = "1";
        String currentsonday = "7";
        String dafultsid = request.getParameter("studentid");

        String startdate = request.getParameter("key1");//周一日期
        String enddate = request.getParameter("key2");//周日日期
        String sid = request.getParameter("key3");//周日日期
        String mondaydate = null;
        String sundaydate = null;

        if(null != startdate && null != enddate){
            mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(startdate));
            sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(enddate));
        }else {
            mondaydate = DateUtil.getMondayOfThisWeek(Integer.valueOf(currentmonday));
            sundaydate = DateUtil.getSundayOfThisWeek(Integer.valueOf(currentsonday));
        }
        pickUpInfoDetailPage.setMondaydate(mondaydate);
        pickUpInfoDetailPage.setSundaydate(sundaydate);
        if(null != sid){
            pickUpInfoDetailPage.setStudentid(Integer.valueOf(sid));
        }else {
            pickUpInfoDetailPage.setStudentid(Integer.valueOf(dafultsid));
        }
        List<TblStutime> tblStutimeList = securityService.findALLPickUpDetailInfo(pickUpInfoDetailPage);

        if (0 != tblStutimeList.size()) {
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(5);
            dateWrite.setData(tblStutimeList);

            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");

            ResponseUtils.outJson(response, dateWrite);
        }

    }

}
