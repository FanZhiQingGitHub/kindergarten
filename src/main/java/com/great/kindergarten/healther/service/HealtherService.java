package com.great.kindergarten.healther.service;

import com.great.kindergarten.commons.entity.TblClass;
import com.great.kindergarten.commons.entity.TblExamination;
import com.great.kindergarten.commons.entity.TblHealther;
import com.great.kindergarten.healther.mapper.HealtherMapper;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class HealtherService {

    @Resource
    private HealtherMapper healtherMapper;

    public String findHealtherStatus(String healthername){
        Map<String,String> healthermap = new LinkedHashMap<>();
        healthermap.put("healthername",healthername);
        return healtherMapper.findHealtherStatus(healthermap);
    }


    public TblHealther healtherLogin(String healthername, String healtherpwd){
        Map<String,String> healthermap = new LinkedHashMap<>();
        healthermap.put("healthername",healthername);
        healthermap.put("healtherpwd",healtherpwd);
        return healtherMapper.healtherLogin(healthermap);
    }

    public TblHealther findHealtherId(String healthername){
        Map<String,String> healthermap = new LinkedHashMap<>();
        healthermap.put("healthername",healthername);
        return healtherMapper.findHealtherId(healthermap);
    }

    public Boolean updateHealtherPwd(String healtherpwd,String healtherid){
        Map<String,String> healthermap = new LinkedHashMap<>();
        healthermap.put("healtherpwd",healtherpwd);
        healthermap.put("healtherid",healtherid);
        return healtherMapper.updateHealtherPwd(healthermap);
    }

    public List<TblExamination> findALLExamination(ExaminationPage examinationPage){
        return healtherMapper.findALLExamination(examinationPage);
    }

    public Long findALLExaminationCount(ExaminationPage examinationPage){
        return healtherMapper.findALLExaminationCount(examinationPage);
    }

    public List<TblClass> findAllClass(){
        return healtherMapper.findAllClass();
    }

    public Boolean updateExaminationInfo(TblExamination tblExamination){
        return healtherMapper.updateExaminationInfo(tblExamination);
    }

    public Integer findStudentId(String studentname){
        Map<String, String> studentmap = new LinkedHashMap<>();
        studentmap.put("studentname",studentname);
        return healtherMapper.findStudentId(studentmap);
    }

    public Boolean addExaminationInfo(List<TblExamination> tblExaminationList){
        return healtherMapper.addExaminationInfo(tblExaminationList);
    }

}
