-- SOLUTION 1

with a as (select seat_id,free, lag(free,1) over (order by seat_id) as lag_free, lead(free,1) over (order by seat_id) as lead_free from cinema)

SELECT 
    a.seat_id
FROM
    a
WHERE
    a.free = 1
        AND (a.lag_free = 1 OR a.lead_free = 1)
ORDER BY seat_id;

--------------------------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    seat_id
FROM
    cinema
WHERE
    free = 1
        AND (seat_id - 1 IN (SELECT 
            seat_id
        FROM
            cinema
        WHERE
            free = 1)
        OR seat_id + 1 IN (SELECT 
            seat_id
        FROM
            cinema
        WHERE
            free = 1));
            
------------------------------------------------------------------------------------------------------------
            
-- OPTIMIZED SOLUTION

SELECT DISTINCT
    a.seat_id
FROM
    cinema a
        JOIN
    cinema b ON ABS(a.seat_id - b.seat_id) = 1
        AND a.free = TRUE
        AND b.free = TRUE
ORDER BY a.seat_id
;