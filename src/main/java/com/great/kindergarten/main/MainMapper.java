package com.great.kindergarten.main;

import com.great.kindergarten.commons.entity.TblKinder;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface MainMapper {

    public TblKinder findKinderStatus(Map<String, String> kindermap);

    public TblKinder kinderLogin(Map<String, String> kindermap);

}
