use zzz
create table z1(id int,name varchar(10),age datetime,sex varchar(10));

insert into z1 values(1 , '赵雷' , '1990-01-01' , '男');
insert into z1 values(2 , '钱电' , '1990-12-21' , '男');
insert into z1 values(3 , '孙风' , '1990-05-20' , '男');
insert into z1 values(4 , '李云' , '1990-08-06' , '男');
insert into z1 values(5 , '周梅' , '1991-12-01' , '女');
insert into z1 values(6 , '吴兰' , '1992-03-01' , '女');
insert into z1 values(7 , '郑竹' , '1989-07-01' , '女');
insert into z1 values(8 , '王菊' , '1990-01-20' , '女');


create table c1(id int,name varchar(10),teacherId int);
insert into c1 values(1 , '语文' , 2);
insert into c1 values(2 , '数学' , 1);
insert into c1 values(3 , '英语' , 3);

create table t1(id int,name varchar(10));
insert into t1 values(1 , '张三');
insert into t1 values(2 , '李四');
insert into t1 values(3 , '王五');

create table sc1(studentId int,courseId varchar(10),score decimal(18,1));
insert into sc1 values(1 , 1 , 80);
insert into sc1 values(1 , 2 , 90);
insert into sc1 values(1 , 3 , 99);
insert into sc1 values(2 , 1 , 70);
insert into sc1 values(2 , 2 , 60);
insert into sc1 values(2 , 3 , 80);
insert into sc1 values(3 , 1 , 80);
insert into sc1 values(3 , 2 , 80);
insert into sc1 values(3 , 3 , 80);
insert into sc1 values(4 , 1 , 50);
insert into sc1 values(4 , 2 , 30);
insert into sc1 values(4 , 3 , 20);
insert into sc1 values(5 , 1 , 76);
insert into sc1 values(5 , 2 , 87);
insert into sc1 values(6 , 1 , 31);
insert into sc1 values(6 , 3 , 34);
insert into sc1 values(7 , 2 , 89);
insert into sc1 values(7 , 3 , 98);



# 1.查询同时存在1课程和2课程的情况
select t1.id, t1.name, t1.age, t1.sex
from(
select stu.id, stu.name, stu.age, stu.sex
from z1 as stu
left join sc1 as cou
on stu.id = cou.studentId
where cou.courseId = '1') t1
inner join(
select stu.id, stu.name, stu.age, stu.sex
from z1 as stu
left join sc1 as cou
on stu.id = cou.studentId
where cou.courseId = '2') t2
on t1.id = t2.id

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select stu.id, stu.name, avg(co.score) avg_score
from z1 as stu
left join sc1 as co
on stu.id = co.studentId
group by stu.id, stu.name
having avg(co.score) >= 60

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select stu.id, stu.name, stu.age, stu.sex
from z1 as stu
left join sc1 as co
on stu.id = co.studentId
group by stu.id, stu.name, stu.age, stu.sex
having avg(co.score) is null

# 5.查询所有有成绩的SQL
select cou.studentId, cou.courseId, cou.score
from sc1 as cou
where cou.score is not null

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select t1.id, t1.name, t1.age, t1.sex
from(
select stu.id, stu.name, stu.age, stu.sex
from z1 as stu
left join sc1 as co
on stu.id = co.studentId
where co.courseId = '1') t1
inner join(
select stu.id, stu.name, stu.age, stu.sex
from student as stu
left join student_course as cou
on stu.id = cou.studentId
where cou.courseId = '2') t2
on t1.id = t2.id

# 7.检索1课程分数小于60，按分数降序排列的学生信息
select stu.id, stu.name, stu.age, stu.sex
from z1 as stu
left join sc1 as co
on stu.id = co.studentId
where co.courseId = '1'
and co.score < 60
order by co.score desc

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select courseId, avg(score)
from sc1
group by courseId
order by 2 desc, 1

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select stu.name, co.score
from sc1 as co
inner join c1 as t
on t.id = convert(int, co.score)
and t.name = '数学'
inner join z1 as stu
on co.studentId = stu.id
where co.score < 60
