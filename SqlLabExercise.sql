create table Emp (
Empno  Number(4) Not Null,Ename Varchar2(10), job Varchar2(9), mgr Number(4), Hiredate Date,
Sal Number(7,2), Comm  Number(7,2), Deptno Number(2)
);

-----------------------------------------------------------------------------------------------
create table Student_Master(
Student_Code Number(6) Not Null, Student_name Varchar2(50) Not Null, Dept_Code Number(2),
Student_dob Date, Student_Address Varchar2(240)
);

------------------------------------------------------------------------------------------------

create table Student_Marks(
Student_Code Number(6), Student_Year Number Not Null,Subject1 Number(3), Subject2 Number(3) ,Subject3 Number(3)
);

-----------------------------------------------------------------------------------------------------------

create table Staff_Master(
Staff_code Number(8) Not Null, Staff_Name Varchar2(50) Not Null, Design_code Number, Dept_code Number, HireDate Date,
Staff_dob Date, Staff_address Varchar2(240), Mgr_code Number(8), Staff_sal Number (10,2)
);

--------------------------------------------------------------------------------------------------------------------

create table Book_Master(
Book_Code Number(10) Not Null, Book_Name Varchar2(50) Not Null ,
Book_pub_year Number, Book_pub_author Varchar2(50) Not Null 
);

--------------------------------------------------------------------------------------------------------------------

create table Book_Transactions(
Book_Code Number, Student_code Number, Staff_code Number, Book_Issue_date Date Not Null, Book_expected_return_date Date Not Null, Book_actual_return_date Date
);

---------------------------------------------------------------------------------------------------------------------

   
Exercise 1.1>>>>>>>    
    
SELECT STAFF_NAME as StaffNames,DESIGN_CODE as Designcodes FROM STAFFMASTER WHERE (HIREDATE <'01-JAN-2003') AND STAFF_SAL BETWEEN 12000 AND 25000;
 
SELECT STAFF_CODE,StaffNames,DEPT_CODE FROM STAFFMASTER WHERE (MONTHS_BETWEEN(SYSDATE,HIREDATE))>=216  ORDER BY HIREDATE DESC;
 
SELECT * FROM STAFFMASTER WHERE MGR_CODE IS NULL;
 
SELECT * FROM BOOK_MASTER WHERE BOOK_PUB_YEAR BETWEEN 2001 AND 2004 AND BOOK_NAME LIKE '%"&"%';
 
SELECT STAFF_NAME FROM STAFFMASTER WHERE STAFF_NAME LIKE '%_%';

-----------------------------------------------------------------------------------------------------------------------



Exercise 2.1>>>>>>>>


SELECT STAFF_NAME,'$'||STAFF_SAL AS STAFF_SALARY FROM STAFFMASTER;
 
SELECT STUDENT_NAME,TO_CHAR(STUDENTDOB,'MONTH DD YYYY') AS STUDENT_DOB FROM STUDENTMASTER WHERE TO_CHAR(STUDENTDOB,'DAY') LIKE  ('%SATURDAY%') OR TO_CHAR(STUDENTDOB,'DAY') LIKE  ('%SUNDAY%') ;
 
SELECT STAFF_NAME,ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS MONTHS_WORKED FROM STAFFMASTER ORDER BY MONTHS_WORKED DESC;
 
SELECT * FROM STAFFMASTER WHERE TO_CHAR(HIREDATE,'DD') BETWEEN 1 AND 15 AND TO_CHAR(HIREDATE,'MONTH') LIKE '%DECEMBER%' ;
 
SELECT STAFF_NAME,STAFF_SAL,
	CASE 
	WHEN STAFF_SAL >=50000 THEN 'A'  
	WHEN STAFF_SAL  >25000 AND  STAFF_SAL<50000 THEN 'B' 
	WHEN STAFF_SAL  >10000 AND  STAFF_SAL<25000 THEN 'C' 
	ELSE 'D' 
	END CASE
	FROM STAFFMASTER;
 
 
