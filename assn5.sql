create database assn5;
use assn5;

create table Stud_Marks(
stud_name varchar(20) not null, 
total_marks int not null);

create table Result(
roll int not null auto_increment, 
stud_name varchar(20) not null, 
category varchar(20) not null, 
primary key(Roll));

insert into Stud_Marks values
('a',900),('b',1500),('c',1000),('d',989),('e',990),('f',980),('g',825),('h',899);

select * from Stud_Marks;

delimiter //
create procedure proc_Grade(IN sname varchar(20)) 
         begin 
          declare marks int; 
         select total_marks into marks from Stud_Marks where stud_name=sname; 
         if (marks>=990 and marks<=1500) then
                insert into Result values(marks, sname, 'Distinction');
           elseif (marks>=900 and marks<=989) then
           insert into Result values(marks, sname, 'First');
           else
          insert into Result values(marks, sname, 'Higher Second');
           end if;
          end //

delimiter ;

select * from Stud_Marks;
call proc_Grade('g');

select * from Result;