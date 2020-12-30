-- SOLUTION 1
select player_id, min(event_date) as first_login from activity group by player_id order by player_id;

-- SOLUTION 2
SELECT 
    a.player_id, b.event_date
FROM
    activity a
        JOIN
    (SELECT 
        player_id, MIN(event_date) AS event_date
    FROM
        activity
    GROUP BY player_id) AS b ON a.player_id = b.player_id
        AND a.event_date = b.event_date;
        