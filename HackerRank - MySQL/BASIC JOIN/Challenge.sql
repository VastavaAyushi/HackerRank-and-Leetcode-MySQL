-- SOLUTION 1

/*
SELECT 
    h.hacker_id, h.name, max(b.challenge_id) as max_challenge_created from hackers h join challenges c on h.hacker_id = c.hacker_id where b.challenge_id = 
	(SELECT hacker_id,
            COUNT(hacker_id) as challenges_created
        FROM
            challenges group by hacker_id order by chalenges_created) as b
group by h.hacker_id, h.name having order BY COUNT(challenges) DESC , hacker_id;
*/

select h.hacker_id, h.name, count(c.challenge_id) from hackers h join challenges c on h.hacker_id = c.hacker_id group by h.hacker_id, h.name; -- gives us a table of total challenges submitted by hacker_id and their names.

SELECT COUNT(c1.challenge_id) AS challenges_created FROM challenges c1 GROUP BY c1.hacker_id ORDER BY challenges_created desc limit 1; -- This will give output of total no. of challenges grouped by hacker_id limiting to 1 result. Limit 1 because students included in the output should satisfy either of the two requirements: the total number is the maximum or the number only appears once. 

SELECT 
    c.hacker_id, h.name, COUNT(c.challenge_id) AS cnt
FROM
    Hackers AS h
        JOIN
    Challenges AS c ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id , h.name
HAVING cnt = (SELECT 
        COUNT(c1.challenge_id)
    FROM
        Challenges AS c1
    GROUP BY c1.hacker_id
    ORDER BY COUNT(*) DESC
    LIMIT 1)
    OR cnt NOT IN (SELECT 
        COUNT(c2.challenge_id)
    FROM
        Challenges AS c2
    GROUP BY c2.hacker_id
    HAVING c2.hacker_id <> c.hacker_id)
ORDER BY cnt DESC , c.hacker_id;