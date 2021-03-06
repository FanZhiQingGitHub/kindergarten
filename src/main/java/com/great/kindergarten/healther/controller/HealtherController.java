package com.great.kindergarten.healther.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.annotation.HealtherSystemLog;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import com.great.kindergarten.healther.resultbean.MealPage;
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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/healther")
public class HealtherController {
    private String healthercode;
    private String healthername;
    private String kindername;

    @Resource
    private HealtherService healtherService;

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

    @HealtherSystemLog(operationType = "登录", operationName = "保健员登录")
    @RequestMapping("/healtherLogin")
    public void healtherLogin(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response) {
        healthername = tblHealther.getHealthername();
        TblKinder tblKinder = healtherService.findHealtherKinder(healthername);
        if(null == tblKinder){
            request.getSession().removeAttribute("healthername");
            ResponseUtils.outHtml(response, "notmen");
        }else {
            kindername = tblKinder.getKindername();
            Integer kid = tblKinder.getKinderid();
            String healtherpwd = MD5Utils.md5(tblHealther.getHealtherpwd());
            String code = tblHealther.getCode();
            Boolean confirm = code.equalsIgnoreCase(healthercode);
            if (confirm) {
                String healtherstatus = healtherService.findHealtherStatus(healthername);
                if ("启用".equals(healtherstatus)) {
                    TblHealther Healther = healtherService.healtherLogin(healthername, healtherpwd);
                    if (null != Healther) {
                        ResponseUtils.outHtml(response, "success");
                        List<TblHealther> tblHealtherList = new ArrayList<>();
                        tblHealtherList.add(Healther);
                        List<TblCampus> tblCampuses = healtherService.findHealtherNews(kindername);
                        List<TblClass> tblClassList = healtherService.findAllClass(kindername);
                        request.getSession().setAttribute("tblCampuses", tblCampuses);
                        request.getSession().setAttribute("tblClassList", tblClassList);
                        request.getSession().setAttribute("healthername", healthername);
                        request.getSession().setAttribute("kindername", kindername);
                        request.getSession().setAttribute("kid", kid);
                        request.getSession().setAttribute("tblHealtherList", tblHealtherList);
                    }
                } else {
                    ResponseUtils.outHtml(response, "notmen");
                }
            } else {
                ResponseUtils.outHtml(response, "codeerror");
            }
        }
    }


    //根据园所查找所有班级信息
    @RequestMapping("/findAllClassInfo")
    public void findAllClassInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        kindername = (String) request.getSession().getAttribute("kindername");
        List<TblClass> tblClassList = healtherService.findAllClass(kindername);
        Gson g = new Gson();
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


