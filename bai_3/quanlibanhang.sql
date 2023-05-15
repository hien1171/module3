use quanlibanhang;

INSERT INTO Customer
VALUES
(1,'Minh Quan',10),
(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);

INSERT INTO `Order` (oID, cID, oDate)
VALUES
(1, 1, '2006-03-21'),
(2, 2, '2006-03-23'),
(3, 1, '2006-03-16');

INSERT INTO product
VALUES
(1,'May Giat',3),
(2,'Tu Lanh',5),
(3,'Dieu Hoa',7),
(4,'Quat',1),
(5,'Bep Dien',2);



INSERT INTO orderdetail
VALUES
(1,1,1),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);


SELECT oID, oDate, oTotalPrice
FROM `order`;



SELECT c.cName AS CustomerName, p.pName AS ProductName
FROM Customer c
INNER JOIN`Order` o ON c.cID = o.cID
INNER JOIN orderDetail od ON o.oID = od.oID
INNER JOIN Product p ON od.pID = p.pID;

select c.cID, c.cName, p.pName
from customer c
join `Order` o on c.cID = o.cID
join orderdetail od on od.oID = o.oID
join product p on p.pID = od.pID ;

select  c.cName from customer c
left join  `Order` o on c.cID = o.cID
where o.cID is null;


select od.oID,o.oDate,sum(od.odQTY*p.pPrice) as price
from orderdetail od join product p on od.pID = p.pID
join `Order` o on o.oID = od.oID
group by od.oID