SELECT STAFF_NAME,TO_CHAR(HIREDATE,'DD MONTH YYYY') AS HIRE_DATE,TO_CHAR(HIREDATE,'DAY')AS DAY FROM STAFFMASTER ORDER BY TO_CHAR(HIREDATE,'DAY') DESC;

SELECT INSTR('Mississippi','i',2,3) FROM DUAL;
 
SELECT TO_CHAR(NEXT_DAY(SYSDATE,'TUESDAY'),'DD MONTH ,YYYY') AS DAY FROM DUAL WHERE NEXT_DAY(SYSDATE,'TUESDAY')<LAST_DAY(SYSDATE) ;
 
SELECT STUDENT_CODE,STUDENT_NAME,DECODE(DEPT_CODE,20,'ELECTRICALS',30,'ELECTRONICS','OTHERS') DEPARTMENT_NAME FROM STUDENTMASTER;
 
 -------------------------------------------------------------------------------------------------------------------------
 
 
Exercise 2.2>>>>>>>>>>>>>>

select max(staff_sal) as Maximum,min(staff_sal) as minimum,sum(staff_sal) as total,round (avg(staff_sal)) as average from staff_master group by dept_code;

select deptno,count(empno) as "Total number of managers" from emp where job='MANAGER' group by deptno;

select deptno,sum(sal) from emp where job!='MANAGER' group by deptno having sum(sal)>20000;


-----------------------------------------------------------------------------------------------------------------------



Exercise 3.1>>>>>>>>>

SELECT S.STAFF_NAME,
  D.DEPT_CODE,
  D.DEPT_NAME,
  S.STAFF_SAL
FROM STAFFMASTER S,
  DEPARTMENT_MASTER D
WHERE S.DEPT_CODE=D.DEPT_CODE
AND STAFF_SAL    >20000;

SELECT S.STAFF_CODE AS STAFF# ,
  S.STAFF_NAME      AS STAFF,
  D.DEPT_NAME,
  S.MGR_CODE AS MGR#
FROM STAFFMASTER S,
  DEPARTMENT_MASTER D
WHERE S.DEPT_CODE=D.DEPT_CODE;
 
SELECT S.STUDENT_CODE,
  S.STUDENT_NAME,
  B.BOOK_CODE,
  BB.BOOK_NAME
FROM STUDENTMASTER S,
  BOOK_TRANSACTIONS B,
  BOOK_MASTER BB
WHERE S.STUDENT_CODE=B.STUDENT_CODE
AND TO_CHAR(B.BOOK_EXPECTED_RETURN_DATE,'DD MM YYYY') LIKE TO_CHAR(SYSDATE,'DD MM YYYY');
 

SELECT S.STAFF_CODE,S.STAFF_NAME,D.DEPT_NAME,F.DESIGN_NAME,G.BOOK_NAME,H.BOOK_ISSUE_DATE 
FROM STAFFMASTER S,DEPARTMENT_MASTER D,DESIGNATION-MASTER F,BOOK_MASTER F,BOOK_ISSUE_DATE H
WHERE MONTHS_BETWEEN(TO_CHAR(H.BOOK_ISSUE_DATE,'MM'),TO_CHAR(SYSDATE,'MM'))<1;
 
select s.staff_code,s.staff_name,d.dept_name,f.design_name,bt.book_code,g.book_name,g.book_pub_author ,5*(sysdate-book_expected_return_date)
AS FINE from staff_master s inner join department_master d on s.dept_code=d.dept_code inner join designation_master g on s.design_code=g.design_code
inner join book_transactions bt on s.staff_code=bt.staff_code inner join book_master g on bt.book_code=g.book_code;
 
SELECT Staff_Code, Staff_Name,STAFF_SAL  FROM STAFFMASTER WHERE STAFF_SAL<(SELECT AVG(STAFF_SAL) FROM STAFFMASTER);

SELECT AUTHOR,BOOK_NAME FROM BOOK_MASTER GROUP BY AUTHORNAME HAVING COUNT(AUTHOR)>1;
 
