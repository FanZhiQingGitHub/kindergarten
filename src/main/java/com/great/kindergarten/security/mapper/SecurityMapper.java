package com.great.kindergarten.security.mapper;

import com.great.kindergarten.commons.entity.TblHealther;
import com.great.kindergarten.commons.entity.TblSecurity;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface SecurityMapper {

    public String findSecurityStatus(Map<String, String> securitymap);

    public TblSecurity securityLogin(Map<String, String> securitymap);

    public TblSecurity findSecurityId(Map<String, String> securitymap);

    public Boolean updateSecurityPwd(Map<String, String> securitymap);

}
