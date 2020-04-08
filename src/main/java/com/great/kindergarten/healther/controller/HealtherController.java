package com.great.kindergarten.healther.controller;

import com.great.kindergarten.commons.entity.TblClass;
import com.great.kindergarten.commons.entity.TblExamination;
import com.great.kindergarten.commons.entity.TblHealther;
import com.great.kindergarten.healther.resultbean.DateWrite;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import com.great.kindergarten.healther.service.HealtherService;
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
@RequestMapping("/healther")
public class HealtherController {
    private String healthercode;
    private String healthername;

    @Resource
    private HealtherService healtherService;

    @RequestMapping("/main")
    public String showMainView() {
        return "mainjsp/main";
    }

    @RequestMapping("/path/{url}")
    public String showView(@PathVariable(value = "url") String path) {
        return "healtherjsp/" + path;
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
            healthercode = builder.toString();
            request.getSession().setAttribute("healthercode", healthercode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/healtherLogin")
    public void healtherLogin(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response) {
        healthername = tblHealther.getHealthername();
        String healtherpwd = MD5Utils.md5(tblHealther.getHealtherpwd());
        String code = tblHealther.getCode();
        Boolean confirm = code.equalsIgnoreCase(healthercode);
        if (confirm) {
            String healtherstatus = healtherService.findHealtherStatus(healthername);
            if (healtherstatus.equals("启用")) {
                TblHealther Healther = healtherService.healtherLogin(healthername, healtherpwd);
                if (null != Healther) {
                    List<TblHealther> tblHealtherList = new ArrayList<>();
                    tblHealtherList.add(Healther);
                    List<TblClass> tblClassList = healtherService.findAllClass();
                    request.getSession().setAttribute("tblClassList",tblClassList);
                    request.getSession().setAttribute("healthername", healthername);
                    request.getSession().setAttribute("tblHealtherList", tblHealtherList);
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
        String oldpwd = request.getParameter("oldhealtherpwd");
        String oldhealtherpwd = MD5Utils.md5(oldpwd);//旧密码
        TblHealther tblHealther = healtherService.findHealtherId(healthername);
        if (oldhealtherpwd.equals(tblHealther.getHealtherpwd())) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @RequestMapping("/updateHealtherpwd")
    public void updateHealtherpwd(HttpServletRequest request, HttpServletResponse response) {
        TblHealther tblHealther = healtherService.findHealtherId(healthername);
        String confrimpwd = request.getParameter("confrimHealtherpwd");
        String healtherpwd = MD5Utils.md5(confrimpwd);
        Boolean flag = healtherService.updateHealtherPwd(healtherpwd, tblHealther.getHealtherid().toString());
        if (flag) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @RequestMapping("/showALLExamination")
    public void showALLExamination(HttpServletRequest request, HttpServletResponse response, DateWrite dateWrite) throws UnsupportedEncodingException {
        String likeName = request.getParameter("key");
        System.out.println("likeName="+likeName);

        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        String cName = null;
        if (null != likeName && !"".equals(likeName.trim())) {
            cName = likeName;
        }
        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        ExaminationPage examinationPage = new ExaminationPage(cName, minpage, maxpage);
        List<TblExamination> tblExaminationList = healtherService.findALLExamination(examinationPage);
        System.out.println("tblExaminationList="+tblExaminationList);
        if (0 != tblExaminationList.size()) {
            Integer count = healtherService.findALLExaminationCount(examinationPage).intValue();
            dateWrite.setCode(0);
            dateWrite.setMsg(" ");
            dateWrite.setCount(count);
            dateWrite.setData(tblExaminationList);
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            request.getSession().setAttribute("cName", cName);
            ResponseUtils.outJson(response, dateWrite);
        }
    }
}