SELECT S.Staff_Code,D.Staff_Name,D.DEPT_NAME FROM STAFFMASTER S,BOOK_TRANSACTIONS D GROUP BY S.STAFF_NAME HAVING COUNT(D.STAFF_NAME)>1;
 
SELECT S.STUDENT_CODE,S.STUDENT_NAME,D.DEPT_NAME FROM STAFFMASTER S,DEPARTMENT_MASTER D GROUP BY S.DEPT_CODE HAVING MAX(S.DEPT_CODE);
 
SELECT S.Staff_Code,S.Staff_Name,D.DEPT_NAME,F.DESIGN_NAME FROM STAFFMASTER S, DEPARTMENT_MASTER D,DESIGNATION_MASTER F
WHERE MONTHS_BETWEEN(TO_CHAR(HIREDATE,'MM') ,TO_CHAR(SYSDATE,'MM'))<3;   
 
SELECT DEPT_CODE,DEPT_NAME,COUNT(S.STAFF_NAME) AS NUMBEROFPEOPLE FROM STAFFMASTER S,DEPARTMENT_MASTER D GROUP BY DEPT_CODE;
 
 
-------------------------------------------------------------------------------------------------------------------

Exercise 4.1>>>>>>>

create table Customer_1(

CustomerId Number(5),
Cust_Name varchar2(20),
Address1 Varchar2(30),
Address2 Varchar2(30)
);

Alter table Customer_1
Modify Cus_Name VARCHAR2(30);

Alter table customer_1
Rename Column Cust_Name to CustomerName ;

Alter table Customer_1
Modify CustomerName not null;

Alter table Customer_1
Add( Gender Varchar2(1),
Age Number(3),
PhoneNo Number(10));
 
Alter Table Customer_1
Rename  to Cust_Table;

Insert into Cust_Table values(1000, 'Allen', '#115 Chicago', '#115 Chicago', 'M', 25,7878776);
Insert into Cust_Table values(1001, 'George', '#116 France', '#116 France', 'M', 25, 434524);
Insert into Cust_Table values(1002, 'Becker', '#114 New York', '#114 New York', 'M', 45, 431525);

Alter table Cust_Table 
Add Constraint CustId_Prim Primary Key(CustomerId);

insert into Cust_Table values(1002, 'John', '#114 Chicago', '#114 Chicago', 'M', 45, 439525);

Alter table Cust_Table
Disable constraint CustId_Prim;

insert into Cust_Table values(1002, 'Becker', '#114 New York', '#114 New york' , 'M', 45, 431525);
insert into Cust_Table values(1003, 'Nanapatekar', '#115 India', '#115 India' , 'M', 45, 431525);

Alter table Cust_Table
Enable constraint CustId_Prim;

Alter table Cust_Table
Drop primary key ;

insert into Cust_Table values(1002, 'Becker', '#114 New York', '#114 New york' , 'M', 45, 431525,15000.50);
insert into Cust_Table values(1003, 'Nanapatekar', '#115 India', '#115 India' , 'M', 45, 431525,20000.50);

Truncate table Cust_Table;

Alter table Cust_Table
Add E_mail Varchar2(50);

Alter table Cust_Table
Drop column E_mail;

Create table Customer_1(
CustomerId number(5), CustomerName varchar2(30), Address1 varchar2(50), Address2 varchar2(50), phoneno number(10)
);

create table Suppliers as( Select customerID as SuppID, CustomerName as SName, Address1 as Addr1, Address2 as Addr2, PhoneNo as Contactno from Customer_1);

Drop table Customer_1;
Drop Table Suppliers;


create table CustomerMaster(
CustomerId Number(5),
CustomerName Varchar2(30) Not Null,
Addressl Varchar2(30) Not Null,
Address2 Varchar2(30),
Gender Varchar2(1),
Age Number(3),
PhoneNo Number(10),
constraint CustId_PK primary key(CustomerId));

	   Create table Accoutnmaster(
       customerid number(5),
       Accountnumber number(10) primary key(acno),
       accounttype char(3),
       ledgerbalance number(10) Not Null);
	  
       Create sequence seq_ano
		MINVALUE 101
		MAXVALUE 10000
		START WITH 101
		INCREMENT BY 1
		CACHE 101;


