-- SOLUTION 1

SELECT 
    temp.name AS Customers
FROM
    (SELECT 
        c.name, o.customerid AS customerid
    FROM
        customers c
    LEFT JOIN orders o ON c.id = o.customerid) AS temp
WHERE
    temp.customerid IS NULL;
    
--------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    Name AS Customers
FROM
    Customers
WHERE
    Id NOT IN (SELECT DISTINCT
            (CustomerId)
        FROM
            Orders);