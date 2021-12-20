-- create database 
CREATE DATABASE assn4;

-- use database
USE assn4;

-- tables
CREATE TABLE Borrower (
roll INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
date_of_issue DATE NOT NULL,
name_of_book VARCHAR(200) NOT NULL,
status VARCHAR(200) DEFAULT 'I',
PRIMARY KEY(roll)
);

CREATE TABLE Fine (
roll INT NOT NULL,
fdate DATE NOT NULL,
amt INT NOT NULL,
FOREIGN KEY(roll)
	REFERENCES Borrower(roll)
);


INSERT INTO Borrower VALUES
(1, 'Aarkin', '2021-12-10', 'Book1', 'I'),
(2, 'Vedant', '2021-03-22', 'Book2', 'I');

INSERT INTO Borrower VALUES
(3, 'Tejas', '2021-12-01', 'Book3', 'I'),
(4, 'Rohan', '2020-04-22', 'Book4', 'I');

delimiter //
create procedure finefunc (IN rollno INT, bookname VARCHAR(200))
	BEGIN
    DECLARE dateofissue DATE;
    DECLARE noofdays INT;
    DECLARE fineamt INT;
    -- exception
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'Table not found';
    
    SELECT date_of_issue INTO dateofissue FROM Borrower where roll = rollno AND name_of_book = bookname;
    SET noofdays = datediff(CURDATE(), dateofissue);
    IF (noofdays > 30) THEN
    SET fineamt = noofdays*50;
    ELSEIF (noofdays >= 15 and noofdays <= 30) THEN
    SET fineamt = noofdays*5;
    ELSE 
    SET fineamt = 0;
    END IF;
    
    INSERT INTO Fine 
    VALUES (rollno, CURDATE(), fineamt);
    
    UPDATE Borrower
    SET status = 'R' 
    WHERE roll = rollno AND name_of_book = bookname;
    
    END// 
delimiter ;

select * from Borrower;
call finefunc(4, 'Book4');

select * from Fine;









/*


Example:

DELIMITER $$
This is a complete statement, not part of the procedure, so use the custom delimiter $$ 
DROP PROCEDURE my_procedure$$

Now start the procedure code 
CREATE PROCEDURE my_procedure ()
BEGIN    
  Inside the procedure, individual statements terminate with ;
  CREATE TABLE tablea (
     col1 INT,
     col2 INT
  );

  INSERT INTO tablea
    SELECT * FROM table1;

  CREATE TABLE tableb (
     col1 INT,
     col2 INT
  );
  INSERT INTO tableb
    SELECT * FROM table2;
  
 whole procedure ends with the custom delimiter 
END$$

 Finally, reset the delimiter to the default ; 
DELIMITER ;



*/







