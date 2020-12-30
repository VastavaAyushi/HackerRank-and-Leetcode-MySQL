-- SOLUTION 1
-- Another way to display "NULL" is to use union all select null method.

with a as (select num, dense_rank() over (order by num desc) as denserank from my_numbers)

select a.num as num from a group by a.num having count(denserank) = 1 union all select null limit 1;

----------------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION (COOOOLL!!)

SELECT 
    MAX(T.NUM) AS NUM
FROM
    (SELECT 
        NUM
    FROM
        MY_NUMBERS
    GROUP BY NUM
    HAVING COUNT(NUM) = 1) AS T;
    
----------------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION 2

SELECT 
    IFNULL((SELECT 
                    num
                FROM
                    my_numbers
                GROUP BY 1
                HAVING COUNT(*) = 1
                ORDER BY num DESC
                LIMIT 1),
            NULL) AS num;

