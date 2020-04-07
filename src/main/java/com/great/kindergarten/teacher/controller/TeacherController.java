package com.great.kindergarten.teacher.controller;

import com.great.kindergarten.teacher.javabean.TblTeacher;
import com.great.kindergarten.teacher.service.TeacherService;
import com.great.kindergarten.util.MD5Utils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
    private String vcode;

    @Resource
    private TeacherService teacherService;

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
        System.out.println("teacherpwd="+teacherpwd);
//        获取验证码
        String code = tblTeacher.getCode();
//        验证码判定是否一致
        Boolean confirm = code.equalsIgnoreCase(vcode);
        if (confirm) {
//            获取名字查询状态
            String teacherStatus = teacherService.findTeacherStatus(tblTeacher.getTeachername());
           System.out.println("状态teacherStatus="+teacherStatus);
            if (teacherStatus.equals("启用")){
                System.out.println("登录="+teacherStatus);
//                登录 获取全部信息
                TblTeacher tblTeacher1 = teacherService.findTeacher(tblTeacher);
                List<TblTeacher> tblTeacherList=new ArrayList<>();

                if (null!=tblTeacher1){

                    request.getSession().setAttribute("teachername",tblTeacher1.getTeachername());
//                    存信息到页面显示
                    tblTeacherList.add(tblTeacher1);
                    System.out.println("tblTeacherList个人信息="+tblTeacherList);
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

}
