-- creating database
create database dannys_diner;
-- using database
use dannys_diner;

-- create tables
create table members
	(customer_id char(1) primary key,
    join_date datetime);
    
create table menu
	(product_id int primary key auto_increment,
    product_name varchar(100) not null,
    price int not null);

create table sales
	(customer_id char(1) not null,
    order_date datetime not null,
    order_id int primary key auto_increment,
    product_id int not null,
    foreign key (customer_id) references members(customer_id),
    foreign key (product_id) references menu (product_id));
