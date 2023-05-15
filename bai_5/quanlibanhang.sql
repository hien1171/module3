create database manageProducts;
use manageProducts;

create table Products(
Id   INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
productCode varchar(50),
productName varchar(50),
productPrice double,
productAmount int,
productDescription varchar(50),
productStatus bit);

alter table Products add index uniqueIndex(productCode);
 alter table Products add index compositeIndex(productName,productPrice);

create view productView as
select productName, productPrice
from Products;

delimitter //
create procedure getInfor()
begin
select * from Products
end //
DELIMITER;







