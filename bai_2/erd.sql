create database if not exists erd;
use erd;

create table phieuxuat(
 sopx  int auto_increment primary key,
 ngayxuat date);
 
 create table vatu(
 mavtu varchar(50) primary key,
 tienvtu float
 );
 
create table phieunhap(
 sopx  int auto_increment primary key,
 ngaynhap date
);

create table dondh(
  sodh  int auto_increment primary key,
  ngaydh date
  );

create table nhacc(
mancc varchar(50) primary key,
tienncc float,
diachi varchar(50) ,
sdt int);




 