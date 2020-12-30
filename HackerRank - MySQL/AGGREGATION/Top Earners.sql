-- SOLUTION 1

-- we can't just assign any random variable to another query, I tried using max_earnings = (SELECT MAX(salary * months) FROM Employee) but it showed error. Also, tried using count(max()) but it also resulted in error because it is wrong to use double-aggregated functions together. 

SELECT 
    MAX(salary * months), COUNT(salary * months)
FROM
    Employee
WHERE
    salary * months = (SELECT 
            MAX(salary * months)
        FROM
            Employee); 
