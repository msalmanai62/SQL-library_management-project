/*
Library Management System
 --> A project to showcase my SQL skills
*/

drop database if exists library_management;
create database if not exists library_management;
use library_management;

drop table if exists branch;
create table branch (
	branch_id varchar(10),
    manager_id	varchar(10),
    branch_address varchar(30),
    contact_no varchar(15),
    primary key (branch_id)
	);

drop table if exists employees;
create table employees (
	emp_id varchar(10),
	emp_name varchar(30),
	position varchar(30),
	salary decimal(10,2),
	branch_id varchar(10),
    primary key (emp_id),
    foreign key (branch_id) references branch(branch_id)
	);

drop table if exists members;
create table members (
	member_id varchar(10),
	member_name varchar(30),
	member_address varchar(50),
	reg_date date,
    primary key (member_id)
    );
alter table members modify reg_date varchar(15);
alter table members modify reg_date date;

UPDATE members 
SET reg_date = STR_TO_DATE(reg_date, '%m/%d/%Y');

drop table if exists books;
create table books (
	isbn varchar(50),
	book_title varchar(80),
	category varchar(30),
	rental_price decimal(10,2),
	status varchar(10),
	author varchar(30),
    publisher varchar(30),
    primary key(isbn)
	);
alter table books modify category varchar(30);
-- alter table books alter column category type varchar(30); -- command in PostGreSQL

drop table if exists issued_status;
create table issued_status (
	issued_id varchar(10),
	issued_member_id varchar(30),
	issued_book_name varchar(80),
	issued_date	date,
    issued_book_isbn varchar(50),
	issued_emp_id varchar(10),
    primary key (issued_id),
    foreign key (issued_member_id) references members(member_id),
    foreign key (issued_book_isbn) references books(isbn),
    foreign key (issued_emp_id) references employees(emp_id)
    );
-- alter table  issued_status add constraint fk_issued_member_id foreign key (issued_member_id) references members(member_id);

alter table issued_status modify issued_date varchar(15);
alter table issued_status modify issued_date date;
UPDATE issued_status 
SET issued_date = STR_TO_DATE(issued_date, '%m/%d/%Y');

drop table if exists return_status;
create table return_status (
	return_id varchar(10),
	issued_id varchar(10),
	return_book_name varchar(80),
	return_date	date,
    return_book_isbn varchar(50),
    primary key (return_id),
    foreign key (return_book_isbn) references books(isbn)
	);
alter table return_status add constraint fk_issued_id foreign key (issued_id) references issued_status(issued_id);

alter table return_status modify return_date varchar(15);
alter table return_status modify return_date date;
UPDATE return_status 
SET issued_date = STR_TO_DATE(issued_date, '%m/%d/%Y');

