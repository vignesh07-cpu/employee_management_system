
-- ========================================
-- Employee Management System - SQL Project
-- ========================================

-- Drop existing tables if any (for clean setup)
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- 1. Create Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100)
);

-- 2. Create Employees Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DeptID INT,
    Salary DECIMAL(10,2),
    JoiningDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- 3. Create Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    Date DATE,
    Status VARCHAR(10), -- Present, Absent, Leave
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- 4. Create Performance Table
CREATE TABLE Performance (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    Year INT,
    Rating INT, -- 1 to 5
    Remarks VARCHAR(255),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- Insert sample data into Departments
INSERT INTO Departments (DeptName) VALUES
('HR'), ('IT'), ('Sales'), ('Finance');

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, Gender, DeptID, Salary, JoiningDate) VALUES
('Rahul', 'Sharma', 'Male', 3, 50000, '2023-01-10'),
('Anita', 'Verma', 'Female', 1, 60000, '2022-05-15'),
('Suresh', 'Kumar', 'Male', 2, 75000, '2021-07-01'),
('Priya', 'Singh', 'Female', 3, 52000, '2023-02-20'),
('Amit', 'Patel', 'Male', 2, 70000, '2020-11-12'),
('Neha', 'Gupta', 'Female', 4, 65000, '2019-03-30');

-- Sample Attendance Records
INSERT INTO Attendance (EmpID, Date, Status) VALUES
(1, '2024-04-01', 'Present'),
(1, '2024-04-02', 'Present'),
(2, '2024-04-01', 'Leave'),
(3, '2024-04-01', 'Present'),
(4, '2024-04-01', 'Absent'),
(5, '2024-04-01', 'Present'),
(6, '2024-04-01', 'Present');

-- Sample Performance Records
INSERT INTO Performance (EmpID, Year, Rating, Remarks) VALUES
(1, 2023, 4, 'Good'),
(2, 2023, 5, 'Excellent'),
(3, 2023, 3, 'Average'),
(4, 2023, 2, 'Needs Improvement'),
(5, 2023, 5, 'Outstanding'),
(6, 2023, 4, 'Good');
show tables;
select * from attendance;
select * from departments;
select * from employees;
select * from performance;

										#full analysis of employee_management_system

## Q1)department wise average salary

select d.deptname,avg(e.salary) as total_avg_salary
from employees e
join departments d
on e.deptId =d.deptid
group by d.deptname
order by total_avg_salary desc;

 ## Q.2) list of employee name with department names 
 
 select e.firstname,d.deptname from employees e
 join departments d 
 on e.deptid =d.deptid;
 
 ##Q.3) emplyess with highest attendance in last 30 days
 
 select e.firstname,a.status ,count(*) as highest_attendance 
 from employees e 
 join attendance a
 on e.empid=a.empid
 where a.status="present" and a.date >= (select max(a.date) from attendance) - interval 30 day
 group by e.firstname,a.status
 order by highest_attendance desc
 limit 1;
 
 ## Q.4) top performance by rating in a given year 
 
 select e.firstname,p.rating,p.year,e.lastname,p.remarks
 from employees e
 join performance p
 on e.empid =p.empid
 where p.year= (select max(year) from performance)
 order by p.rating desc
 limit 3;
select * from departments;
 select * from performance;
 select * from employees;
 
##Q.5 average rating per department 

select d.deptname,avg(p.rating) as average_rating 
from employees e 
join departments d
on e.deptid = d.deptid
join performance p
on e.empid = p.empid
group by d.deptname
order by average_rating desc;

 ## Q.6) catogrize employees based on salary
 
 select firstname, lastname ,salary, 
 case 
 when salary >70000 then "good_salary"
 when salary >60000 then "medium_salary"
 when salary between 40000 and 60000 then "normal_salary"
 else "low_salary"
 end as categorize_salary 
 from employees;
 
 ## Q.7 rank employees by salary in each department
 select firstname,salary,deptID ,
 rank()over(partition by deptid  order by salary desc) as ranks from employees;
#                             --OR--
 ## another method to answer this question:-
SELECT 
e.firstname,
e.salary,
d.deptname,
RANK() OVER (PARTITION BY d.deptname ORDER BY e.salary DESC) AS ranks
FROM 
employees e
JOIN 
departments d
ON e.deptid = d.deptid;


 
 
 
 
 
 
 
 
 
 

 
















