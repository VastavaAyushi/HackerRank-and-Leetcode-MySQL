-- SOLUTION 1

SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM
    project p
        JOIN
    employee e USING (employee_id)
GROUP BY project_id;

---------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    project_id, ROUND(AVG(experience_years), 2) AS average_years
FROM
    project p
        LEFT JOIN
    employee e ON p.employee_id = e.employee_id
GROUP BY 1;