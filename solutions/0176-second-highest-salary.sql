# Write your MySQL query statement below
Select Distinct MAX(Salary) as SecondHighestSalary from Employee
Where salary < (Select MAX(SALARY) FROM Employee);