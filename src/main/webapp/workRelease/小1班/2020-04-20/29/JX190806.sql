--------------------------------------------------------
--  文件已创建 - 星期三-三月-04-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence ADID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."ADID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 5 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ASID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."ASID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence BOID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."BOID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 21 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CASH
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."CASH"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 19 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."CID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 5 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LOG
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."LOG"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LOGSID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."LOGSID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MENUID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."MENUID"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 23 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PAID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."PAID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 3 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence QID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."QID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 23 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TDID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."TDID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TMID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."TMID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence USERID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."USERID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 2 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ZID
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."ZID"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 5 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ZZZ
--------------------------------------------------------

   CREATE SEQUENCE  "JX190806"."ZZZ"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table APPOINTTIME
--------------------------------------------------------

  CREATE TABLE "JX190806"."APPOINTTIME" 
   (	"TDID" NUMBER(*,0), 
	"TIME" DATE, 
	"BAID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ASSESSREPORT
--------------------------------------------------------

  CREATE TABLE "JX190806"."ASSESSREPORT" 
   (	"ASID" NUMBER(*,0), 
	"SCORE" NUMBER(*,0), 
	"REUSLT" VARCHAR2(500 BYTE), 
	"CONTENT" VARCHAR2(1000 BYTE), 
	"TIME" DATE, 
	"USERID" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table BACKSTAGES
--------------------------------------------------------

  CREATE TABLE "JX190806"."BACKSTAGES" 
   (	"BAID" NUMBER(*,0), 
	"BAACCOUNT" VARCHAR2(100 BYTE), 
	"BAPWD" VARCHAR2(100 BYTE), 
	"BANAME" VARCHAR2(100 BYTE), 
	"RID" NUMBER(*,0), 
	"SCHOOL" VARCHAR2(100 BYTE), 
	"POSITION" VARCHAR2(100 BYTE), 
	"HEADURL" VARCHAR2(100 BYTE), 
	"INTRODUCE" VARCHAR2(1000 BYTE), 
	"BAMONEY" NUMBER(*,0), 
	"COTIME" DATE, 
	"BASTATE" VARCHAR2(50 BYTE), 
	"BAPRICE" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table BOOKING
--------------------------------------------------------

  CREATE TABLE "JX190806"."BOOKING" 
   (	"BOID" NUMBER(*,0), 
	"BOTIME" DATE, 
	"YMONEY" NUMBER(*,0), 
	"BOZOOM" VARCHAR2(100 BYTE), 
	"QUESTIONS" VARCHAR2(100 BYTE), 
	"BOSTATE" VARCHAR2(100 BYTE), 
	"BOCONTENT" VARCHAR2(1000 BYTE), 
	"RETIME" DATE, 
	"USERID" NUMBER(*,0), 
	"BAID" NUMBER(*,0), 
	"SUBTIME" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CASHFLOWSTATEMENT
--------------------------------------------------------

  CREATE TABLE "JX190806"."CASHFLOWSTATEMENT" 
   (	"CASHID" NUMBER(*,0), 
	"CID" NUMBER(*,0), 
	"ONAME" VARCHAR2(100 BYTE), 
	"INAME" VARCHAR2(100 BYTE), 
	"CSTATE" VARCHAR2(100 BYTE), 
	"CMONEY" NUMBER(*,0), 
	"CTIME" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CONSULTANTEVALUATION
--------------------------------------------------------

  CREATE TABLE "JX190806"."CONSULTANTEVALUATION" 
   (	"CID" NUMBER(*,0), 
	"CONTENT" VARCHAR2(1000 BYTE), 
	"TIME" DATE, 
	"USERID" NUMBER(*,0), 
	"BAID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ITEMBANK
--------------------------------------------------------

  CREATE TABLE "JX190806"."ITEMBANK" 
   (	"TMID" NUMBER(*,0), 
	"TMCONTENT" VARCHAR2(500 BYTE), 
	"A" VARCHAR2(100 BYTE), 
	"B" VARCHAR2(100 BYTE), 
	"C" VARCHAR2(100 BYTE), 
	"D" VARCHAR2(100 BYTE), 
	"TMZOOM" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table LOGS
--------------------------------------------------------

  CREATE TABLE "JX190806"."LOGS" 
   (	"LOGSID" NUMBER(*,0), 
	"TIME" DATE, 
	"EVENT" VARCHAR2(500 BYTE), 
	"RECORDER" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MENUS
--------------------------------------------------------

  CREATE TABLE "JX190806"."MENUS" 
   (	"MENUID" NUMBER(*,0), 
	"MENUNAME" VARCHAR2(100 BYTE), 
	"MENUURL" VARCHAR2(100 BYTE), 
	"MENUPARENTID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PARAMETERS
--------------------------------------------------------

  CREATE TABLE "JX190806"."PARAMETERS" 
   (	"PAID" NUMBER(*,0), 
	"PARAMETER" VARCHAR2(100 BYTE), 
	"PATYPE" VARCHAR2(100 BYTE), 
	"VALUE" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RELATIONS
--------------------------------------------------------

  CREATE TABLE "JX190806"."RELATIONS" 
   (	"QXID" NUMBER(*,0), 
	"RID" NUMBER(*,0), 
	"MENUID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table USERTABLE
--------------------------------------------------------

  CREATE TABLE "JX190806"."USERTABLE" 
   (	"USERID" NUMBER(*,0), 
	"UACCOUNT" VARCHAR2(100 BYTE), 
	"UPWD" VARCHAR2(100 BYTE), 
	"UNAME" VARCHAR2(100 BYTE), 
	"UMONEY" NUMBER(*,0), 
	"USEX" VARCHAR2(100 BYTE), 
	"UAGE" NUMBER(*,0), 
	"UTEL" NUMBER(*,0), 
	"UADDRESS" VARCHAR2(100 BYTE), 
	"USTATE" VARCHAR2(100 BYTE), 
	"CUTIME" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ZOOM
--------------------------------------------------------

  CREATE TABLE "JX190806"."ZOOM" 
   (	"ZID" NUMBER(*,0), 
	"ZNAME" VARCHAR2(50 BYTE), 
	"BAID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into JX190806.APPOINTTIME
SET DEFINE OFF;
REM INSERTING into JX190806.ASSESSREPORT
SET DEFINE OFF;
REM INSERTING into JX190806.BACKSTAGES
SET DEFINE OFF;
Insert into JX190806.BACKSTAGES (BAID,BAACCOUNT,BAPWD,BANAME,RID,SCHOOL,POSITION,HEADURL,INTRODUCE,BAMONEY,COTIME,BASTATE,BAPRICE) values (1,'xtf123','f62c899dfbf3b32f5c7757c87f69a210','谢霆锋',1,'香港大学','教授',null,'自我良好',198,null,'启用',99);
Insert into JX190806.BACKSTAGES (BAID,BAACCOUNT,BAPWD,BANAME,RID,SCHOOL,POSITION,HEADURL,INTRODUCE,BAMONEY,COTIME,BASTATE,BAPRICE) values (4,'cgx123','be39e220847dec5ecb3d61e2a99874ab','陈冠希',1,'香港大学','教授',null,'张柏芝好',297,to_date('27-2月 -20','DD-MON-RR'),'启用',99);
Insert into JX190806.BACKSTAGES (BAID,BAACCOUNT,BAPWD,BANAME,RID,SCHOOL,POSITION,HEADURL,INTRODUCE,BAMONEY,COTIME,BASTATE,BAPRICE) values (2,'zsf123','913ae5890d0b23e61b4cc0596f216ecd','张三丰',2,'厦门大学','教授',null,'武当山创始人',0,to_date('27-2月 -20','DD-MON-RR'),'启用',null);
Insert into JX190806.BACKSTAGES (BAID,BAACCOUNT,BAPWD,BANAME,RID,SCHOOL,POSITION,HEADURL,INTRODUCE,BAMONEY,COTIME,BASTATE,BAPRICE) values (3,'wds123','074000b6616983c50ec5b50b9292989c','武当山',1,'武当山大学','教授',null,'十大富豪肯定是回复客户客户，快女那地方返回给客户端发，难得看见很多回复可见活动空间风华高科',99,to_date('27-2月 -20','DD-MON-RR'),'启用',99);
REM INSERTING into JX190806.BOOKING
SET DEFINE OFF;
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (20,to_date('03-3月 -20','DD-MON-RR'),99,'亲子关系','空手道解放呼唤','已预约',null,null,1,1,to_date('04-3月 -20','DD-MON-RR'));
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (3,to_date('29-2月 -20','DD-MON-RR'),99,'亲子关系','打开附件','已预约',null,null,1,3,to_date('29-2月 -20','DD-MON-RR'));
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (7,to_date('29-2月 -20','DD-MON-RR'),99,'亲子关系','进入到士大夫','已预约',null,null,1,1,to_date('29-2月 -20','DD-MON-RR'));
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (1,to_date('29-2月 -20','DD-MON-RR'),99,'亲子关系','亲自好啊','已确认',null,null,1,1,to_date('29-2月 -20','DD-MON-RR'));
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (4,to_date('29-2月 -20','DD-MON-RR'),99,'亲子关系','扣税的回访客户','已诊断','的身份快速返回的数据是客户反馈',to_date('03-3月 -20','DD-MON-RR'),1,3,to_date('29-2月 -20','DD-MON-RR'));
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (5,to_date('29-2月 -20','DD-MON-RR'),99,'情绪管理','发客户看','已评价','是客户看是否是否',to_date('03-3月 -20','DD-MON-RR'),1,4,to_date('29-2月 -20','DD-MON-RR'));
Insert into JX190806.BOOKING (BOID,BOTIME,YMONEY,BOZOOM,QUESTIONS,BOSTATE,BOCONTENT,RETIME,USERID,BAID,SUBTIME) values (6,to_date('29-2月 -20','DD-MON-RR'),99,'情绪管理','会计法哈哈','已确认',null,null,1,4,to_date('29-2月 -20','DD-MON-RR'));
REM INSERTING into JX190806.CASHFLOWSTATEMENT
SET DEFINE OFF;
Insert into JX190806.CASHFLOWSTATEMENT (CASHID,CID,ONAME,INAME,CSTATE,CMONEY,CTIME) values (11,1,null,'用户','充值/收入',1000,to_date('02-3月 -20','DD-MON-RR'));
Insert into JX190806.CASHFLOWSTATEMENT (CASHID,CID,ONAME,INAME,CSTATE,CMONEY,CTIME) values (18,1,null,'武当山','咨询支出',99,to_date('03-3月 -20','DD-MON-RR'));
Insert into JX190806.CASHFLOWSTATEMENT (CASHID,CID,ONAME,INAME,CSTATE,CMONEY,CTIME) values (14,1,null,'陈冠希','咨询支出',99,to_date('03-3月 -20','DD-MON-RR'));
Insert into JX190806.CASHFLOWSTATEMENT (CASHID,CID,ONAME,INAME,CSTATE,CMONEY,CTIME) values (15,1,null,'陈冠希','咨询支出',99,to_date('03-3月 -20','DD-MON-RR'));
Insert into JX190806.CASHFLOWSTATEMENT (CASHID,CID,ONAME,INAME,CSTATE,CMONEY,CTIME) values (17,1,null,'谢霆锋','咨询支出',99,to_date('03-3月 -20','DD-MON-RR'));
Insert into JX190806.CASHFLOWSTATEMENT (CASHID,CID,ONAME,INAME,CSTATE,CMONEY,CTIME) values (12,1,null,'用户','充值/收入',1000,to_date('02-3月 -20','DD-MON-RR'));
REM INSERTING into JX190806.CONSULTANTEVALUATION
SET DEFINE OFF;
Insert into JX190806.CONSULTANTEVALUATION (CID,CONTENT,TIME,USERID,BAID) values (4,'上空的飞机韩国时间方便的',to_date('04-3月 -20','DD-MON-RR'),1,4);
REM INSERTING into JX190806.ITEMBANK
SET DEFINE OFF;
REM INSERTING into JX190806.LOGS
SET DEFINE OFF;
REM INSERTING into JX190806.MENUS
SET DEFINE OFF;
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (1,'账户管理',null,0);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (2,'资金账户','userMessServlet?method=counselorsAccount',1);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (3,'业务管理',null,0);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (4,'预约时间和设置',null,3);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (5,'预约诊断','userMessServlet?method=reservationDiagnose',3);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (6,'账户管理',null,0);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (7,'客户管理','userMessServlet?method=toUser',6);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (8,'后台用户管理','userMessServlet?method=backstageUser',6);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (9,'业务管理',null,0);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (10,'咨询管理',null,9);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (11,'培训管理',null,9);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (12,'在线评估管理',null,9);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (13,'资格认证管理',null,9);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (14,'统计报表',null,0);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (15,'用户统计',null,14);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (16,'渠道量统计','userMessServlet?method=reservationStatistics',14);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (17,'系统管理',null,0);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (18,'菜单管理',null,17);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (19,'角色管理',null,17);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (20,'权限管理',null,17);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (21,'日志查看',null,17);
Insert into JX190806.MENUS (MENUID,MENUNAME,MENUURL,MENUPARENTID) values (22,'参数配置',null,17);
REM INSERTING into JX190806.PARAMETERS
SET DEFINE OFF;
Insert into JX190806.PARAMETERS (PAID,PARAMETER,PATYPE,VALUE) values (1,'用户默认密码','密码','e10adc3949ba59abbe56e057f20f883e');
Insert into JX190806.PARAMETERS (PAID,PARAMETER,PATYPE,VALUE) values (2,'管理默认密码','密码','e10adc3949ba59abbe56e057f20f883e');
REM INSERTING into JX190806.RELATIONS
SET DEFINE OFF;
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (1,1,1);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (2,1,2);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (3,1,3);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (4,1,4);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (5,1,5);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (6,2,6);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (7,2,7);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (8,2,8);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (9,2,9);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (10,2,10);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (11,2,11);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (12,2,12);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (13,2,13);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (14,2,14);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (15,2,15);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (16,2,16);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (17,2,17);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (18,2,18);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (19,2,19);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (20,2,20);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (21,2,21);
Insert into JX190806.RELATIONS (QXID,RID,MENUID) values (22,2,22);
REM INSERTING into JX190806.USERTABLE
SET DEFINE OFF;
Insert into JX190806.USERTABLE (USERID,UACCOUNT,UPWD,UNAME,UMONEY,USEX,UAGE,UTEL,UADDRESS,USTATE,CUTIME) values (1,'zbz123','987768cb584d4ad569dbd782cd39d844','张柏芝',1406,'女',20,13112345678,'水库地方','启用',to_date('28-2月 -20','DD-MON-RR'));
REM INSERTING into JX190806.ZOOM
SET DEFINE OFF;
Insert into JX190806.ZOOM (ZID,ZNAME,BAID) values (4,'情绪管理',4);
Insert into JX190806.ZOOM (ZID,ZNAME,BAID) values (2,'情绪管理',2);
Insert into JX190806.ZOOM (ZID,ZNAME,BAID) values (1,'亲子关系',1);
Insert into JX190806.ZOOM (ZID,ZNAME,BAID) values (3,'亲子关系',3);
--------------------------------------------------------
--  DDL for Index PK_LOGS
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_LOGS" ON "JX190806"."LOGS" ("LOGSID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_RELATIONS
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_RELATIONS" ON "JX190806"."RELATIONS" ("QXID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ZOOM
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_ZOOM" ON "JX190806"."ZOOM" ("ZID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_APPOINTTIME
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_APPOINTTIME" ON "JX190806"."APPOINTTIME" ("TDID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_USERTABLE
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_USERTABLE" ON "JX190806"."USERTABLE" ("USERID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_BACKSTAGES
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_BACKSTAGES" ON "JX190806"."BACKSTAGES" ("BAID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_MENUS
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_MENUS" ON "JX190806"."MENUS" ("MENUID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ASSESSREPORT
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_ASSESSREPORT" ON "JX190806"."ASSESSREPORT" ("ASID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_ITEMBANK
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_ITEMBANK" ON "JX190806"."ITEMBANK" ("TMID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_CASHFLOWSTATEMENT
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_CASHFLOWSTATEMENT" ON "JX190806"."CASHFLOWSTATEMENT" ("CASHID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_BOOKING
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_BOOKING" ON "JX190806"."BOOKING" ("BOID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_PARAMETERS
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_PARAMETERS" ON "JX190806"."PARAMETERS" ("PAID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_CONSULTANTEVALUATION
--------------------------------------------------------

  CREATE UNIQUE INDEX "JX190806"."PK_CONSULTANTEVALUATION" ON "JX190806"."CONSULTANTEVALUATION" ("CID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Trigger TIB_APPOINTTIME
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_APPOINTTIME" before insert
on appointtime for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "tdid" uses sequence tdid
    select tdid.NEXTVAL INTO :new.tdid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_APPOINTTIME" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_ASSESSREPORT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_ASSESSREPORT" before insert
on assessreport for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "asid" uses sequence asid
    select asid.NEXTVAL INTO :new.asid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_ASSESSREPORT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_BACKSTAGES
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_BACKSTAGES" before insert
on backstages for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "baid" uses sequence adid
    select adid.NEXTVAL INTO :new.baid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_BACKSTAGES" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_BOOKING" before insert
on booking for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "boid" uses sequence boid
    select boid.NEXTVAL INTO :new.boid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_BOOKING" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_CASHFLOWSTATEMENT
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_CASHFLOWSTATEMENT" before insert
on cashflowstatement for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "cashid" uses sequence cash
    select cash.NEXTVAL INTO :new.cashid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_CASHFLOWSTATEMENT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_CONSULTANTEVALUATION
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_CONSULTANTEVALUATION" before insert
on consultantevaluation for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "cid" uses sequence cid
    select cid.NEXTVAL INTO :new.cid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_CONSULTANTEVALUATION" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_ITEMBANK
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_ITEMBANK" before insert
on Itembank for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "tmid" uses sequence tmid
    select tmid.NEXTVAL INTO :new.tmid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_ITEMBANK" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_LOGS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_LOGS" before insert
on logs for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "logsid" uses sequence logsid
    select logsid.NEXTVAL INTO :new.logsid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_LOGS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_MENUS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_MENUS" before insert
on Menus for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "menuid" uses sequence menuid
    select menuid.NEXTVAL INTO :new.menuid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_MENUS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_PARAMETERS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_PARAMETERS" before insert
on parameters for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "paid" uses sequence paid
    select paid.NEXTVAL INTO :new.paid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_PARAMETERS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_RELATIONS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_RELATIONS" before insert
on Relations for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "qxid" uses sequence qid
    select qid.NEXTVAL INTO :new.qxid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_RELATIONS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_USERTABLE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_USERTABLE" before insert
on UserTable for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "userid" uses sequence userid
    select userid.NEXTVAL INTO :new.userid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_USERTABLE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIB_ZOOM
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "JX190806"."TIB_ZOOM" before insert
on zoom for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "zid" uses sequence zid
    select zid.NEXTVAL INTO :new.zid from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;

/
ALTER TRIGGER "JX190806"."TIB_ZOOM" ENABLE;
--------------------------------------------------------
--  DDL for Package PDTYPES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "JX190806"."PDTYPES" 
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;

/
--------------------------------------------------------
--  DDL for Package Body INTEGRITYPACKAGE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "JX190806"."INTEGRITYPACKAGE" AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;

/
--------------------------------------------------------
--  Constraints for Table BOOKING
--------------------------------------------------------

  ALTER TABLE "JX190806"."BOOKING" ADD CONSTRAINT "PK_BOOKING" PRIMARY KEY ("BOID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."BOOKING" MODIFY ("BOID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MENUS
--------------------------------------------------------

  ALTER TABLE "JX190806"."MENUS" ADD CONSTRAINT "PK_MENUS" PRIMARY KEY ("MENUID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."MENUS" MODIFY ("MENUID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LOGS
--------------------------------------------------------

  ALTER TABLE "JX190806"."LOGS" ADD CONSTRAINT "PK_LOGS" PRIMARY KEY ("LOGSID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."LOGS" MODIFY ("LOGSID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USERTABLE
--------------------------------------------------------

  ALTER TABLE "JX190806"."USERTABLE" ADD CONSTRAINT "PK_USERTABLE" PRIMARY KEY ("USERID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."USERTABLE" MODIFY ("USERID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BACKSTAGES
--------------------------------------------------------

  ALTER TABLE "JX190806"."BACKSTAGES" ADD CONSTRAINT "PK_BACKSTAGES" PRIMARY KEY ("BAID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."BACKSTAGES" MODIFY ("BAID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CASHFLOWSTATEMENT
--------------------------------------------------------

  ALTER TABLE "JX190806"."CASHFLOWSTATEMENT" ADD CONSTRAINT "PK_CASHFLOWSTATEMENT" PRIMARY KEY ("CASHID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."CASHFLOWSTATEMENT" MODIFY ("CASHID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ZOOM
--------------------------------------------------------

  ALTER TABLE "JX190806"."ZOOM" ADD CONSTRAINT "PK_ZOOM" PRIMARY KEY ("ZID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."ZOOM" MODIFY ("ZID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARAMETERS
--------------------------------------------------------

  ALTER TABLE "JX190806"."PARAMETERS" ADD CONSTRAINT "PK_PARAMETERS" PRIMARY KEY ("PAID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."PARAMETERS" MODIFY ("PAID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table RELATIONS
--------------------------------------------------------

  ALTER TABLE "JX190806"."RELATIONS" ADD CONSTRAINT "PK_RELATIONS" PRIMARY KEY ("QXID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."RELATIONS" MODIFY ("QXID" NOT NULL ENABLE);
 
  ALTER TABLE "JX190806"."RELATIONS" MODIFY ("RID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table APPOINTTIME
--------------------------------------------------------

  ALTER TABLE "JX190806"."APPOINTTIME" ADD CONSTRAINT "PK_APPOINTTIME" PRIMARY KEY ("TDID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."APPOINTTIME" MODIFY ("TDID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ASSESSREPORT
--------------------------------------------------------

  ALTER TABLE "JX190806"."ASSESSREPORT" ADD CONSTRAINT "PK_ASSESSREPORT" PRIMARY KEY ("ASID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."ASSESSREPORT" MODIFY ("ASID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ITEMBANK
--------------------------------------------------------

  ALTER TABLE "JX190806"."ITEMBANK" ADD CONSTRAINT "PK_ITEMBANK" PRIMARY KEY ("TMID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."ITEMBANK" MODIFY ("TMID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CONSULTANTEVALUATION
--------------------------------------------------------

  ALTER TABLE "JX190806"."CONSULTANTEVALUATION" ADD CONSTRAINT "PK_CONSULTANTEVALUATION" PRIMARY KEY ("CID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "JX190806"."CONSULTANTEVALUATION" MODIFY ("CID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table APPOINTTIME
--------------------------------------------------------

  ALTER TABLE "JX190806"."APPOINTTIME" ADD CONSTRAINT "FK_APPOINTT_REFERENCE_BACKSTAG" FOREIGN KEY ("BAID")
	  REFERENCES "JX190806"."BACKSTAGES" ("BAID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ASSESSREPORT
--------------------------------------------------------

  ALTER TABLE "JX190806"."ASSESSREPORT" ADD CONSTRAINT "FK_ASSESSRE_REFERENCE_USERTABL" FOREIGN KEY ("USERID")
	  REFERENCES "JX190806"."USERTABLE" ("USERID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BOOKING
--------------------------------------------------------

  ALTER TABLE "JX190806"."BOOKING" ADD CONSTRAINT "FK_BOOKING_REFERENCE_BACKSTAG" FOREIGN KEY ("BAID")
	  REFERENCES "JX190806"."BACKSTAGES" ("BAID") ENABLE;
 
  ALTER TABLE "JX190806"."BOOKING" ADD CONSTRAINT "FK_BOOKING_REFERENCE_USERTABL" FOREIGN KEY ("USERID")
	  REFERENCES "JX190806"."USERTABLE" ("USERID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CONSULTANTEVALUATION
--------------------------------------------------------

  ALTER TABLE "JX190806"."CONSULTANTEVALUATION" ADD CONSTRAINT "FK_CONSULTA_REFERENCE_BACKSTAG" FOREIGN KEY ("BAID")
	  REFERENCES "JX190806"."BACKSTAGES" ("BAID") ENABLE;
 
  ALTER TABLE "JX190806"."CONSULTANTEVALUATION" ADD CONSTRAINT "FK_CONSULTA_REFERENCE_USERTABL" FOREIGN KEY ("USERID")
	  REFERENCES "JX190806"."USERTABLE" ("USERID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RELATIONS
--------------------------------------------------------

  ALTER TABLE "JX190806"."RELATIONS" ADD CONSTRAINT "FK_RELATION_REFERENCE_MENUS" FOREIGN KEY ("MENUID")
	  REFERENCES "JX190806"."MENUS" ("MENUID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ZOOM
--------------------------------------------------------

  ALTER TABLE "JX190806"."ZOOM" ADD CONSTRAINT "FK_ZOOM_REFERENCE_BACKSTAG" FOREIGN KEY ("BAID")
	  REFERENCES "JX190806"."BACKSTAGES" ("BAID") ENABLE;
