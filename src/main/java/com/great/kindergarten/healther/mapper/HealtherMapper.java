package com.great.kindergarten.healther.mapper;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.healther.resultbean.ExaminationPage;
import com.great.kindergarten.healther.resultbean.MealPage;
import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface HealtherMapper {

    public String findHealtherStatus(Map<String, String> healthermap);

    public TblHealther healtherLogin(Map<String, String> healthermap);

    public TblKinder findHealtherKinder(Map<String, String> healthermap);

    public TblHealther findHealtherId(Map<String, String> healthermap);

    public Boolean updateHealtherPwd(Map<String, String> healthermap);

    public Integer findExistHealtherName(Map<String, String> healthermap);

    public Boolean resetHealtherpwd(Map<String, String> healthermap);

    public List<TblExamination> findALLExamination(ExaminationPage examinationPage);

    public Long findALLExaminationCount(ExaminationPage examinationPage);

    public List<TblClass> findAllClass(Map<String, String> kindermap);

    public Boolean updateExaminationInfo(TblExamination tblExamination);

    public Integer findStudentId(Map<String, String> studentmap);

    public Boolean addExaminationInfo(List<TblExamination> tblExaminationList);

    public Boolean addMealInfo(List<TblMeal> tblMealList);

    public Integer findMealID(Map<String, Date> mealMap);

    public Boolean addRecipeInfo(List<TblRecipe> tblRecipeList);

    public List<TblMeal> findAllMealInfo(MealPage mealPage);

    public Long findAllMealInfoCount(MealPage mealPage);

    public List<TblRecipe> findAllRecipeInfo(Map<String, Integer> mealIdMap);

    public Long findAllRecipeInfoCount(Map<String, Integer> mealIdMap);

    public Boolean updateRecipeInfo(Integer mid);

    public List<TblCampus> findHealtherNews(Map<String, String> KinderNewsmap);

    public Integer findKinderID(Map<String, String> KinderMap);

    public List<TblStudent> findStuInfoByKindername(Map<String, String> KinderMap);

    public int addLog(TblSyslog log);//系统日志

}
