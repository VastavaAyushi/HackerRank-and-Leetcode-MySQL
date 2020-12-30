-- SOLUTION 1

-- total score is to be fetched from submissions table, hence, there is a separate query written for that.
select h.hacker_id, name, sum(score) as total_score
from
hackers as h inner join
/* find max_score*/
(select hacker_id, max(score) as score from submissions group by CHALLENGE_ID, hacker_id) AS max_score
-- We need to fetch the score w.r.t. hacker_id and challenge taken by repective ids, therefore grouped by challenge and id
on h.hacker_id=max_score.hacker_id
group by h.hacker_id, name -- group by columns which don't have aggregate function with them. Hence, id and name but not score.

/* don't accept hackers with total_score=0 */
having total_score > 0 -- not accepting total score zero. having can be used after group by only.

/* finally order as required */
order by total_score desc, h.hacker_id -- as mentioned in question.
;

-- FINAL SOLUTION

SELECT 
    h.hacker_id, name, SUM(score) AS total_score
FROM
    hackers AS h
        INNER JOIN
    (SELECT 
        hacker_id, MAX(score) AS score
    FROM
        submissions
    GROUP BY CHALLENGE_ID , hacker_id) AS max_score ON h.hacker_id = max_score.hacker_id
GROUP BY h.hacker_id , name
HAVING total_score > 0
ORDER BY total_score DESC , h.hacker_id;