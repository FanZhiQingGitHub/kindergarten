package com.great.kindergarten.healther.service;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.mapper.HealtherMapper;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import com.great.kindergarten.healther.resultbean.MealPage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
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

    @Transactional
    public Boolean updateHealtherPwd(String healtherpwd,String healtherid){
        Map<String,String> healthermap = new LinkedHashMap<>();
        healthermap.put("healtherpwd",healtherpwd);
        healthermap.put("healtherid",healtherid);
        return healtherMapper.updateHealtherPwd(healthermap);
    }

    @Transactional
    public Boolean resetHealtherpwd(String healtherphone){
        Map<String,String> healthermap = new LinkedHashMap<>();
        healthermap.put("healtherphone",healtherphone);
        return healtherMapper.resetHealtherpwd(healthermap);
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

    @Transactional
    public Boolean updateExaminationInfo(TblExamination tblExamination){
        return healtherMapper.updateExaminationInfo(tblExamination);
    }

    public Integer findStudentId(String studentname){
        Map<String, String> studentmap = new LinkedHashMap<>();
        studentmap.put("studentname",studentname);
        return healtherMapper.findStudentId(studentmap);
    }

    @Transactional
    public Boolean addExaminationInfo(List<TblExamination> tblExaminationList){
        return healtherMapper.addExaminationInfo(tblExaminationList);
    }

    @Transactional
    public Boolean addMealInfo(List<TblMeal> tblMealList){
        return healtherMapper.addMealInfo(tblMealList);
    }

    public Integer findMealID(Date mealstarttime,Date mealendtime){
        Map<String,Date> mealMap = new LinkedHashMap<>();
        mealMap.put("mealstarttime",mealstarttime);
        mealMap.put("mealendtime",mealendtime);
        return healtherMapper.findMealID(mealMap);
    }

    public List<TblMeal> findAllMealInfo(MealPage mealPage){
        return healtherMapper.findAllMealInfo(mealPage);
    }

    public Long findAllMealInfoCount(MealPage mealPage){
        return healtherMapper.findAllMealInfoCount(mealPage);
    }

    @Transactional
    public Boolean addRecipeInfo(List<TblRecipe> tblRecipeList){
        return healtherMapper.addRecipeInfo(tblRecipeList);
    }

    public List<TblRecipe> findAllRecipeInfo(Integer mealid){
        Map<String, Integer> mealIdMap = new LinkedHashMap<>();
        mealIdMap.put("mealid",mealid);
        return healtherMapper.findAllRecipeInfo(mealIdMap);
    }

    public Long findAllRecipeInfoCount(Integer mealid){
        Map<String, Integer> mealIdMap = new LinkedHashMap<>();
        mealIdMap.put("mealid",mealid);
        return healtherMapper.findAllRecipeInfoCount(mealIdMap);
    }

    @Transactional
    public Boolean updateRecipeInfo(Integer mid){
        return healtherMapper.updateRecipeInfo(mid);
    }

    public List<TblCampus> findHealtherNews(String kindername){
        Map<String, String> KinderNewsmap = new LinkedHashMap<>();
        KinderNewsmap.put("kindername",kindername);
        return healtherMapper.findHealtherNews(KinderNewsmap);
    }
}
