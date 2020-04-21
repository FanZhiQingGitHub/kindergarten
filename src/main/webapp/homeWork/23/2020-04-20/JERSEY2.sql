--投影,查询全体学生姓名
create view vw as select s.*,sc.cno,sc.grade from zy_student s, zy_sc sc where s.sno = sc.sno ;
select * from vw ;
select * from vw where sno='AF121101';
--内连接，查询学生AF121101同学的姓名和各科成绩
insert into vw as select * from zy_sc where zy_sc.sno = as.sno;
select distinct v.* from vw v,vw w where v.sno=w.sno and v.sno='AF121101';
--查询所有互帮互助小组
select distinct mgr from zy_student ;

--查询全体学生姓名和出生年份
select to_char(sysdate,'yyyy')from dual;
select s.sname,(select to_char(sysdate,'yyyy')from dual)-s.sage 年份 from zy_student s;
--查找年龄在18~28岁间的学生姓名
select DISTINCT sname from vw where sage>18 and sage<28 ;

--查询所有android的学生（A的学生）
select * from zy_student where sno like 'A%';

--查询不是大学城的学生（WF的学生）
select * from zy_student where sno  like 'WF%';

--查询N2课程不及格的学生学号
select s.sno from zy_sc sc,zy_student s where sc.sno = s.sno and sc.grade<60 and sc.cno='N2';
select * from vw where cno='N2' and grade<60;
--查询android学生总人数
select count(*) from zy_student where sno like 'A%';
---查询有N3成绩的总人数
select count(*) from vw where cno='N3';
--计算AF1211班第一阶段的平均分（A1的即第一阶段）
select avg(sc.grade) from zy_student s,zy_sc sc where sc.sno = s.sno and sc.cno='A1' and s.sno like'AF1211%';

select avg(grade) from zy_sc where sno like'AF1211%' and cno='A1';
--求各个课程的人数
select count(*),cno from zy_sc group by cno;

--统计修了4门课以上学生的学号
select sno from zy_sc group by sno having count(*)>=4;
