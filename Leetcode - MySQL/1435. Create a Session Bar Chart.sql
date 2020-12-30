-- In bits and pieces

SELECT "[0-5>" AS BIN, COUNT(A.SESSION_ID) AS TOTAL FROM (SELECT SESSION_ID, ROUND((DURATION/60),2) AS MINUTES1 FROM SESSIONS WHERE (DURATION/60) BETWEEN 0 AND 4.99) AS A ORDER BY 1;
      
SELECT "[5-10>" AS BIN, COUNT(B.SESSION_ID) AS TOTAL FROM (SELECT SESSION_ID, ROUND((DURATION/60),2) AS MINUTES2 FROM SESSIONS WHERE (DURATION/60) BETWEEN 5 AND 9.99) AS B ORDER BY 1;

SELECT "[10-15> " AS BIN, COUNT(C.SESSION_ID) AS TOTAL FROM (SELECT SESSION_ID, ROUND((DURATION/60),2) AS MINUTES3 FROM SESSIONS WHERE (DURATION/60) BETWEEN 10 AND 14.99) AS C ORDER BY 1;

SELECT "15 or more" AS BIN, COUNT(D.SESSION_ID) AS TOTAL FROM (SELECT SESSION_ID, ROUND((DURATION/60),2) AS MINUTES4 FROM SESSIONS WHERE (DURATION/60) > 15) AS D ORDER BY 1;

-- Combining the above code using UNION ALL
SELECT 
    '[0-5>' AS BIN, COUNT(A.SESSION_ID) AS TOTAL
FROM
    (SELECT 
        SESSION_ID, ROUND((DURATION / 60), 2) AS MINUTES1
    FROM
        SESSIONS
    WHERE
        (DURATION / 60) BETWEEN 0 AND 4.99) AS A 
UNION ALL SELECT 
    '[5-10>' AS BIN, COUNT(B.SESSION_ID) AS TOTAL
FROM
    (SELECT 
        SESSION_ID, ROUND((DURATION / 60), 2) AS MINUTES2
    FROM
        SESSIONS
    WHERE
        (DURATION / 60) BETWEEN 5 AND 9.99) AS B 
UNION ALL SELECT 
    '[10-15>' AS BIN, COUNT(C.SESSION_ID) AS TOTAL
FROM
    (SELECT 
        SESSION_ID, ROUND((DURATION / 60), 2) AS MINUTES3
    FROM
        SESSIONS
    WHERE
        (DURATION / 60) BETWEEN 10 AND 14.99) AS C 
UNION ALL SELECT 
    '15 or more' AS BIN, COUNT(D.SESSION_ID) AS TOTAL
FROM
    (SELECT 
        SESSION_ID, ROUND((DURATION / 60), 2) AS MINUTES4
    FROM
        SESSIONS
    WHERE
        (DURATION / 60) > 15) AS D;


-- Optimal Solution

SELECT 
    a.bin AS BIN, SUM(a.counting) AS TOTAL
FROM
    (SELECT 
        '[0-5>' AS bin,
            IF((duration / 60) >= 0
                AND (duration / 60) < 5, 1, 0) AS counting
    FROM
        Sessions UNION ALL SELECT 
        '[5-10>' AS bin,
            IF((duration / 60) >= 5
                AND (duration / 60) < 10, 1, 0) AS counting
    FROM
        Sessions UNION ALL SELECT 
        '[10-15>' AS bin,
            IF((duration / 60) >= 10
                AND (duration / 60) < 15, 1, 0) AS counting
    FROM
        Sessions UNION ALL SELECT 
        '15 or more' AS bin,
            IF((duration / 60) >= 15, 1, 0) AS counting
    FROM
        Sessions) AS a
GROUP BY a.bin;