    @RequestMapping("/findExistHealtherName")
    public void findExistHealtherName(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response) {
        request.getSession().setAttribute("healthername", tblHealther.getHealthername());
        Integer num = healtherService.findExistHealtherName(tblHealther.getHealthername());
        if (num > 0) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "notmen");
        }
    }


    @HealtherSystemLog(operationType = "重置密码", operationName = "保健员重置密码")
    @RequestMapping("/resetHealtherpwd")
    public void resetHealtherpwd(TblHealther tblHealther, HttpServletRequest request, HttpServletResponse response) {
        request.getSession().setAttribute("healthername", tblHealther.getHealthername());
        Boolean flag = healtherService.resetHealtherpwd(tblHealther.getHealthername(), tblHealther.getHealtherphone());
        if (flag) {
            request.getSession().removeAttribute("healthername");//重置成功后清除掉
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
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

    @HealtherSystemLog(operationType = "修改", operationName = "保健员修改密码")
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
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));
        String cName = null;
        if (null != likeName && !"".equals(likeName.trim())) {
            cName = likeName;
        }
        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        if (null == kindername) {
            dateWrite.setMsg("亲，暂无相关数据，请登录幼儿园后查看！");
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            ExaminationPage examinationPage = new ExaminationPage(kindername, cName, minpage, maxpage);
            List<TblExamination> tblExaminationList = healtherService.findALLExamination(examinationPage);
            if (0 != tblExaminationList.size()) {
                Integer count = healtherService.findALLExaminationCount(examinationPage).intValue();
                dateWrite.setCode(0);
                dateWrite.setMsg("");
                dateWrite.setCount(count);
                dateWrite.setData(tblExaminationList);
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                request.getSession().setAttribute("cName", cName);
                ResponseUtils.outJson(response, dateWrite);
            } else {
                dateWrite.setMsg("亲，暂无相关数据");
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                ResponseUtils.outJson(response, dateWrite);
            }
        }
    }

    @HealtherSystemLog(operationType = "修改", operationName = "保健员修改体检信息")
    @RequestMapping("/updateExaminationInfo")
    public void updateExaminationInfo(TblExamination tblExamination, HttpServletResponse response) {
        Boolean flag = healtherService.updateExaminationInfo(tblExamination);
        if (flag) {
            ResponseUtils.outHtml(response, "success");
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    @HealtherSystemLog(operationType = "增加", operationName = "保健员新增体检信息")
    @RequestMapping("/addExaminationInfo")
    public void addExaminationInfo(TblExamination tblExamination, HttpServletResponse response) throws ParseException {
        Integer studentid = healtherService.findStudentId(tblExamination.getStudentname(), kindername);
        if (studentid == null) {
            ResponseUtils.outHtml(response, "notname");
        } else {
            tblExamination.setSid(studentid);
            tblExamination.setExaminationtime(new Date());
            List<TblExamination> tblExaminationList = new ArrayList<>();
            tblExaminationList.add(tblExamination);
            Boolean flag = healtherService.addExaminationInfo(tblExaminationList);
            if (flag) {
                ResponseUtils.outHtml(response, "success");
            } else {
                ResponseUtils.outHtml(response, "error");
            }
        }
    }

    @RequestMapping("/showAllMealInfo")
    public void showAllMealInfo(MealPage mealPage, DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        Integer page = Integer.valueOf(request.getParameter("page"));
        Integer limit = Integer.valueOf(request.getParameter("limit"));

        Integer minpage = (page - 1) * limit;
        Integer maxpage = limit;
        if (null == kindername) {
            dateWrite.setMsg("亲，暂无相关数据，请登录幼儿园后查看！");
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            mealPage.setKindername(kindername);
            mealPage.setPage(minpage);
            mealPage.setLimit(maxpage);
            List<TblMeal> tblMealList = healtherService.findAllMealInfo(mealPage);
            if (0 != tblMealList.size()) {
                Integer count = healtherService.findAllMealInfoCount(mealPage).intValue();
                dateWrite.setCode(0);
                dateWrite.setMsg("");
                dateWrite.setCount(count);
                dateWrite.setData(tblMealList);
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                ResponseUtils.outJson(response, dateWrite);
            } else {
                dateWrite.setMsg("亲，暂无相关数据");
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                ResponseUtils.outJson(response, dateWrite);
            }
        }
    }

    @HealtherSystemLog(operationType = "增加", operationName = "保健员新增食谱信息")
    @RequestMapping("/addMealInfo")
    public void addMealInfo(TblMeal tblMeal, TblRecipe tblRecipe, HttpServletRequest request, HttpServletResponse response) throws ParseException {
        String msg = request.getParameter("TblRecipe");
        Gson g = new Gson();
        tblRecipe = g.fromJson(msg, TblRecipe.class);
        List<TblRecipe> tblRecipeList = tblRecipe.getTblRecipeList();
        String mealtime = tblRecipe.getMealtime();
        String time1 = null;
        String time2 = null;
        if (mealtime != null) {
            String[] arr = mealtime.split("~ ");
            time1 = arr[0];
            time2 = arr[arr.length - 1];
        }
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date mealstarttime = format.parse(time1);
        Date mealendtime = format.parse(time2);

        Integer num = healtherService.findExistMealDate(mealstarttime, mealendtime).intValue();

        if (null == kindername) {
            ResponseUtils.outHtml(response, "notkinder");
        } else if (num > 0) {
            ResponseUtils.outHtml(response, "existMealDate");
        } else {
            Integer kinderid = healtherService.findKinderID(kindername);
            List<TblMeal> tblMealList = new ArrayList<>();
            tblMeal.setMealstarttime(mealstarttime);
            tblMeal.setMealendtime(mealendtime);
            tblMeal.setKid(kinderid);
            tblMealList.add(tblMeal);
            Boolean flag = null;
            flag = healtherService.addMealInfo(tblMealList);
            if (flag) {
                Integer mealid = healtherService.findMealID(mealstarttime, mealendtime);
                String info = "暂未配置";
                for (int i = 0; i < tblRecipeList.size(); i++) {
                    tblRecipeList.get(i).setMid(mealid);
                    tblRecipeList.get(i).setKid(kinderid);
                    tblRecipeList.get(i).getFriday();

                    if ("".equals(tblRecipeList.get(i).getMonday())) {
                        tblRecipeList.get(i).setMonday(info);
                    }
                    if ("".equals(tblRecipeList.get(i).getTuesday())) {
                        tblRecipeList.get(i).setTuesday(info);
                    }
                    if ("".equals(tblRecipeList.get(i).getWednesday())) {
                        tblRecipeList.get(i).setWednesday(info);
                    }
                    if ("".equals(tblRecipeList.get(i).getThursday())) {
                        tblRecipeList.get(i).setThursday(info);
                    }
                    if ("".equals(tblRecipeList.get(i).getFriday())) {
                        tblRecipeList.get(i).setFriday(info);
                    }
                }
                flag = healtherService.addRecipeInfo(tblRecipeList);
                if (flag) {
                    ResponseUtils.outHtml(response, "success");
                } else {
                    ResponseUtils.outHtml(response, "error");
                }
            } else {
                ResponseUtils.outHtml(response, "error");
            }
        }
    }

    @RequestMapping("/showAllRecipeInfo")
    public void showAllRecipeInfo(DateWrite dateWrite, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String mealid = request.getParameter("mealid");
        System.out.println("mealid=" + mealid);
        if (null == mealid) {
            dateWrite.setMsg("亲，首次点击编辑膳食的时候可能出现数据丢失，请重新打开，谢谢！");
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            ResponseUtils.outJson(response, dateWrite);
        } else {
            Integer mid = Integer.valueOf(mealid);
            Integer kinderid = healtherService.findKinderID(kindername);
            List<TblRecipe> tblRecipeList = healtherService.findAllRecipeInfo(mid, kinderid);
            if (0 != tblRecipeList.size()) {
                Integer count = healtherService.findAllRecipeInfoCount(mid, kinderid).intValue();
                dateWrite.setCode(0);
                dateWrite.setMsg("");
                dateWrite.setCount(count);
                dateWrite.setData(tblRecipeList);
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                ResponseUtils.outJson(response, dateWrite);
            } else {
                dateWrite.setMsg("亲，暂无相关数据");
                request.setCharacterEncoding("UTF-8");
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8");
                ResponseUtils.outJson(response, dateWrite);
            }
        }
    }

    @HealtherSystemLog(operationType = "修改", operationName = "保健员修改食谱信息")
    @RequestMapping("/updateMealInfo")
    public void updateMealInfo(TblMeal tblMeal, TblRecipe tblRecipe, HttpServletRequest request, HttpServletResponse response) throws ParseException {
        String msg = request.getParameter("TblRecipe");
        Gson g = new Gson();
        tblRecipe = g.fromJson(msg, TblRecipe.class);
        List<TblRecipe> tblRecipeList = tblRecipe.getTblRecipeList();
        String mid = null;
        Boolean flag = null;
        for (int j = 0; j < tblRecipeList.size(); j++) {
            mid = tblRecipeList.get(j).getMid().toString();
        }
        flag = healtherService.updateRecipeInfo(Integer.valueOf(mid));
        if (flag) {
            String info = "暂未配置";
            for (int i = 0; i < tblRecipeList.size(); i++) {

                if ("".equals(tblRecipeList.get(i).getMonday())) {
                    tblRecipeList.get(i).setMonday(info);
                }
                if ("".equals(tblRecipeList.get(i).getTuesday())) {
                    tblRecipeList.get(i).setTuesday(info);
                }
                if ("".equals(tblRecipeList.get(i).getWednesday())) {
                    tblRecipeList.get(i).setWednesday(info);
                }
                if ("".equals(tblRecipeList.get(i).getThursday())) {
                    tblRecipeList.get(i).setThursday(info);
                }
                if ("".equals(tblRecipeList.get(i).getFriday())) {
                    tblRecipeList.get(i).setFriday(info);
                }
            }

            flag = healtherService.addRecipeInfo(tblRecipeList);
            if (flag) {
                ResponseUtils.outHtml(response, "success");
            } else {
                ResponseUtils.outHtml(response, "error");
            }
        } else {
            ResponseUtils.outHtml(response, "error");
        }
    }

    //查找所有宝宝信息
    @RequestMapping("/findStuInfoByKindername")
    public void findStuInfoByKindername(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Gson g = new Gson();
        if (null == kindername) {
            response.getWriter().print("notkinder");
        } else {
            List<TblStudent> tblStudentList = healtherService.findStuInfoByKindername(kindername);//查找所有宝宝信息，用于电子围栏宝宝名称下拉框查询
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
    }

}
