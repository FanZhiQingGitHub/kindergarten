package com.great.kindergarten.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class MainController {

    @RequestMapping("/main")
    public String Main() {
        return "mainjsp/main";
    }
    @RequestMapping("/about")
    public String About() {
        return "mainjsp/about";
    }

    @RequestMapping("/detail")
    public String Detail() {
        return "mainjsp/details";
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
