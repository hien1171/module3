create database if not exists quanlisinhvien;
use quanlisinhvien;
 create table Class(
 id int auto_increment primary key,
 `name` varchar(50)
 );
 
 create table Teacher(
  id int auto_increment primary key,
  `name` varchar(50),
  age varchar(50),
  country varchar(50)
  );

