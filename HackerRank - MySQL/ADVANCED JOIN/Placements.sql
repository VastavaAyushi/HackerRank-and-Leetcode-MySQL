-- SOLUTION 1

SELECT 
    s.name,
    (SELECT 
            p.salary AS Students_salary
        FROM
            Students s
                JOIN
            Packages p ON s.ID = p.ID),
    (SELECT 
            p.salary AS Friends_salary
        FROM
            Friends f
                JOIN
            Packages p ON f.ID = p.ID)
FROM
    Students s
WHERE
    Friends_salary > Students_salary
ORDER BY Friends_salary; -- Partially correct. Here we can see that both students and friends salary need to establish relation with same Packages table. In such cases, it is good to use self-join. 

-----------------------------------------------------------------------------------------------------------------------------------------------

-- CORRECT SOLUTION

SELECT 
    s.name
FROM
    (Students s
    JOIN Friends f USING (ID)
    JOIN Packages p1 ON p1.ID = s.ID
    JOIN Packages p2 ON p2.ID = f.Friend_ID)
WHERE
    p2.Salary > p1.Salary
ORDER BY p2.Salary;
