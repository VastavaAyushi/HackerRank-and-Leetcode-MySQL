-- SOLUTION 1

with ms as (SELECT 
    id, salary
FROM
    employee
WHERE
    id IN (SELECT 
            managerid
        FROM
            employee
        WHERE
            managerid IS NOT NULL)
ORDER BY id)

SELECT 
    e.name AS Employee
FROM
    employee e
        JOIN
    ms
WHERE
    e.salary > ms.salary
        AND e.managerid = ms.id;
-------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    e1.Name 'Employee'
FROM
    Employee e1
        JOIN
    Employee e2 ON e1.ManagerId = e2.Id
WHERE
    e1.salary > e2.Salary;