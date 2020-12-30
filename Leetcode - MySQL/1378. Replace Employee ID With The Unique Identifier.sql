-- SOLUTION 1

select eu.unique_id, e.name from employeeuni eu right join employees e on e.id = eu.id;
-- OR
select eu.unique_id, e.name from employees e left join employeeuni eu on e.id = eu.id;
-- OR
SELECT 
    eu.unique_id, e.name
FROM
    Employees e
        LEFT JOIN
    EmployeeUNI eu USING (id);
-- employees.id = employeeuin.unique_id = employeeuin.id, which simply can be written as, employees.id = employeeuin.id. Basis on this condition, we have to fetch the id and name of the employee. As we see the output expected in the description, we can see that unique_id can have null values but we want all the users, that is, all the values from the employees table. Hence, table consisting user will be either on right while using right join or left while using left join. Decision to use left or right join comes from the fact that we aren't just interested in common values between two tables but all the user values from employees table. 