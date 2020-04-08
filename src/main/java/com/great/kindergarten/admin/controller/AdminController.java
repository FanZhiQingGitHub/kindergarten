package com.great.kindergarten.admin.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.TblAdmin;
import com.great.kindergarten.commons.entity.TblMenu;
import com.great.kindergarten.admin.service.AdminService;
import com.great.kindergarten.util.MD5Utils;
import com.great.kindergarten.util.ResponseUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;
import java.util.Random;

/**
 * @author LXC
 */

@Controller
@RequestMapping("/admin")
public class AdminController {
    private String admincode;

    @Resource
    private AdminService adminService;

    @RequestMapping("/main")
    public String showMainView(){
        return "mainjsp/main";
    }

	@RequestMapping("/toUrl/{url}")
	public String matchUrl(@PathVariable("url") String url)
	{
		System.out.println("url=" + url);
		return "/adminjsp/" + url;
	}

    @RequestMapping(value = "/logout")
    public String toLogout(){
        return "adminjsp/adminLogin";
    }

    @RequestMapping("/loginCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) {
        try {
            int width = 60;
            int height = 30;
            //随机字符字典，其中0，o，1，I 等难辨别的字符最好不要
            String data = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm0123456789";
            //随机类
            Random random = new Random();
            //1 创建图片数据缓存区域（核心类）
            // 创建一个彩色的图片
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
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
                //随机噪音点
                g.fillRect(random.nextInt(width), random.nextInt(height), 1, 1);
            }
            /**3 获得随机数据，并保存session*/
            admincode = builder.toString();
            request.getSession().setAttribute("admincode", admincode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/checkLogin")
    //	@Log(operationType = "登录",operationName = "管理员登录")
    public void login(TblAdmin tblAdmin, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
    {
        System.out.println(tblAdmin);
        boolean flag = admincode.equalsIgnoreCase(tblAdmin.getCode());
        if(flag)
        {
            String adminstatus = adminService.findAdminStatus(tblAdmin.getAdminname());
            if("启用".equals(adminstatus))
            {
                if(tblAdmin.getAdminname() != null &&!"".equals(tblAdmin.getAdminname().trim())
                        &&tblAdmin.getAdminpwd() != null &&!"".equals(tblAdmin.getAdminpwd().trim()))
                {
                    String adminpwd = MD5Utils.md5(tblAdmin.getAdminpwd());
                    tblAdmin.setAdminpwd(adminpwd);
                    tblAdmin = adminService.adminLogin(tblAdmin);
                    if(tblAdmin != null)
                    {
                        String rolename = adminService.findRoleByRid(tblAdmin.getRid());
                        List<TblAdmin> tblAdminList = adminService.findAdminByName(tblAdmin.getAdminname());
                        req.getSession().setAttribute("tblAdminList",tblAdminList);
                        req.getSession().setAttribute("rolename",rolename);
                        req.getSession().setAttribute("tblAdmin",tblAdmin);
                        req.getSession().setAttribute("adminname",tblAdmin.getAdminname());
                        ResponseUtils.outHtml(res,"success");
                    }
                }else{
                    ResponseUtils.outHtml(res,"error");
                }
            }else{
                ResponseUtils.outHtml(res,"notman");
            }
        }else{
            ResponseUtils.outHtml(res,"codeerror");
        }
    }

	@RequestMapping("/treeMenu")
	public void treeDemo(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String adminname = (String) request.getSession().getAttribute("adminname");
		List<TblMenu> list = adminService.findMenuByName(adminname);
		Gson gson = new Gson();
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(gson.toJson(list));
		response.getWriter().flush();
		response.getWriter().close();
	}
}
