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

    public TblMeal() {
    }

    public TblMeal(Integer mealid, Date mealstarttime, Date mealendtime) {
        this.mealid = mealid;
        this.mealstarttime = mealstarttime;
        this.mealendtime = mealendtime;
    }

    public Integer getMealid() {
        return mealid;
    }

    public Date getMealstarttime() {
        return mealstarttime;
    }

    public Date getMealendtime() {
        return mealendtime;
    }

    @Override
    public String toString() {
        return "TblMeal{" +
                "mealid=" + mealid +
                ", mealstarttime=" + mealstarttime +
                ", mealendtime=" + mealendtime +
                '}';
    }
}
