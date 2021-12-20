create database assn7;
use assn7;

create table library(
ISBN int,
title varchar(20),
author varchar(20)
);
create table library_audit(
operation varchar(10),
ISBN int,
title varchar(20),
author varchar(20)
);

insert into library values
(1458, 'the gladiator', 'mark twain'),
(2574, 'the yellow fever', 'ramorey'),
(2564, 'g.i. joe', 'joey tribianni');

-- Update trigger
-- Update After
delimiter /
create trigger update_trig after update
     on library
     for each row
     begin
     insert into library_audit values('UPDATE', old.ISBN, old.title, old.author);
     end;
/
delimiter ;

update library set ISBN = 2565 where ISBN = 2564;
select * from library;
select * from library_audit;



-- Update Before
delimiter /
create trigger updateB_trig before update
on library
for each row
begin
insert into library_audit values('UPDATE B', old.ISBN, old.title, old.author);
end;
/
delimiter ;

update library set ISBN = 2589 where ISBN = 2565;
select *  from library_audit;




-- Delete trigger
-- Delete after
delimiter /
create trigger delete_trig after delete
     on library
     for each row
     begin
     insert into library_audit values('DELETE', old.ISBN, old.title, old.author);
     end;
/
delimiter ;

delete from library where ISBN = 1458;
select * from library;
select * from library_audit;



-- Delete before
delimiter /
create trigger deleteB_trig before delete
on library
for each row
begin
insert into library_audit values('DELETE B', old.ISBN, old.title, old.author);
end;
/
delimiter ;

delete from library where ISBN = 2574;
select * from library_audit;




-- Insert Trigger
delimiter /
create trigger insert_trig after insert
on library
for each row
begin
insert into library_audit values('INSERT', new.ISBN, new.title, new.author);
end;
/
delimiter ;

insert into library values(8253, 'gone byes', 'tata bye bye');
select * from library_audit;
select * from library;



-- Insert Before Trigger
delimiter /
create trigger insertB_trig before insert
on library
for each row
begin
insert into library_audit values('INSERT B', new.ISBN, new.title, new.author);
end;
/
delimiter ;

insert into library values(1234, '7 people', 'Chetan Singh');
select * from library_audit;
select * from library;

