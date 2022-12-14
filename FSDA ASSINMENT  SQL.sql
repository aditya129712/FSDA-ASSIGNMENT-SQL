------CREATING THE WAREHOUSE--------
CREATE WAREHOUSE FSDA_ASSIGNMENT
WITH WAREHOUSE_SIZE = 'SMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE;


------------FSDA ASSIGNMENT FTASK 1-------------------------
CREATE DATABASE AG_FSDA_TASK_1;
USE AG_FSDA_TASK_1;

CREATE TABLE SHOPPING_HISTORY (
PRODUCT VARCHAR(30) NOT NULL,
QUANTITY INTEGER NOT NULL,
UNIT_PRICE INTEGER NOT NULL);

INSERT INTO SHOPPING_HISTORY(PRODUCT,QUANTITY,UNIT_PRICE) VALUES ('milk',3,10),
('bread',7,3),
('bread',5,2);

SELECT * FROM SHOPPING_HISTORY;

----SOLUTION OF TASK 1---------------

SELECT PRODUCT,SUM(QUANTITY * UNIT_PRICE) AS AGGREGATE_SALES FROM SHOPPING_HISTORY
GROUP BY PRODUCT;


----------------END OF TASK 1---------------------------------------

------FSDA ASSIGNMENT 1-----TASK 2------
CREATE DATABASE AG_FSDA_TASK_2;
USE AG_FSDA_TASK_2;

CREATE TABLE PHONES(
`NAME` VARCHAR(15) NOT NULL UNIQUE,
PHONE_NUMBER INTEGER NOT NULL UNIQUE);

CREATE TABLE CALLS (
    ID INTEGER NOT NULL,
    CALLER INTEGER NOT NULL,
    CALLEE INTEGER NOT NULL,
    DURATION INTEGER NOT NULL,
    UNIQUE (ID));
    


INSERT INTO PHONES(`NAME`,PHONE_NUMBER) VALUES ('Jack',1234),
('Lena',3333),
('Mark',9999),
('Anna',7582);

INSERT INTO CALLS(ID,CALLER,CALLEE,DURATION) VALUES (25,1234,7582,8),
(7,9999,7582,1),
(18,9999,3333,4),
(2,7582,3333,3),
(3,3333,1234,1),
(21,3333,1234,1);

SELECT * FROM PHONES;
SELECT * FROM CALLS;

------SOLUTION OF TASK 2------------


SELECT `NAME`
FROM
(SELECT P.`NAME`, SUM(C.DURATION) AS TOTAL_DURATION FROM PHONES P
INNER JOIN 
CALLS C ON P.PHONE_NUMBER = C.CALLER
GROUP BY `NAME`
UNION ALL
SELECT P.`NAME`, SUM(C.DURATION) AS TOTAL_DURATION FROM PHONES P
INNER JOIN 
CALLS C ON P.PHONE_NUMBER = C.CALLEE
GROUP BY `NAME`) AS FINAL_DURATION
GROUP BY `NAME`
HAVING SUM(TOTAL_DURATION) >= 10
ORDER BY `NAME`;


---TRUNCATE TABLE TO REMOVE ONLY THE VALUES FROM THE TABLE WITHOUT DROPPING THE WHOLE TABLE TO PERFORM THE SECOND CASE----

TRUNCATE TABLE PHONES;
TRUNCATE TABLE CALLS;

SELECT * FROM PHONES;
SELECT * FROM CALLS;

INSERT INTO PHONES(`NAME`,PHONE_NUMBER) VALUES ('John',6356),
('Addison',4315),
('Kate',8003),
('Ginny',9831);

INSERT INTO CALLS(ID,CALLER,CALLEE,DURATION) VALUES  (65,8003,9831,7),
(100,9831,8003,3),
(145,4315,9831,18);


SELECT * FROM PHONES;
SELECT * FROM CALLS;


SELECT`NAME`
FROM
(SELECT P.`NAME`, SUM(C.DURATION) AS TOTAL_DURATION FROM PHONES P
INNER JOIN 
CALLS C ON P.PHONE_NUMBER = C.CALLER
GROUP BY `NAME`
UNION ALL
SELECT P.`NAME`, SUM(C.DURATION) AS TOTAL_DURATION FROM PHONES P
INNER JOIN 
CALLS C ON P.PHONE_NUMBER = C.CALLEE
GROUP BY `NAME`) AS FINAL_DURATION
GROUP BY `NAME`
HAVING SUM(TOTAL_DURATION) >= 10
ORDER BY `NAME`;


