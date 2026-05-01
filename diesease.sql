-- regions
CREATE TABLE dimensional.regions_dim
  (
    region_id int NOT NULL PRIMARY KEY,
    region_name VARCHAR( 50 ) NOT NULL
  );
  
insert into dimensional.regions_dim(region_id,region_name)
(select distinct region_id,region_name from public.regions);

select * from dimensional.regions_dim;

-- countries table
CREATE TABLE dimensional.countries_dim
  (
    country_id   CHAR( 2 ) PRIMARY KEY  ,
    country_name VARCHAR( 50 ) NOT NULL
  );
select * from dimensional.countries_dim;


-- employees
CREATE TABLE dimensional.employees_dim
  (
    employee_id int PRIMARY KEY,
    first_name VARCHAR( 255 ) NOT NULL,
    last_name  VARCHAR( 255 ) NOT NULL,
    email      VARCHAR( 255 ) NOT NULL,
    phone      VARCHAR( 50 ) NOT NULL ,
    hire_date  DATE NOT NULL          ,
    manager_id  int      , -- fk
    job_title  VARCHAR( 255 ) NOT NULL
  );
select * from dimensional.employees_dim;
-- product category
CREATE TABLE dimensional.diesease_categories_dim
  (
    diesease_id int PRIMARY KEY,
    diesease_name VARCHAR( 255 ) NOT NULL
  );
select * from dimensional.diesease_categories_dim;  

-- products table
CREATE TABLE dimensional.medicine_dim
  (
    medicine_id int PRIMARY KEY,
    medicine_name  VARCHAR( 255 ) NOT NULL          
  );
insert into dimensional.medicine_dim(medicine_id,medicine_name)
(select medicine_id,medicine_name from public.medicine);
select * from dimensional.medicine_dim;
-- customers
CREATE TABLE dimensional.customers_dim
  (
    customer_id int PRIMARY KEY,
    name         VARCHAR( 255 ) NOT NULL,
    address      VARCHAR( 255 )                 
  );
  
insert into dimensional.customers_dim(customer_id,name,address)
(select customer_id,name,address from public.customers)
 select * from dimensional.customers_dim;

-- orders table
CREATE TABLE dimensional.Order_Fact_Table
  (
    fact_Id BIGINT GENERATED ALWAYS AS IDENTITY primary key,
    customer_id int references dimensional.customers_dim(customer_id),
	order_id int, 
	region_id int NOT NULL references dimensional.regions_dim(region_id),
	country_id   CHAR( 2 ) references dimensional.countries_dim(country_id),
	diesease_id int  references dimensional.diesease_categories_dim(diesease_id),
	medicine_id int  references dimensional.medicine_dim(medicine_id),
    status      VARCHAR( 20 ) NOT NULL ,
    salesman_id int  references dimensional.employees_dim(employee_id)    ,
    order_month  int NOT NULL         ,
	order_year  int NOT NULL         ,
	quantity   int NOT NULL ,          
    unit_price int NOT NULL      
  
  );
insert into dimensional.Order_Fact_Table(
customer_id,order_id,region_id,country_id,diesease_id,medicine_id,status,salesman_id,order_month, order_year,quantity,unit_price)
(select c.customer_id,o.order_id,r.region_id,co.country_id,dc.diesease_id,m.medicine_id,o.status,salesman_id,EXTRACT(month from o.order_date),EXTRACT(year from o.order_date),oi.quantity,oi.unit_price
from public.orders o
inner join order_items oi on oi.order_id = o.order_id
inner join medicine m on m.medicine_id = oi.medicine_id
inner join diesease_categories dc on dc.diesease_id = m.diesease_id
inner join inventories i on i.medicine_id = m.medicine_id
inner join warehouses w on w.warehouse_id = i.warehouse_id
inner join locations l on l.location_id = w.location_id
inner join countries co on co.country_id = l.country_id
inner join regions r on r.region_id = co.region_id
inner join employees e on e.employee_id = o.salesman_id
inner join customers c on c.customer_id = o.customer_id
  );
  

 
  
select 
select * from dimensional.order_fact_table

select * from dimensional.order_fact_table;

