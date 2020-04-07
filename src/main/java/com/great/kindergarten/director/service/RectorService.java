package com.great.kindergarten.director.service;

import com.great.kindergarten.director.mapper.RectorMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

@Service
public class RectorService {

    @Resource
    private RectorMapper rectorMapper;

}
