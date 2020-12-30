-- SOLUTION 1 [Self-join with aggregate function]

SELECT 
    e.employee_id, COUNT(t.team_id) AS team_size
FROM
    employee e
        JOIN
    employee t ON e.team_id = t.team_id
GROUP BY e.employee_id
ORDER BY e.employee_id;

-- This is an example of self-join wherein we are establishing connection between same column of a  table. For doing so, we must give different alias of the same table name, in our case, employee. In simple words, we have to count the total number of team_id with same team_id for each employee_id. Therefore, team_id of first virtual table (e) is compared with team_id of second alias table (t) and count of such equalities are fetched.

--------------------------------------------------------------------------------

-- SOLUTION 2 (faster than 99.34% of MySQL online submissions)

select employee_id, 
COUNT(employee_id) OVER 
(PARTITION BY team_id) as team_size
from Employee;

-- OR

select employee_id, count(team_id) over (partition by team_id) as team_size from employee order by employee_id; 
-- Parition by team_id: SQL PARTITION BY clause with the OVER clause to specify the column on which we need to perform aggregation. We want to count team_id, therefore, used partition on team_id. Reference: https://www.sqlshack.com/sql-partition-by-clause-overview/