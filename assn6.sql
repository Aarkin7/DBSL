create database assn6;
use assn6;

create table n_empid
( 
id int not null auto_increment,
name varchar(25) not null,
salary int not null,
primary key(id)
);

create table o_empid
( 
id int not null auto_increment,
name varchar(25) not null,
salary int not null,
primary key(id)
);

insert into o_empid
(name,salary) values 
('white haykins', 14055),
('Stephen Charlee', 9055),
('John Green', 10000),
('Ben Alton', 9405),
('Jonny Rowling', 12500),
('Mark Toel', 9901);

insert into n_empid
(name,salary) values 
('white haykins', 14550),
('Paul Verma',9205),
('Harper Lee', 8020),
('John Green', 10100),
('Steve Harwey',8052),
('Jonny Rowling', 12050),
('Yann Martel', 8010);

select * from o_empid;
select * from n_empid;

delimiter /
create procedure merger()
begin
declare id1 int;
declare name1 varchar(25);
declare salary1 int;
declare exit_loop boolean; 
declare c1 cursor for select * from o_empid;
declare continue handler for not found set exit_loop = true;
open c1;
l1:loop
fetch c1 into id1,name1,salary1;
if not exists(select * from n_empid where name=name1) then
insert into n_empid(name,salary) values (name1,salary1);
end if;
if exit_loop then
close c1;
leave l1;
end if;
end loop l1;
end;
/delimiter ;

select * from n_empid;
call merger();
select * from n_empid;
