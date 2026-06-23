CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
set N = N - 1;
  RETURN (
    Select Distinct(salary) from Employee order by salary DESC
    Limit 1 offset N
  );
END