-- SOLUTION 1

-- While attempting this question, I made a silly mistake of considering distinct session_id instead of user_id (despite clearly mentioned in the question to count daily active USERS). Even if same user logs in at different time in a same day, it might have different session_id. For example: user_id = 4 logged in at morning on 2019-06-28 and again at night on the same day having different session_id, now, if we count(distinct session_id), it will give 2 whereas count(distinct user_id) will fetch 1! Devil is indeed in details!!!!!

SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM
    activity
WHERE
    activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date;

---------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    activity_date AS day, COUNT(DISTINCT user_id) active_users
FROM
    activity
WHERE
    DATEDIFF('2019-07-27', activity_date) <= 29
GROUP BY activity_date;