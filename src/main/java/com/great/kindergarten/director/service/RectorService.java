package com.great.kindergarten.director.service;

import com.great.kindergarten.commons.entity.TblRector;
import com.great.kindergarten.director.mapper.RectorMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
public class RectorService {

    @Resource
    private RectorMapper rectorMapper;

    //登录查询对应的内容
    public TblRector findRector(TblRector tblRector){
        return rectorMapper.findRector(tblRector);
    }

    //判断密码是不是正确的
    public TblRector selectoldPwd(TblRector tblRector){
        return rectorMapper.selectoldPwd(tblRector);
    }

    //更新密码
    @Transactional
    public int updateByIdPwd(TblRector tblRector){
        return rectorMapper.updateByIdPwd(tblRector);
    }
}
