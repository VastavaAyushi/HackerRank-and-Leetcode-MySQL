-- SOLUTION 1

-- As we want % of all the users corresponsing to each contest, the first idea that came to my mind was to have a table with 2 columns [contest_id, all the users who participated in that contest]. To achieve the second column, I thought of using GROUP_CONCAT because it will merge the users of each contest in a single column which will make it easier to count the users per contest. Executing the query gives the output as follows: 
-- QUERY: with a as (select count(distinct u.user_id) as users, r.contest_id as contest_id from users u right join register r using (user_id) group by r.contest_id)
-- select a.contest_id, group_concat(users) from a group by a.contest_id;
-- OUTPUT:{"headers": ["contest_id", "group_concat(users)"], "values": [[207, "1"], [208, "3"], [209, "3"], [210, "3"], [215, "2"]]}

-- Now we have the number of users per contest, final step will be to divide it by total number of users and multiple by 100 to get the percentage of users. In order to get the count of distinct users, second CTE is used as follows: b as (SELECT COUNT(DISTINCT u.user_id) AS total_users FROM users u)

-- Combining both the queries, we will get the final output

WITH a as (SELECT 
    COUNT(DISTINCT u.user_id) AS users,
    r.contest_id AS contest_id
FROM
    users u
        RIGHT JOIN
    register r USING (user_id)
GROUP BY r.contest_id),

b as (SELECT 
    COUNT(DISTINCT u.user_id) AS total_users
FROM
    users u)

SELECT 
    a.contest_id,
    ROUND((GROUP_CONCAT(users) / b.total_users) * 100,
            2) AS percentage
FROM
    a,
    b
GROUP BY a.contest_id
ORDER BY percentage DESC , a.contest_id ASC;

------------------------------------------------------------------------------------------------------------

-- SIMPLER SOLUTION 2

SELECT 
    contest_id,
    ROUND(COUNT(DISTINCT user_id) * 100 / (SELECT 
                    COUNT(*) 
                FROM
                    Users),
            2) AS percentage
FROM
    Register
GROUP BY contest_id
ORDER BY percentage DESC , contest_id;