----------------------END OF TASK 2----------------------

---------FSDA ASSIGMENT 1 TASK 3-----------------------

CREATE DATABASE AG_FSDA_TASK_3;
USE AG_FSDA_TASK_3;


CREATE TABLE TRANSACTIONS(
    AMOUNT INTEGER NOT NULL,
    `DATE` DATE NOT NULL);

INSERT INTO TRANSACTIONS (AMOUNT,`DATE`) VALUES (1000,'2020-01-06'),
(-10,'2020-01-14'),
(-75,'2020-01-20'),
(-5,'2020-01-25'),
(-4,'2020-01-29'),
(2000,'2020-03-10'),
(-75,'2020-03-12'),
(-20,'2020-03-15'),
(40,'2020-03-15'),
(-50,'2020-03-17'),
(200,'2020-10-10'),
(-200,'2020-10-10');

SELECT * FROM TRANSACTIONS;

-----TOTAL BALANCE WITHOUT CREDIT FEES -----

SELECT SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS;

------SOLUTION OF TASK 3------------


WITH FINAL_RESULT 
AS (SELECT SUM(AMOUNT) AS SUM_TRANSACTION, COUNT(AMOUNT) AS COUNT_OF_TRANSACTION
FROM TRANSACTIONS
WHERE AMOUNT<0
GROUP BY YEAR(`DATE`), MONTH(`DATE`)
HAVING SUM_TRANSACTION<=-100 AND COUNT_OF_TRANSACTION>=3)
SELECT SUM(AMOUNT)-(12-(SELECT DISTINCT(COUNT(*)) FROM FINAL_RESULT)) * (5) AS BALANCE FROM TRANSACTIONS;
  
  -----AGAIN TRUNCATE THE TABLE FOR SECOND TASK----------
  
  TRUNCATE  TABLE TRANSACTIONS;

  INSERT INTO TRANSACTIONS (AMOUNT,`DATE`) VALUES (1,'2020-06-29'),
(35,'2020-02-20'),
(-50,'2020-02-03'),
(-1,'2020-02-26'),
(-200,'2020-08-01'),
(-44,'2020-02-07'),
(-5,'2020-02-25'),
(1,'2020-06-29'),
(1,'2020-06-29'),
(-100,'2020-12-29'),
(-100,'2020-12-30'),
(-100,'2020-12-31');

 
 
 
SELECT * FROM TRANSACTIONS;

-----TOTAL BALANCE WITHOUT CREDIT FEES -----

SELECT SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS;

----SOLUTION OF THE SECOND TASK-------------

WITH FINAL_RESULT
AS (SELECT SUM(AMOUNT) AS SUM_TRANSACTION, COUNT(AMOUNT) AS COUNT_OF_TRANSACTION
FROM TRANSACTIONS
WHERE AMOUNT<0
GROUP BY YEAR(`DATE`), MONTH(`DATE`)
HAVING SUM_TRANSACTION<=-100 AND COUNT_OF_TRANSACTION>=3)
SELECT SUM(AMOUNT)-(12-(SELECT DISTINCT(COUNT(*)) FROM FINAL_RESULT)) * (5) AS BALANCE FROM TRANSACTIONS;


-----AGAIN TRUNCATE THE TABLE FOR THIRD TASK----------

TRUNCATE  TABLE TRANSACTIONS;

INSERT INTO TRANSACTIONS (AMOUNT,`DATE`) VALUES (6000,'2020-04-03'),
(5000,'2020-04-02'),
(4000,'2020-04-01'),
(3000,'2020-03-01'),
(2000,'2020-02-01'),
(1000,'2020-01-01');

SELECT * FROM TRANSACTIONS;


-----TOTAL BALANCE WITHOUT CREDIT FEES -----

SELECT SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS;

----SOLUTION OF THE THIRD TASK-------------


WITH FINAL_RESULT
AS (SELECT SUM(AMOUNT) AS SUM_TRANSACTION, COUNT(AMOUNT) AS COUNT_OF_TRANSACTION
FROM TRANSACTIONS
WHERE AMOUNT<0
GROUP BY YEAR(`DATE`), MONTH(`DATE`)
HAVING SUM_TRANSACTION<=-100 AND COUNT_OF_TRANSACTION>=3)
SELECT SUM(AMOUNT)-(12-(SELECT DISTINCT(COUNT(*)) FROM FINAL_RESULT)) * (5) AS BALANCE FROM TRANSACTIONS;


-----------------END OF TASK 3----------------------














































