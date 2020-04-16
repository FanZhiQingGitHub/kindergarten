package com.great.kindergarten.main;

import com.great.kindergarten.commons.entity.TblKinder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class MainService {

    @Resource
    private MainMapper mainMapper;

    public TblKinder findKinderStatus(String kindername){
        Map<String, String> kindermap = new LinkedHashMap<>();
        kindermap.put("kindername",kindername);
        return mainMapper.findKinderStatus(kindermap);
    }

    public TblKinder kinderLogin(String kindername,String kinderpwd){
        Map<String, String> kindermap = new LinkedHashMap<>();
        kindermap.put("kindername",kindername);
        kindermap.put("kinderpwd",kinderpwd);
        return mainMapper.kinderLogin(kindermap);
    }

}
