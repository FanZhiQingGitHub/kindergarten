package com.great.kindergarten.parent.service;

import com.great.kindergarten.parent.entity.Parent;
import com.great.kindergarten.parent.mapper.ParentMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

/**
 * @author Administrator
 */
@Service
public class ParentService {

    @Resource
    private ParentMapper parentMapper;

    public ParentService()
    {
    }




    /**
     * 家长端口登陆方法
     * @param parentName
     * @param parentPwd
     * @return
     */
    public Parent parentLogin(String parentName,String parentPwd){
        return parentMapper.parentLogin(parentName,parentPwd);
    }
}
