-- SOLUTION 1

SELECT 
    p.firstname AS FirstName,
    p.lastname AS LastName,
    a.city AS City,
    a.state AS State
FROM
    person p
        LEFT JOIN
    address a ON p.personid = a.personid;
    
-----------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    P.FirstName, P.LastName, A.City, A.State
FROM
    Person P
        LEFT JOIN
    Address A USING (PersonId);