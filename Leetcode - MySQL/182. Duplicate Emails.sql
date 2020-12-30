-- SOLUTION 1

SELECT 
    email
FROM
    (SELECT 
        email AS email, COUNT(email) AS email_count
    FROM
        person
    GROUP BY email
    HAVING COUNT(email) > 1) AS temp;
    
--------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    Email
FROM
    (SELECT 
        Email, COUNT(Email) AS num
    FROM
        Person
    GROUP BY Email) AS statistic
WHERE
    num > 1;
    
---------------------------------------------------------------------------------

SELECT 
    email
FROM
    person
GROUP BY email
HAVING COUNT(email) > 1;