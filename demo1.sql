create database if not exists a1122i1;
use a1122i1;

create table student(
id int primary key,
`name` varchar(50),
`point` float
);

insert into student(id,name,point)
          values(1,"chanh",6),
                (2,"chanh",7);
insert into student values(3,"chanh",6);

select * from student;
select name,point from student;

update student

set name="tran van chanh"
where id=3;
SET SQL_SAFE_UPDATES=0;
update student
set name="Nguyen van a";
SET SQL_SAFE_UPDATES=1;

delete from student where id=3;

alter table student add column class_id int;
alter table student drop column class_id;

drop table student;

select * from instructor ;

select * from student where name like 'chanh';

select * from student where point in(4,6,8) ;

select distinct (point) from student;

select point, count(point) as so_luong
from student 
group by point;

select point ,count(point) as so_luong
from student
where point>6
group by point;

select point ,count(point) as so_luong
from student
where point>6
group by point
having so_luong>=2;

select s.*
from student s
order by s.point desc , s.name asc;








