package com.great.kindergarten.commons.entity;

import java.util.List;

/**
 * 食谱表信息实体类
 */
public class TblRecipe {
    private Integer recipeid;
    private String recipename;
    private String monday;
    private String tuesday;
    private String wednesday;
    private String thursday;
    private String friday;
    private Integer mid;

    private List<TblRecipe> tblRecipeList;
    private String mealtime;

    public TblRecipe() {
    }

    public TblRecipe(Integer recipeid, String recipename, String monday, String tuesday, String wednesday, String thursday, String friday, Integer mid) {
        this.recipeid = recipeid;
        this.recipename = recipename;
        this.monday = monday;
        this.tuesday = tuesday;
        this.wednesday = wednesday;
        this.thursday = thursday;
        this.friday = friday;
        this.mid = mid;
    }

    public Integer getRecipeid() {
        return recipeid;
    }

    public void setRecipeid(Integer recipeid) {
        this.recipeid = recipeid;
    }

    public String getRecipename() {
        return recipename;
    }

    public void setRecipename(String recipename) {
        this.recipename = recipename;
    }

    public String getMonday() {
        return monday;
    }

    public void setMonday(String monday) {
        this.monday = monday;
    }

    public String getTuesday() {
        return tuesday;
    }

    public void setTuesday(String tuesday) {
        this.tuesday = tuesday;
    }

    public String getWednesday() {
        return wednesday;
    }

    public void setWednesday(String wednesday) {
        this.wednesday = wednesday;
    }

    public String getThursday() {
        return thursday;
    }

    public void setThursday(String thursday) {
        this.thursday = thursday;
    }

    public String getFriday() {
        return friday;
    }

    public void setFriday(String friday) {
        this.friday = friday;
    }

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public List<TblRecipe> getTblRecipeList() {
        return tblRecipeList;
    }

    public void setTblRecipeList(List<TblRecipe> tblRecipeList) {
        this.tblRecipeList = tblRecipeList;
    }

    public String getMealtime() {
        return mealtime;
    }

    public void setMealtime(String mealtime) {
        this.mealtime = mealtime;
    }

    @Override
    public String toString() {
        return "TblRecipe{" +
                "recipeid=" + recipeid +
                ", recipename='" + recipename + '\'' +
                ", monday='" + monday + '\'' +
                ", tuesday='" + tuesday + '\'' +
                ", wednesday='" + wednesday + '\'' +
                ", thursday='" + thursday + '\'' +
                ", friday='" + friday + '\'' +
                ", mid=" + mid +
                ", tblRecipeList=" + tblRecipeList +
                ", mealtime='" + mealtime + '\'' +
                '}';
    }
}
