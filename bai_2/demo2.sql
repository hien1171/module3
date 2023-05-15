 
create table jame(
username varchar(50) primary key,
`password` varchar(50)
);
create table class(
id int auto_increment primary key,
`name` varchar(50)
);
create table room(
id int auto_increment primary key,
`name` varchar(50),
class_id int,
foreign key(class_id) references class(id)
);
create table student(
id int auto_increment primary key,
`name` varchar(50),
birthday date,
gender boolean,
email varchar(50),
`point` float,
class_id int,
username varchar(50) unique,
foreign key(class_id) references class(id),
foreign key(username) references jame(username)
);
create table instructor(
id int auto_increment primary key,
`name` varchar(50),
birthday date,
salary float
);

create table instructor_class(
instructor_id int,
class_id int,
start_day date,
end_day date,
primary key(instructor_id,class_id),
foreign key(instructor_id) references instructor(id),
foreign key(class_id) references class(id)
);