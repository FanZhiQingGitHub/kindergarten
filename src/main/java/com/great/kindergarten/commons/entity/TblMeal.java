package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 膳食信息实体类
 */
public class TblMeal {
    private Integer mealid;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date mealstarttime;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date mealendtime;
    private Integer kid;


    public TblMeal() {
    }

    public TblMeal(Integer mealid, Date mealstarttime, Date mealendtime, Integer kid) {
        this.mealid = mealid;
        this.mealstarttime = mealstarttime;
        this.mealendtime = mealendtime;
        this.kid = kid;
    }

    public Integer getMealid() {
        return mealid;
    }

    public void setMealid(Integer mealid) {
        this.mealid = mealid;
    }

    public Date getMealstarttime() {
        return mealstarttime;
    }

    public void setMealstarttime(Date mealstarttime) {
        this.mealstarttime = mealstarttime;
    }

    public Date getMealendtime() {
        return mealendtime;
    }

    public void setMealendtime(Date mealendtime) {
        this.mealendtime = mealendtime;
    }

    public Integer getKid() {
        return kid;
    }

    public void setKid(Integer kid) {
        this.kid = kid;
    }

    @Override
    public String toString() {
        return "TblMeal{" +
                "mealid=" + mealid +
                ", mealstarttime=" + mealstarttime +
                ", mealendtime=" + mealendtime +
                ", kid=" + kid +
                '}';
    }
}
