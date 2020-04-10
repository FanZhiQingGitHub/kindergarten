package com.great.kindergarten.security.service;

import com.great.kindergarten.admin.mapper.AdminMapper;
import com.great.kindergarten.commons.entity.TblSecurity;
import com.great.kindergarten.security.mapper.SecurityMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.LinkedHashMap;
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

}
