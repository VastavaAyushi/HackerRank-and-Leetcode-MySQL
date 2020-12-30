-- SOLUTION 1

SELECT 
    e.name, b.bonus
FROM
    employee e
        LEFT JOIN
    bonus b USING (empid)
WHERE
    b.bonus < 1000 OR b.bonus IS NULL;
    
---------------------------------------------------------------

-- OPTIMIZED SOLUTION

-- COALESCE is used to return first non-null expression in a list or for replacing null values by a value of choice. In this case, in order to use comparision operator on bonus, we need to have all the bonus in the form of "int". To facilitate this, I replaced bonus with "Null" values by 0 using COALESCE function. Post replacement, condition of bonus <1000 can be easily used. To understand better, you can first run this query: SELECT e.name, coalesce(b.bonus,0) as bonus FROM employee e LEFT JOIN bonus b USING (empid);

SELECT 
    e.name, b.bonus
FROM
    employee e
        LEFT JOIN
    bonus b USING (empid)
WHERE
    COALESCE(b.bonus, 0) < 1000;