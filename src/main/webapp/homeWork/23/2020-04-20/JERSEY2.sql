--ͶӰ,��ѯȫ��ѧ������
create view vw as select s.*,sc.cno,sc.grade from zy_student s, zy_sc sc where s.sno = sc.sno ;
select * from vw ;
select * from vw where sno='AF121101';
--�����ӣ���ѯѧ��AF121101ͬѧ�������͸��Ƴɼ�
insert into vw as select * from zy_sc where zy_sc.sno = as.sno;
select distinct v.* from vw v,vw w where v.sno=w.sno and v.sno='AF121101';
--��ѯ���л��ﻥ��С��
select distinct mgr from zy_student ;

--��ѯȫ��ѧ�������ͳ������
select to_char(sysdate,'yyyy')from dual;
select s.sname,(select to_char(sysdate,'yyyy')from dual)-s.sage ��� from zy_student s;
--����������18~28����ѧ������
select DISTINCT sname from vw where sage>18 and sage<28 ;

--��ѯ����android��ѧ����A��ѧ����
select * from zy_student where sno like 'A%';

--��ѯ���Ǵ�ѧ�ǵ�ѧ����WF��ѧ����
select * from zy_student where sno  like 'WF%';

--��ѯN2�γ̲������ѧ��ѧ��
select s.sno from zy_sc sc,zy_student s where sc.sno = s.sno and sc.grade<60 and sc.cno='N2';
select * from vw where cno='N2' and grade<60;
--��ѯandroidѧ��������
select count(*) from zy_student where sno like 'A%';
---��ѯ��N3�ɼ���������
select count(*) from vw where cno='N3';
--����AF1211���һ�׶ε�ƽ���֣�A1�ļ���һ�׶Σ�
select avg(sc.grade) from zy_student s,zy_sc sc where sc.sno = s.sno and sc.cno='A1' and s.sno like'AF1211%';

select avg(grade) from zy_sc where sno like'AF1211%' and cno='A1';
--������γ̵�����
select count(*),cno from zy_sc group by cno;

--ͳ������4�ſ�����ѧ����ѧ��
select sno from zy_sc group by sno having count(*)>=4;
