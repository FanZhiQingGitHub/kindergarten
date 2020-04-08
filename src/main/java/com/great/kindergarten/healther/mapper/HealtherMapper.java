package com.great.kindergarten.healther.mapper;

import com.great.kindergarten.commons.entity.TblClass;
import com.great.kindergarten.commons.entity.TblExamination;
import com.great.kindergarten.commons.entity.TblHealther;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface HealtherMapper {

    public String findHealtherStatus(Map<String, String> healthermap);

    public TblHealther healtherLogin(Map<String, String> healthermap);

    public TblHealther findHealtherId(Map<String, String> healthermap);

    public Boolean updateHealtherPwd(Map<String, String> healthermap);

    public List<TblExamination> findALLExamination(ExaminationPage examinationPage);

    public Long findALLExaminationCount(ExaminationPage examinationPage);

    public List<TblClass> findAllClass();
}
