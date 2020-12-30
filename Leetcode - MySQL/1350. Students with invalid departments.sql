--------------------------------------------------------
-- SOLUTION 1

SELECT 
    s.id, s.name
FROM
    students s
WHERE
    s.id NOT IN (SELECT 
            id
        FROM
            departments);
select id, name from students s where department_id not in (select id from departments);

---------------------------------------------------------------------

-- SOLUTION 2 (faster than 99.30% of MySQL online submissions)

SELECT 
    s.id, s.name
FROM
    students s
        LEFT JOIN
    departments d ON s.department_id = d.id
WHERE
    d.name IS NULL;