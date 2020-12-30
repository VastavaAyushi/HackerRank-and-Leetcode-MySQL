-- SOLUTION 1

SELECT 
    a.tweet_id
FROM
    (SELECT 
        tweet_id, LENGTH(content) AS char_length
    FROM
        tweets
    GROUP BY tweet_id
    HAVING char_length > 15) AS a; 