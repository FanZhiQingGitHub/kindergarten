package com.great.kindergarten.healther.javabean;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 *保健员信息实体类
 */
public class TblHealther {

   private Integer healtherid;
   private String healthername;
   private String healtherpwd;
   private String healthersex;
   private Integer healtherage;
   private String healtheradd;
   private Integer healtherphone;
   @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
   private Date healtherregtime;
   private String healtherstatus;
   private Integer rid;

}
