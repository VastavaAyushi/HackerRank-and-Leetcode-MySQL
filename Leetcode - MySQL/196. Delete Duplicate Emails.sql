-- SOLUTION 1

DELETE p1 FROM person p1
INNER JOIN person p2 
WHERE
    p1.id > p2.id AND 
    p1.email = p2.email;
    
---------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION 

-- The subquery fetches minimum id of all emails in the table. If the subquery is run separately, it will output a table with unique email and corresponsding minimum id of those emails (in case of duplicate records as well). Now, the next step is easy, delete all records whose id is not minimum. 

DELETE FROM Person 
WHERE
    Id NOT IN (SELECT 
        A.Id
    FROM
        (SELECT 
            MIN(Id) AS Id
        FROM
            Person
        GROUP BY Email) as A);