-- SOLUTION 1
select distinct u.name, ifnull(sum(r.distance) over (partition by r.user_id),0) as travelled_distance from users u left join rides r on u.id = r.user_id order by travelled_distance desc, u.name;

select distinct u.name, coalesce(sum(r.distance) over (partition by r.user_id),0) as travelled_distance from users u left join rides r on u.id = r.user_id order by travelled_distance desc, u.name;

--------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    U.Name AS name,
    COALESCE((SUM(R.distance)), 0) AS travelled_distance
FROM
    Users AS U
        LEFT JOIN
    Rides AS R ON U.id = R.user_id
GROUP BY U.Name
ORDER BY travelled_distance DESC , name ASC;

------------------------------------------------------------------------------------

-- SOLUTION 3

SELECT 
    u.name, IFNULL(SUM(r.distance), 0) AS travelled_distance
FROM
    users u
        LEFT JOIN
    rides r ON u.id = r.user_id
GROUP BY r.user_id
ORDER BY travelled_distance DESC , u.name ASC;