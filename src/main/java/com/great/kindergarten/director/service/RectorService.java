package com.great.kindergarten.director.service;

import com.great.kindergarten.director.javabean.TblRector;
import com.great.kindergarten.director.mapper.RectorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

@Service
public class RectorService {

    @Resource
    private RectorMapper rectorMapper;

    //登录查询对应的内容
    public TblRector findRector(TblRector tblRector){
        return rectorMapper.findRector(tblRector);
    }
}
