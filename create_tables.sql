

-- regions
CREATE TABLE regions
  (
    region_id int NOT NULL PRIMARY KEY,
    region_name VARCHAR( 50 ) NOT NULL
  );
  
  
select * from locations;

-- countries table
CREATE TABLE countries
  (
    country_id   CHAR( 2 ) PRIMARY KEY  ,
    country_name VARCHAR( 50 ) NOT NULL,
    region_id    int                  , -- fk
    CONSTRAINT fk_countries_regions FOREIGN KEY( region_id )
      REFERENCES regions( region_id ) 
      ON DELETE CASCADE
  );

-- location
CREATE TABLE locations
  (
    location_id int PRIMARY KEY       ,
    address     VARCHAR( 255 ) NOT NULL,
    postal_code VARCHAR( 20 )          ,
    city        VARCHAR( 50 )          ,
    state       VARCHAR( 50 )          ,
    country_id  CHAR( 2 )               , -- fk
    CONSTRAINT fk_locations_countries 
      FOREIGN KEY( country_id )
      REFERENCES countries( country_id ) 
      ON DELETE CASCADE
  );
-- warehouses
CREATE TABLE warehouses
  (
    warehouse_id  int PRIMARY KEY,
    warehouse_name VARCHAR( 255 ) ,
    location_id    int , -- fk
    CONSTRAINT fk_warehouses_locations 
      FOREIGN KEY( location_id )
      REFERENCES locations( location_id ) 
      ON DELETE CASCADE
  );
  
 select * from warehouses;
-- employees
CREATE TABLE employees
  (
    employee_id int PRIMARY KEY,
    first_name VARCHAR( 255 ) NOT NULL,
    last_name  VARCHAR( 255 ) NOT NULL,
    email      VARCHAR( 255 ) NOT NULL,
    phone      VARCHAR( 50 ) NOT NULL ,
    hire_date  DATE NOT NULL          ,
    manager_id  int      , -- fk
    job_title  VARCHAR( 255 ) NOT NULL,
    CONSTRAINT fk_employees_manager 
        FOREIGN KEY( manager_id )
        REFERENCES employees( employee_id )
        ON DELETE CASCADE
  );
  select * from disease_categories
-- diesease category
CREATE TABLE disease_categories
  (
    disease_id int PRIMARY KEY,
    diesease_name VARCHAR( 255 ) NOT NULL
  );

-- medicine table
CREATE TABLE medicine
  (
    medicine_id int PRIMARY KEY,
    medicine_name  VARCHAR( 255 ) NOT NULL,
    standard_cost FLOAT             ,
    list_price    FLOAT             ,
    disease_id   int NOT NULL      ,
    CONSTRAINT fk_diesease_categories 
      FOREIGN KEY( disease_id )
      REFERENCES disease_categories( disease_id ) 
      ON DELETE CASCADE
  );
  
alter table medicine
rename column diesease_id to disease_id;
select * from contacts;
-- customers
CREATE TABLE customers
  (
    customer_id int PRIMARY KEY,
    name         VARCHAR( 255 ) NOT NULL,
    address      VARCHAR( 255 )         ,
    website      VARCHAR( 255 )         ,
    credit_limit float
  );
alter table customers drop column website

-- contacts
CREATE TABLE contacts
  (
    contact_id int PRIMARY KEY,
    first_name  VARCHAR( 255 ) NOT NULL,
    last_name   VARCHAR( 255 ) NOT NULL,
    email       VARCHAR( 255 ) NOT NULL,
    phone       VARCHAR( 20 )          ,
    customer_id int                  ,
    CONSTRAINT fk_contacts_customers 
      FOREIGN KEY( customer_id )
      REFERENCES customers( customer_id ) 
      ON DELETE CASCADE
  );
-- orders table
CREATE TABLE orders
  (
    order_id int  PRIMARY KEY,
    customer_id int NOT NULL, -- fk
    status      VARCHAR( 20 ) NOT NULL ,
    salesman_id int          , -- fk
    order_date  DATE NOT NULL          ,
    CONSTRAINT fk_orders_customers 
      FOREIGN KEY( customer_id )
      REFERENCES customers( customer_id )
      ON DELETE CASCADE,
    CONSTRAINT fk_orders_employees 
      FOREIGN KEY( salesman_id )
      REFERENCES employees( employee_id ) 
      ON DELETE SET NULL
  );
-- order items
CREATE TABLE order_items
  (
    order_id   int                                , -- fk
    item_id    int                                ,
    medicine_id int NOT NULL                       , -- fk
    quantity   int NOT NULL                        ,
    unit_price int NOT NULL                        ,
    CONSTRAINT pk_order_items 
      PRIMARY KEY( order_id, item_id ),
    CONSTRAINT fk_order_items_medicine 
      FOREIGN KEY( medicine_id )
      REFERENCES medicine( medicine_id ) 
      ON DELETE CASCADE,
    CONSTRAINT fk_order_items_orders 
      FOREIGN KEY( order_id )
      REFERENCES orders( order_id ) 
      ON DELETE CASCADE
  );
-- inventories
CREATE TABLE inventories
  (
    medicine_id  int        , -- fk
    warehouse_id int       , -- fk
    quantity     int  NOT NULL,
    CONSTRAINT pk_inventories 
      PRIMARY KEY( medicine_id, warehouse_id ),
    CONSTRAINT fk_inventories_medicine 
      FOREIGN KEY( medicine_id )
      REFERENCES medicine( medicine_id ) 
      ON DELETE CASCADE,
    CONSTRAINT fk_inventories_warehouses 
      FOREIGN KEY( warehouse_id )
      REFERENCES warehouses( warehouse_id ) 
      ON DELETE CASCADE
  );
  
select * from inventories;

