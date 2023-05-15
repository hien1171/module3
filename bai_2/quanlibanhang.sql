create database if not exists quanlibanhang;
use quanlibanhang;

create table Customer(
cID int auto_increment primary key,
cName varchar(50),
cAge int);

create table `Order`(
oID int auto_increment primary key,
oDate date,
oTotalPrice float,
cID int ,
foreign key (cID) references customer(cID));

create table product(
pID int primary key,
pName varchar(50),
pPrice float);

create table orderDetail(
  oID int,
  pID int,
  primary key(oID,pID),
  foreign key(oID) references `Order`(oID),
  foreign key(pID) references product(pID),
  odQTY int);
  
