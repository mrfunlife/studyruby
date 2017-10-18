
SELECT CustomerName, City FROM Customers;
SELECT * FROM Customers;

SELECT DISTINCT Country FROM Customers;
SELECT COUNT(DISTINCT Country) FROM Customers;
 SELECT * FROM Customers
WHERE CustomerID=1;

SELECT * FROM Customers
WHERE Country='Germany' AND City='Berlin';


SELECT * FROM Customers
WHERE Country='Germany' AND (City='Berlin' OR City='München');

SELECT * FROM Customers
WHERE NOT Country='Germany';

SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC; => Sap xep


UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;


DELETE FROM Customers
WHERE CustomerName='Alfreds Futterkiste';

DELETE FROM table_name;

SELECT MAX(column_name)
FROM table_name
WHERE condition;

SELECT * FROM Customers
WHERE CustomerName LIKE '_r%';

SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');


SELECT * FROM Customers
WHERE Country IN (SELECT Country FROM Suppliers); => Chon khac hang trong cac vung tu  1 nha cung cap''


- Aliases -

SELECT CustomerID as ID, CustomerName AS Customer
FROM Customers;

SELECT CustomerName AS Customer, ContactName AS [Contact Person]
FROM Customers;

SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;


SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;


- Join -

SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT Customers.name, Buys_Products.id
FROM Customers
LEFT JOIN Buys_Products ON Customers.id = Buys_Products.customers_id;


- Group  By -

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;


SELECT Customers.name as Name, count(Buys_Products.customers_id) as NumberOfBuy
FROM Customers
LEFT JOIN Buys_Products ON Customers.id = Buys_Products.customers_id
GROUP BY Customers.name;


- SubQuery -

Ta tìm xem ông nào có lương lớn hơn lương của ông Kochhar

select last_name, salary
from employees
where salary > (select salary from employees where last_name = 'Kochhar');


sử dụng subquery trong mệnh đề HAVING. Tìm những job có mức lương trung bình thấp hơn mức lương trung bình của cả công ty

  select job_id, avg(salary)
  from employees
  group by job_id
  having avg(salary) < (select avg(salary) from employees);


tìm những người có lương bằng với lương thấp nhất của phòng ban 50 hoặc 80

 select last_name, salary, department_id
    from employees
   where salary in
   (
   select min(salary)
   from employees
   where department_id in (50, 80)
   group by department_id
   );

Ta dem xem co bao nhieu nguoi lam linh:
select count(*) => Dem ca bang?
   from employees e
 where e.employee_id not in
  (
    select mgr.manager_id
    from employees mgr
    where mgr.manager_id is not null
   );

Tim nhung nguoi da tung thay doi cong viec

select employee_id, last_name
from employees e
where exists
(
  select * from job_history j where j.employee_id = e.employee_id
 );
