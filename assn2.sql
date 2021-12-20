CREATE DATABASE assn2; 
SHOW DATABASES;
USE assn2;

create table customer( 
cust_no int not null auto_increment, 
cust_fname varchar(25) not null,
cust_lname varchar(25) not null,
cust_company varchar(50),
cust_addr varchar(50), 
city varchar(25), 
cust_phone char(10), 
primary key (cust_no) );

create table authors(
author_no int not null auto_increment, 
author_name varchar(25) not null, 
country varchar(25) not null, 
primary key (author_no) );

create table publisher( 
publisher_no int not null auto_increment, 
publisher_name varchar(25) not null, 
publisher_addr varchar(25) not null, 
p_year year not null, 
primary key (publisher_no) );

create table book( 
isbn varchar(25) not null, 
title varchar(25) not null, 
unit_price int not null, 
author_no int not null, 
publisher_no int not null, 
pub_year year not null, 
primary key (isbn), 
foreign key (publisher_no) references publisher(publisher_no) on delete cascade, 
foreign key (author_no) references authors(author_no) on delete cascade );

create table ordering( 
order_no int not null auto_increment, 
cust_no int not null, 
isbn varchar(25) not null, 
qty int not null, 
odate date not null,
primary key (order_no), 
foreign key (cust_no) references customer(cust_no) on delete cascade, 
foreign key (isbn) references book(isbn) on delete cascade );

show tables;

#1. Insert at least 10 records in customer table and insert other tables accordingly

insert into customer(cust_fname,cust_lname,cust_company,cust_addr,city,cust_phone) values 
( 'white','haykins','whco','east street','pune','9514753682'),
( 'Paul','Verma','tvco','best street','pune','7536951428'),
( 'Harper','Lee','hlco','west street','mumbai','8456279315'),
( 'Stephen','Charlee','scco','north road','melbourne','4751235698'),
( 'John','Green','jgco','south road','sydney','1478523690'),
( 'Steve','Harwey','shco','central market','delhi','3654789012'),
( 'Ben','Alton','baco','big market','rome','3654789012'),
( 'Jonny','Rowling','jrco','central perk','new york','6321458709'),
( 'Yann','Martel','ymco','nice oasis','dubai','0258963147'),
( 'Mark','Toel','shco','main road','pune','2369875410');

insert into authors (author_name, country) values 
('R D Sharma', 'India'),
('H C Verma', 'India'),
('ARD', 'USA'),
('Tanenbun', 'Spain'),
('Hugh Jones', 'Germany'), ('Ben Tennyson', 'Australia'), ('J K Rowling', 'UK'),
('Zarco Romaan', 'Italy'),
('Drake', 'Australia');

insert into publisher (publisher_name, publisher_addr, p_year) values 
('Prime', 'India', 2001),
('Mercury', 'USA', 1952),
('Netflix', 'UK', 2015),
('Liv', 'India', 2005),
('Parimal', 'India', 2016),
('Venus', 'Australia', 2002),
('Komal', 'India', 2010),
('Mary Lamb', 'Germany', 2004),
('Saif', 'India', 2003),
('Great Works', 'USA', 2006);

insert into book (isbn, title, unit_price, author_no, publisher_no, pub_year) values 
('85445822155', '13 reasons why', 200, 1, 2, 2015),
('85445822180', 'la casa de papel', 320, 3, 1, 2000),
('85445822777', 'The Witcher', 340, 2, 1, 2001),
('85445866785', 'Dark', 500, 1, 2, 2004),
('85445822255', 'F.R.I.E.N.D.S', 200, 1, 2, 2020),
('85445822280', 'Sacred games', 420, 3, 1, 2015),
('85445822277', 'Riverdale', 240, 2, 1, 2006),
('85445866285', 'Penthouse', 500, 1, 2, 2005),
('85445822355', 'W : Two worlds', 210, 1, 2, 2020),
('85445866385', 'Game of Thrones', 500, 1, 2, 2005);

insert into ordering (cust_no, isbn, qty, odate) values 
(5, '85445822280', 1, '2020-05-12'),
(1, '85445822277', 3, '2020-04-15'),
(6, '85445866385', 10, '2019-03-02'),
(7, '85445822180', 1, '2020-05-12'),
(2, '85445822777', 3, '2020-04-15'),
(3, '85445822155', 10, '2019-03-02'),
(8, '85445822180', 1, '2020-05-12'),
(1, '85445866285', 3, '2020-04-15'),
(9, '85445822355', 10, '2019-03-02');


#2. Display all customer details with city pune and mumbai and customer first name starting with 'p' or 'h'.

select * from customer where ( city='pune' or city='mumbai' ) and ( cust_fname like 'p%' or cust_fname like 'h%');



#3. lists the number of different customer cities.(use of distinct)

select distinct city from customer;
select count(distinct city) from customer;

#4. Give 5% increase in price of the books with publishing year 2015. ( use of update) 

update book set unit_price=unit_price*1.05 where pub_year=2015;


#5. Delete customer details living in pune.

select * from customer where city='pune';
delete from customer where city='pune';
select * from customer where city='pune';



#6. Find the names of authors living in India or Australia (use of UNION) 

select author_name from authors where country='India'
union
select author_name from authors where country='Australia';



#7. Find the publishers who are established in year 2015 as well as in 2016 

select * from publisher where p_year=2015 or p_year=2016;



#8. Find the book having maximum price and find titles of book having price between 300 and 400.(use of max and between)

select * from book where unit_price=(select max(unit_price) from book);

select title from book where unit_price between 300 and 400;



#9. Display all titles of books with price and published year in decreasing order of publishing year.

select title,unit_price,pub_year from book order by pub_year desc;



#10. Display title,author_no and publisher_no of all books published in 2000,2004,2006. (use of IN) 

select title,author_no,publisher_no from book where pub_year in (2000,2004,2006);



#11.Create view showing the books and authors details. (COMPLEX VIEW) 

select * from book
inner join authors on book.author_no=authors.author_no;
