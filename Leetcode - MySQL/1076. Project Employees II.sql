-- SOLUTION 1

with a as (select project_id, count(distinct employee_id) as employee_count from project group by project_id)

select a.project_id from a where a.employee_count = (select max(a.employee_count) from a);

------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

select project_id from (
select project_id, dense_rank () over(order by count(distinct employee_id) desc) rnk
from project
group by 1 ) a
where rnk = 1;

------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION 2 (Barely different from Solution 1!)

with tbl1 as (select project_id, count(*) as cnt from Project
group by project_id)

select project_id from tbl1
where cnt=(select max(cnt) from tbl1);