use QuanLiSinhVien;

select * from subject
order by Credit desc
limit 2;

select s.*, m.Mark from subject s
join mark m on s.SubID = m.SubID
order by m.Mark desc
limit 1;

select st.StudentId,st.StudentName, avg(mark) as AverageMark
from student st 
left join Mark m on st.StudentID = m.StudentID
group by st.StudentID
order by AverageMark desc;


