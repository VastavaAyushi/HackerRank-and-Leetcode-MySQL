-- SOLUTION 1

SELECT MAX(salary) AS SecondHighestSalary 
FROM employee 
WHERE salary < (SELECT MAX(salary) 
FROM employee);

--------------------------------------------------------------------------

-- OPTIMAL SOLUTION

SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary;
    
    -- OFFSET AND FETCH USED WITH ORDER BY CLAUSE: https://www.sqlservertutorial.net/sql-server-basics/sql-server-offset-fetch/