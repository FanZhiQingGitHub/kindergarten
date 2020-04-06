package com.great.kindergarten.parent.controller;

import com.great.kindergarten.parent.service.ParentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/parent")
public class ParentController {

    @Resource
    private ParentService parentService;

    @RequestMapping("/toUrl/{url}")
    public String toUrl(@PathVariable  String url) {

        return "parentJsp/"+url;
    }





}
