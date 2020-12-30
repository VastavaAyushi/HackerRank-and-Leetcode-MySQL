-- SOLUTION 1

-- ATTEMPT 1
SELECT 
    ct.contest_id,
    ct.hacker_id,
    ct.name,
    ss.total_submissions,
    ss.total_accepted_submissions,
    vs.total_views,
    vs.total_unique_views
FROM
    Contests ct
        JOIN
    Colleges co ON ct.contest_id = co.contest_id
        JOIN
    Challenges ch ON co.college_id = ch.college_id
        JOIN
    (SELECT 
        challenge_id,
            SUM(total_submissions) AS total_submissions,
            SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM
        Submission_Stats
    GROUP BY challenge_id) AS ss ON ch.challenge_id = ss.challenge_id
        JOIN
    (SELECT 
        challenge_id,
            SUM(total_views) AS total_views,
            SUM(total_unique_views) AS total_unique_views
    FROM
        View_Stats
    GROUP BY challenge_id) AS vs ON ss.challenge_id = vs.challenge_id
GROUP BY ct.contest_id , ct.hacker_id , ct.name
HAVING total_submissions != 0
    OR total_accepted_submissions != 0
    OR total_views = 0
    OR total_unique_views != 0
ORDER BY ct.contest_id;

---------------------------------------------------------------------------------------------------------------

-- ATTEMPT 2

SELECT 
    ct.contest_id,
    ct.hacker_id,
    ct.name,
    SUM(ss.total_submissions) AS total_submissions,
    SUM(ss.total_accepted_submissions) AS total_accepted_submissions,
    SUM(vs.total_views) AS total_views,
    SUM(vs.total_unique_views) AS total_unique_views
FROM
    Contests ct
        JOIN
    Colleges co ON ct.contest_id = co.contest_id
        JOIN
    Challenges ch ON co.college_id = ch.college_id
        JOIN
    View_Stats vs ON ch.challenge_id = vs.challenge_id
        JOIN
    Submission_Stats ss ON vs.challenge_id = ss.challenge_id
GROUP BY ct.contest_id , ct.hacker_id , ct.name
HAVING total_submissions != 0
    OR total_accepted_submissions != 0
    OR total_views != 0
    OR total_unique_views != 0
ORDER BY ct.contest_id;

----------------------------------------------------------------------------------------------------------------------------

-- ATTEMPT 3

SELECT 
    ct.contest_id,
    ct.hacker_id,
    ct.name,
	SUM(ss.total_submissions) AS total_submissions, -- In order to group by only using Contest's columns, we need to use aggregate function for rest of the selections
    SUM(ss.total_accepted_submissions) AS total_accepted_submissions,
    SUM(vs.total_views) AS total_views,
    SUM(vs.total_unique_views) AS total_unique_views
FROM
    Contests ct
        JOIN
    Colleges co ON ct.contest_id = co.contest_id
        JOIN
    Challenges ch ON co.college_id = ch.college_id
        left JOIN
    (SELECT 
        challenge_id,
            SUM(total_submissions) AS total_submissions,
            SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM
        Submission_Stats
    GROUP BY challenge_id) AS ss ON ch.challenge_id = ss.challenge_id
        left JOIN
    (SELECT 
        challenge_id,
            SUM(total_views) AS total_views,
            SUM(total_unique_views) AS total_unique_views
    FROM
        View_Stats
    GROUP BY challenge_id) AS vs ON ss.challenge_id = vs.challenge_id
GROUP BY ct.contest_id , ct.hacker_id , ct.name
HAVING total_submissions != 0
    OR total_accepted_submissions != 0
    OR total_views != 0
    OR total_unique_views != 0
ORDER BY ct.contest_id;

-------------------------------------------------------------------------------------------------------------------------

-- FINAL SOLUTION

SELECT CON.CONTEST_ID,
       CON.HACKER_ID,
       CON.NAME,
       SUM(TOTAL_SUBMISSIONS),
       SUM(TOTAL_ACCEPTED_SUBMISSIONS),
       SUM(TOTAL_VIEWS),
       SUM(TOTAL_UNIQUE_VIEWS)
FROM CONTESTS CON
JOIN COLLEGES COL ON CON.CONTEST_ID = COL.CONTEST_ID
JOIN CHALLENGES CHA ON COL.COLLEGE_ID = CHA.COLLEGE_ID
LEFT JOIN
  (SELECT CHALLENGE_ID,
          SUM(TOTAL_VIEWS) AS TOTAL_VIEWS,
          SUM(TOTAL_UNIQUE_VIEWS) AS TOTAL_UNIQUE_VIEWS
   FROM VIEW_STATS
   GROUP BY CHALLENGE_ID) VS ON CHA.CHALLENGE_ID = VS.CHALLENGE_ID
LEFT JOIN
  (SELECT CHALLENGE_ID,
          SUM(TOTAL_SUBMISSIONS) AS TOTAL_SUBMISSIONS,
          SUM(TOTAL_ACCEPTED_SUBMISSIONS) AS TOTAL_ACCEPTED_SUBMISSIONS
   FROM SUBMISSION_STATS
   GROUP BY CHALLENGE_ID) SS ON CHA.CHALLENGE_ID = SS.CHALLENGE_ID
GROUP BY CON.CONTEST_ID,
         CON.HACKER_ID,
         CON.NAME
HAVING SUM(TOTAL_SUBMISSIONS) != 0
OR SUM(TOTAL_ACCEPTED_SUBMISSIONS) != 0
OR SUM(TOTAL_VIEWS) != 0
OR SUM(TOTAL_UNIQUE_VIEWS) != 0
ORDER BY CONTEST_ID;
