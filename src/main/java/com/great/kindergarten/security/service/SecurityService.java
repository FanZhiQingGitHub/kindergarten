package com.great.kindergarten.security.service;

import com.great.kindergarten.admin.mapper.AdminMapper;
import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.security.mapper.SecurityMapper;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import com.great.kindergarten.security.resultbean.PickUpInfoPage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class SecurityService {

    @Resource
    private SecurityMapper securityMapper;

    public String findSecurityStatus(String securityname){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityname",securityname);
        return securityMapper.findSecurityStatus(securitymap);
    }

    public TblSecurity securityLogin(String securityname,String securitypwd){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityname",securityname);
        securitymap.put("securitypwd",securitypwd);
        return securityMapper.securityLogin(securitymap);
    }

    public TblSecurity findSecurityId(String securityname){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityname",securityname);
        return securityMapper.findSecurityId(securitymap);
    }

    public Boolean updateSecurityPwd(String securitypwd,String securityid){
        Map<String, String> securitymap = new LinkedHashMap<>();
        securitymap.put("securitypwd",securitypwd);
        securitymap.put("securityid",securityid);
        return securityMapper.updateSecurityPwd(securitymap);
    }

    @Transactional
    public Boolean resetSecuritypwd(String securityphone){
        Map<String,String> securitymap = new LinkedHashMap<>();
        securitymap.put("securityphone",securityphone);
        return securityMapper.resetSecuritypwd(securitymap);
    }

    public List<TblClass> findAllClass(){
        return securityMapper.findAllClass();
    }

    public List<TblStudent> findALLPickUpInfo(PickUpInfoPage pickUpInfoPage){
        return securityMapper.findALLPickUpInfo(pickUpInfoPage);
    }

    public Long findALLPickUpInfoCount(PickUpInfoPage pickUpInfoPage){
        return securityMapper.findALLPickUpInfoCount(pickUpInfoPage);
    }

    public List<TblDate> findALLPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage){
        return securityMapper.findALLPickUpDetailInfo(pickUpInfoDetailPage);
    }


}
