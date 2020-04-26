package com.great.kindergarten.main;

import com.great.kindergarten.commons.entity.TblKinder;
import com.great.kindergarten.main.annotation.MainSystemLog;
import com.great.kindergarten.util.FaceRecognitionUtils;
import com.great.kindergarten.util.MD5Utils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.great.kindergarten.util.ResponseUtils;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@Controller
@RequestMapping("/main")
public class MainController {

    private String maincode;
    private String kindername;

    @Resource
    private MainService mainService;

    @RequestMapping("/path/{url}")
    public String showMain(@PathVariable(value = "url") String path) {
        return "mainjsp/" + path;
    }


    @RequestMapping("/parent")
    public String Parent() {
        return "parentJsp/parentLogin";
    }

    @RequestMapping("/teacher")
    public String Teacher() {
        return "teacherjsp/teacherLogin";
    }

    @RequestMapping("/healther")
    public String Healther() {
        return "healtherjsp/healtherLogin";
    }

    @RequestMapping("/security")
    public String Security() {
        return "securityjsp/securityLogin";
    }

    @RequestMapping("/director")
    public String Rector() {
        return "directorjsp/directorLogin";
    }

    @RequestMapping("/admin")
    public String Admin() {
        return "adminjsp/adminLogin";
    }

    @RequestMapping("/error")
    public String Error() {
        return "errorjsp/error";
    }

}