insert into CustomerMaster values(1000, 'Allen', '#115 Chicago', '#115 Chicago', 'M', 25, 7878776);
insert into CustomerMaster values(1001, 'George', '#116 France', '#116 France', 'M', 25, 434524);
insert into CustomerMaster values(1002, 'Becker', '#114 New York', '#114 New York', 'M', 45, 431525);

Alter table Accountmaster ADD constraint Cust_acc FOREIGN KEY(customerid) REFERENCES customermaster(customerid);
 
alter table Accountmaster add constraint ck_ac check(accountype='NRI' or accountype='IND');

alter table Accountmaster add constraint Balance_check(ledger balance > 5000);
 
Delete from Accountmaster,customertable where customerid = 1001;
 
Create table accountdetails as (select * from Accountmaster);

CREATE VIEW Acc_view AS SELECT(Customerid,Customername,Accountnumber,AccountType,ledgerBalance)
	from AccountMaster;
 
CREATE VIEW vAccs_Dtls AS SELECT 	Accounttype,ledgerbalance from Accountmaster where accounttype = 'IND' and ledgerbalance < 10000;
 
 
 
CREATE sequence SEQ_DEPT minvalue 40 start with 40
	increment by 10 MAX VALUE 200 cache 40;
 
create table departmentmaster(deptno number(50),Dname varchar2(25),location varchar2(25));
insert into departmentmaster  values(seq_dept.NEXTVAL,'MARKETING','NEW DELHI');
insert into departmentmaster  values(seq_dept.NEXTVAL,'SALES','chennai');
insert into departmentmaster  values(seq_dept.NEXTVAL,'RESEARCH','BOSTON');

DROP sequence seq_dept;
 
CREATE INDEX no_name on emp(empno);
select * from emp;

create SYNONYM synemp for emp;
 
select * from synemp;
 
CREATE INDEX IDX_EMP_HIREDATE on emp(HIREDATE);
 
CREATE sequence SEQ_EMP minvalue 1001 start with 1001
	increment by 1 cache 1001; ]
    
-------------------------------------------------------------------------------------------------------------------------------- 

Exercise 5.1>>>>>>>>>>>>>>>>>>>>>>>
 
Create table employee as select * from emp;

desc employee;

select * from employee;

update employee set job=(select job from employee where empno=7788),deptno=(select deptno from employee where empno=7788) where empno=7698;

delete from department where dept_name='SALES';
delete from department where dept_name='SALES'


delete from department_master where dept_name='SALES';

update employee set empno=7788 where empno=7698;

insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) values (1000,'Allen', 'Clerk',1001,'12-jan-01', 3000, 2,10);

insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) values (1001,'George', 'Analyst',null,'08-sep-1992', 5000, 0,10);

insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) values (1002,'Becker', 'Manager',1000,'04-nov-1992', 2800, 4,20);

insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) values (1003,'Bill','Clerk',1002,'04-nov-1992', 3000,0,20);
 
 ------------------------------------------------------------------------------------------------------------------
 
 Exercise 6.1>>>>>>>>>>>>>>>>>>>>
 
 insert into customermaster (customerid,customername,address1,address2,gender,age,phoneno) values ( 6000, 'John', '#115 Chicago', '#115 Chicago',' M', 25, 7878776, 10000 );
 insert into customermaster (customerid,customername,address1,address2,gender,age,phoneno) values (	6001, 'Jack', '#116 France', '#116 France', 'M', 25, 434524, 20000  );
 insert into customermaster (customerid,customername,address1,address2,gender,age,phoneno) values (	6002, 'James', '#114 New York', '#114 New York', 'M', 45, 431525, 15000.50);
 
 savepoint p1;
 
 insert into customermaster (customerid,customername,address1,address2,gender,age,phoneno) values (	6003, 'John', '#114 Chicago', '#114 Chicago', 'M', 45, 439525, 19000.60);
 
 savepoint p1;
 