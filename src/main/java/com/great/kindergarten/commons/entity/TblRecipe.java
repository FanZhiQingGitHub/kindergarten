package com.great.kindergarten.commons.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 食谱表信息实体类
 */
public class TblRecipe {
    private Integer recipeid;
    private String recipename;
    private String recipedetail;
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    private Date recipetime;

    public TblRecipe() {
    }

    public TblRecipe(Integer recipeid, String recipename, String recipedetail, Date recipetime) {
        this.recipeid = recipeid;
        this.recipename = recipename;
        this.recipedetail = recipedetail;
        this.recipetime = recipetime;
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

    public String getRecipedetail() {
        return recipedetail;
    }

    public void setRecipedetail(String recipedetail) {
        this.recipedetail = recipedetail;
    }

    public Date getRecipetime() {
        return recipetime;
    }

    public void setRecipetime(Date recipetime) {
        this.recipetime = recipetime;
    }

    @Override
    public String toString() {
        return "TblRecipe{" +
                "recipeid=" + recipeid +
                ", recipename='" + recipename + '\'' +
                ", recipedetail='" + recipedetail + '\'' +
                ", recipetime=" + recipetime +
                '}';
    }
}
