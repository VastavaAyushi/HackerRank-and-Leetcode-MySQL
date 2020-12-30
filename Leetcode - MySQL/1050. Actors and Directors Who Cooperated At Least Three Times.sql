-- SOLUTION 1

SELECT 
    actor_id, director_id -- Columns in output
FROM
    actordirector
GROUP BY actor_id , director_id -- This will give unique pairs of (actor_id, director_id)
HAVING COUNT(*) >= 3; -- Count(*) returns the count of primary key in the table