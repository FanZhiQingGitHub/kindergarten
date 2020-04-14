package com.great.kindergarten.security.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.security.resultbean.PickUpInfoDetailPage;
import com.great.kindergarten.security.resultbean.PickUpInfoPage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SecurityMapper {

    public String findSecurityStatus(Map<String, String> securitymap);

    public TblSecurity securityLogin(Map<String, String> securitymap);

    public TblSecurity findSecurityId(Map<String, String> securitymap);

    public Boolean updateSecurityPwd(Map<String, String> securitymap);

    public List<TblClass> findAllClass();

    public List<TblStudent> findALLPickUpInfo(PickUpInfoPage pickUpInfoPage);

    public Long findALLPickUpInfoCount(PickUpInfoPage pickUpInfoPage);

    public List<TblDate> findALLPickUpDetailInfo(PickUpInfoDetailPage pickUpInfoDetailPage);

}
