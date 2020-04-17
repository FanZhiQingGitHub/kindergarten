package com.great.kindergarten.parent.controller;

import com.google.gson.Gson;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.parent.service.ParentService;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import com.great.kindergarten.security.util.DateUtil;
import com.great.kindergarten.util.FaceRecognitionUtils;
import com.great.kindergarten.util.MD5Utils;
import javafx.scene.Parent;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/parent")
public class ParentController {

    private String parentname;

    @Resource
    private ParentService parentService;

    @RequestMapping("/toUrl/{url}")
    public String toUrl(@PathVariable String url) {
        return "parentJsp/" + url;
    }

    //-------------人脸识别考勤---------------
    /*
    1.日期
    2.家长类型（妈妈或者爸爸）
    3.当前时间段：如8:30
    4.需要判断是上午还是下午
    5.需要pmid（下午id，一天要连在一起）
    6.需要孩子id
    7.需要日期区间id（需要添加本周一到本周日）
    8.如果下午或上午没打卡的话默认要插入请假或者其它默认数据
     */
    @RequestMapping("/regFaceId")
    public void regFaceId(HttpServletRequest request, HttpServletResponse response) {
        String face = request.getParameter("face");
        FaceRecognitionUtils.faceRegister(face, "testPhoto1");
        System.out.println("face=" + face);
    }

    @RequestMapping("/addStuTime")
    public void addStuTime(HttpServletRequest request, HttpServletResponse response) {
        String face = request.getParameter("face");
        FaceRecognitionUtils.identify(face, null);
        System.out.println("face=" + face);
    }

    @RequestMapping("/parentFaceRecognition")
    @ResponseBody
    public Result parentFaceRecognition(String face) {
        //人脸识别调用 (可根据id单张图片比较)
        Result result = new Result();

        FaceRecognitionUtils.identify(face, null);

        return result;
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

        String workreleaseid = url.split("@@")[0];

        String dayTime = url.split("@@")[1].split("@@@")[0];

        String downFileName = url.split("@@@")[1];

        //获取文件的实际路径
        String databasePath = "/homeWork/" + workreleaseid + "/" + dayTime + "/" + downFileName;


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
        String workreleaseid = request.getParameter("workreleaseid");

        OutputStream os = null;
        InputStream inputStream = null;
        String fileName = null;
        String filePath = null;

        //获取当前时间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String dayTime = df.format(new Date());


        String path = request.getServletContext().getRealPath("/homeWork/" + workreleaseid + "/" + dayTime);

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
            String databasePath = workreleaseid + "@@" + dayTime + "@@@" + fileName;


            //数据库插入操作
            TblWork tblWork = new TblWork();
            tblWork.setWorkreleasedetail(workName);
            tblWork.setWorkresult("完成");
            tblWork.setWfinishtime(new Date());
            tblWork.setWorkurl(databasePath);
            tblWork.setSid(sid);
            tblWork.setStudentname(name);
            tblWork.setCid(cid);
            tblWork.setWorkreleaseid(workreleaseid);
            tblWork.setPid(3);
            tblWork.setParentname("张飞爸爸");

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
        res.setData("{\'src\':\'" + path + "\'}");
        return res;
    }


    @RequestMapping("/kidHomeWorkList")
    @ResponseBody
    public TableDate kidHomeWorkList(HttpServletRequest request, SearchCondition searchCondition) {
//    查询家长的孩子的作业列表方法
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
//        Integer cid = Integer.valueOf(request.getParameter("cid"));
        //设置查找人id
        searchCondition.setParentId(3);
        //返回查找的结果
        return parentService.kidHomeWorkList(searchCondition, 1);
    }

    @RequestMapping("/getKids")
    @ResponseBody
    public Result getKids(HttpServletRequest request) {
//    查询家长id 查询孩子列表
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        //返回查找的结果
        return parentService.getKids(3);
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
            String parentcode = builder.toString();
            request.getSession().setAttribute("parentcode", parentcode);
            //.. 生成图片发送到浏览器 --相当于下载
            ImageIO.write(image, "jpg", response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


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
                    request.getSession().setAttribute("onlineParent", loginParent);
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


}
