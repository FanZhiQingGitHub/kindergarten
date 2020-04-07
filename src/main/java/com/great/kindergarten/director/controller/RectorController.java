package com.great.kindergarten.director.controller;

import com.great.kindergarten.director.javabean.TblRector;
import com.great.kindergarten.director.service.RectorService;
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
import java.util.*;
import java.util.List;

/**
 * @author JK
 */
@Controller
@RequestMapping("/director")
public class RectorController {
    private String vcode;
    @Resource
    private RectorService rectorService;
    @Resource
    TblRector tblRector;

    //	管理路径跳转的问题--前台的界面(路径/toUrl/*)
    @RequestMapping("/toUrl/{id}")
    public String matchUrl(@PathVariable("id") String id)
    {
        System.out.println("id=" + id);
        return "/directorjsp/" + id;
    }

    //验证码的登录过程
    @RequestMapping("/loginCode")
    public void cherkCode(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        System.out.println("进来这个方法里面=========================");
        //BufferedImage将图片存入缓存中，有三个构造方法，此处的三个参数为图片的宽，高，以及创建的图像类型。
        BufferedImage bi = new BufferedImage(68, 22, BufferedImage.TYPE_INT_RGB);
        //为bi创建图形上下文
        Graphics g = bi.getGraphics();
        //设置颜色，此处调用的构造方法是基于RGB数值作为参数的
        Color c = new Color(200, 150, 255);
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

    //登录判断的过程
    @RequestMapping("/directorLogin")
    public void loginCode(String username, String userpwd, String code,HttpServletRequest request, HttpServletResponse response)
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
            request.getSession().setAttribute("loginUser", tblRectors);
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



}
