-- SOLUTION 1.A

SELECT 
    c.company_code,
    group_concat(distinct c.founder),
    COUNT(lead_managers) AS total_lead_managers,
    COUNT(senior_managers) AS total_senior_managers,
    COUNT(managers) AS total_managers,
    COUNT(employees) AS total_employees
FROM
    Company AS c
        INNER JOIN
    (SELECT 
        lead_manager_code AS lead_managers
    FROM
        Lead_Manager) AS lm ON c.company_code = lm.company_code
        JOIN
    (SELECT 
        senior_manager_code AS senior_managers
    FROM
        Senior_Manager) AS sm ON lm.lead_manager_code = sm.lead_manager_code
        JOIN
    (SELECT 
        manager_code AS managers
    FROM
        Manager) AS m ON sm.senior_manager_code = m.senior_manager_code
        JOIN
    (SELECT 
        employee_code AS employees
    FROM
        Employee) AS emp ON m.manager_code = emp.manager_code
GROUP BY c.company_code
ORDER BY c.company_code ASC;

----------------------------------------------------------------------------------------------------------------

-- SOLUTION 1.B: Using multiple select statements

SELECT C.COMPANY_CODE,
       C.FOUNDER,
  (SELECT COUNT(DISTINCT LEAD_MANAGER_CODE)
   FROM LEAD_MANAGER L
   WHERE L.COMPANY_CODE = C.COMPANY_CODE),
  (SELECT COUNT(DISTINCT SENIOR_MANAGER_CODE)
   FROM SENIOR_MANAGER S
   WHERE S.COMPANY_CODE = C.COMPANY_CODE),
  (SELECT COUNT(DISTINCT MANAGER_CODE)
   FROM MANAGER M
   WHERE M.COMPANY_CODE = C.COMPANY_CODE),
  (SELECT COUNT(DISTINCT EMPLOYEE_CODE)
   FROM EMPLOYEE E
   WHERE E.COMPANY_CODE = C.COMPANY_CODE)
FROM COMPANY C
ORDER BY C.COMPANY_CODE ASC;

--------------------------------------------------------------------------------------------------------------------

-- SOLUTION 1.C: Using left join

select
    C.company_code, 
    group_concat(distinct C.founder),
    count(distinct LM.lead_manager_code),
    count(distinct SM.senior_manager_code),
    count(distinct M.manager_code),
    count(distinct E.employee_code)
from Company C
left join Lead_Manager LM on LM.company_code = C.company_code
left join Senior_Manager SM on SM.lead_manager_code = LM.lead_manager_code
left join Manager M on M.senior_manager_code = SM.senior_manager_code
left join Employee E on E.manager_code = M.manager_code
group by C.company_code
order by C.company_code;

---------------------------------------------------------------------------------------------------------------------

-- SOLUTION 1.D: Using Cross Join

SELECT 
    c.company_code,
    c.founder,
    COUNT(DISTINCT LM.lead_manager_code),
    COUNT(DISTINCT SM.senior_manager_code),
    COUNT(DISTINCT M.manager_code),
    COUNT(DISTINCT E.employee_code)
FROM
    company c,
    lead_manager lm,
    senior_manager sm,
    manager m,
    employee e
WHERE
    c.company_code = lm.company_code
        AND lm.lead_manager_code = sm.lead_manager_code
        AND sm.senior_manager_code = m.senior_manager_code
        AND m.manager_code = e.manager_code
GROUP BY c.company_code , c.founder
ORDER BY c.company_code;

