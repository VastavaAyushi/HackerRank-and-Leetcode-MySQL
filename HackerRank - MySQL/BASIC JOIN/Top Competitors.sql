-- SOLUTION 1

SELECT 
    h.hacker_id, h.name
FROM
    hackers h
        JOIN
    challenges c ON h.hacker_id = c.hacker_id
        JOIN
    difficulty d ON c.difficulty_level = d.difficulty_level
        JOIN
    submissions s ON c.challenge_id = s.challenge_id
        AND s.score = d.score
GROUP BY h.hacker_id , h.name
HAVING COUNT(s.hacker_id) > 1
ORDER BY COUNT(s.hacker_id) DESC , h.hacker_id ASC;

---------------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    H.HACKER_ID, H.NAME
FROM
    HACKERS H
        JOIN
    SUBMISSIONS S ON H.HACKER_ID = S.HACKER_ID
        JOIN
    DIFFICULTY D ON S.SCORE = D.SCORE
        JOIN
    CHALLENGES C ON S.CHALLENGE_ID = C.CHALLENGE_ID
        AND D.DIFFICULTY_LEVEL = C.DIFFICULTY_LEVEL
GROUP BY H.HACKER_ID , H.NAME
HAVING COUNT(S.SUBMISSION_ID) > 1
ORDER BY COUNT(S.SUBMISSION_ID) DESC , HACKER_ID ASC;
