-- SOLUTION 1

select player_id, device_id from (select player_id, device_id, dense_rank() over (partition by player_id order by event_date) as first_login from activity) as temp where temp.first_login = 1;

-------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION (same as above but don't know why it had the least runtime)

select player_id, device_id from
(select player_id, device_id, dense_rank() over (partition by player_id order by event_date) as rn
from activity) as t
where rn = 1;

---------------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    player_id, device_id
FROM
    Activity
WHERE
    (player_id , event_date) IN (SELECT 
            player_id, MIN(event_date)
        FROM
            Activity
        GROUP BY 1);