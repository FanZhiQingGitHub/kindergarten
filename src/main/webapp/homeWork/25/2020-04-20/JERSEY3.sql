--1
select s.sname,t1.*,t2.* from
(select * from sc where cid ='01') t1,(select * from sc where cid ='02') t2,student s
where t1.score>t2.score and t1.sid=t2.sid and s.sid=t1.sid;
--2
select * from
(select * from sc where cid ='01') t1,(select * from sc where cid ='02') t2
where  t1.sid=t2.sid;
--3
select * from
(select * from sc where cid ='01') t1 left join (select * from sc where cid ='02') t2
on t1.sid=t2.sid;
--4
select * from sc where sid not in (select sid from sc where cid ='01') and cid='02';
--5
SELECT s.sid,s.sname,round (AVG(c.score),2)平均成绩 FROM student s,sc c WHERE s.sid=c.sid GROUP BY s.sid, s.sname HAVING AVG(c.score)>=60;
--6
select * from student  where sid in(select sid from sc); 
--7
select s.sid,s.sname,ft.sumscore,ft.coursecount 
from student s left join(select sc.sid,sum(sc.score) sumscore,count(sc.cid) coursecount from sc group by sc.sid) ft 
on s.sid=ft.sid;
--8
select * from student a where EXISTS(SELECT sid from sc b where a.sid=b.sid);
--9
SELECT COUNT(*) FROM TEACHER WHERE TNAME LIKE '李%';
--10
select * from student where sid in(select sid from sc where cid=(select cid from course where tid=(select tid from teacher where tname ='张三')));
--11
select Student.*
from Student left join SC
on Student.SID = SC.SID
group by Student.SID , Student.Sname , Student.Sage , Student.Ssex having count(CID) < (select count(CID) from Course) order by student.sid;
--12
select * from student where sid in( select distinct sid from sc where cid in(select cid from sc where sid ='01')) ;
--13



--14
select student.* from student where student.SID not in
(select distinct sc.SID from sc , course , teacher where sc.CID = course.CID and course.TID = teacher.TID and teacher.tname = '张三')
order by student.SID;
--15
select student.SID , student.sname , cast(avg(score) as decimal(18,2)) avg_score from student , sc
where student.SID = SC.SID and student.SID in (select SID from SC where score < 60 group by SID having count(1) >= 2)
group by student.SID , student.sname;
--16
select s.*,sc.score from sc,student s where s.sid = sc.sid and cid='01' and score<60 order by score;
--17


select s.sid,round(avg(sc.score),2) from sc,student s where s.sid = sc.sid  group by s.sid;
--18
select cid ,max(score),min(score),avg(score) from sc group by cid;
--19???????
select t1.cid,t1.cname,max(score),min(score),avg(score)

from (select sc.sid,sc.cid,sc.score,c.cname from sc,course c where sc.cid=c.cid) t1
group by t1.cid,t1.cname;                    
--20
SELECT cid,count(*) c FROM sc group by cid order by c,cid ;
--21
select DENSE_RANK()over(partition by cid order by score) 排名,sc.* from sc ;
--22
select RANK()over(partition by cid order by score) 排名,sc.* from sc ;
--23
select dense_rank()over(order by s.总分) 排名,s.*  from
(select sid,sum(score) 总分 from sc group by sid ) s;
--24
select rank()over(order by s.总分) 排名,s.*  from
(select sid,sum(score) 总分 from sc group by sid ) s;
--27
select cid,count(sid) from sc group by cid;

--28
select s.sid,s.sname,g.cot 选修课课程数 
from student s,(select sid,count(cid) cot from sc group by sid having count(cid) =2) g
where s.sid=g.sid;

--29
select t1.man,t2.woman 
from (select count(*) man from student where ssex ='男') t1,(select count(*) woman from student where ssex ='女') t2;
--30
select * from student where sname like'%风%';
--31
select  sname,count(*) from student group by sname,ssex having count(*)>1 ;
--32
select * from student where TO_CHAR(sage) like '%1990%';

--33
select cid,avg(score) ag from sc group by cid order by ag desc,cid;
--34

select s.sid,s.sname,t1.grade from
(select sid,avg(score)grade from sc group by sid having avg(score)>85) t1,student s
where s.sid = t1.sid
; 
--35
select s.sname,sc.score 
from sc,student s
where sc.cid = (select cid from course where cname='数学') and s.sid=sc.sid
and sc.score<60
;
--37
select s.sname,c.cname,sc.score
from student s,course c,sc
where s.sid=sc.sid and sc.cid=c.cid and sc.score>70
;
--38
select s.sname,c.cname,sc.score
from student s,course c,sc
where s.sid=sc.sid and sc.cid=c.cid and sc.score<60
;
--39
select s.sid,s.sname,sc.cid,sc.score from student s,sc 
where sc.score>=80 and sc.sid=s.sid and sc.cid='01';
--40
select c.cname,sc.cid,count(sc.sid) from sc,course c 
where sc.cid=c.cid group by c.cname,sc.cid;
--41
select s.*,g.grade from student s,(
select sc.sid,max(sc.score) grade from student s,sc
where sc.cid=(select c.cid from course c,teacher t
where c.tid=t.tid and t.tname='张三') and sc.sid=s.sid
group by sc.cid,sc.sid) g where g.sid=s.sid and rownum =1 order by g.grade desc;
--42
select s.*,g.grade from student s,(
select sc.sid,max(sc.score) grade from student s,sc
where sc.cid=(select c.cid from course c,teacher t
where c.tid=t.tid and t.tname='张三') and sc.sid=s.sid
group by sc.cid,sc.sid) g where g.sid=s.sid and rownum =1 order by g.grade desc;
--43
select distinct s.* from sc s, sc c 
where s.sid != c.sid and s.score = c.score and s.cid!=c.cid;

--45
select cid,count(sid) from sc group by cid having count(sid)>=5;
--46
select sid,count(cid) from sc group by sid having count(cid)>=2;
--47
select * from student where sid in(
select sid from sc group by sid having count(cid)= (select count(cid) from course ));
--48
select s.sname ,to_char(sysdate,'yyyy') -to_char(s.sage,'yyyy') 年龄 from student s;

--49
select s.sname ,to_char(sysdate,'yyyy') -to_char(s.sage,'yyyy') 年龄1,
case when to_char(sysdate,'mm-dd') <to_char(s.sage,'mm-dd')
then to_char(sysdate,'yyyy') -to_char(s.sage,'yyyy') -1
else to_char(sysdate,'yyyy') -to_char(s.sage,'yyyy')
end 年龄 from student s;




-- select * from  where group by having order by 
--rownum
--round  case when

