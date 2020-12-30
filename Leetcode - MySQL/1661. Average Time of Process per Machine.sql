-- SOLUTION 1

-- This problem involves two calculations: a. sum of difference of timestamps for each process in each machine, and b. finding average of the time obtained in a. [to be named as processing_time in the output/result table]

-- First we'll calculate the difference between start and end time of process for each machine. For performing this, we will have to use self-join to subtract timestamp="start" from timestamp="end" from the same table. I did it using the following code:

SELECT 
    a.machine_id AS machine_id,
    a.process_id AS process_id,
    ROUND((a.timestamp - b.timestamp), 3) AS difference
FROM
    activity a
        JOIN
    activity b ON a.machine_id = b.machine_id -- Because (machine_id,process_id) are the primary key
        AND a.process_id = b.process_id
WHERE
    a.activity_type = 'end'
        AND b.activity_type = 'start';
        
-- Output of the above query looks like: {"headers": ["machine_id", "process_id", "difference"], "values": [[0, 0, 0.808], [0, 1, 0.98], [1, 0, 1.0], [1, 1, 0.99], [2, 0, 0.412], [2, 1, 2.5]]}

-- By looking at the output, we now have to add the time of same process_id [0.808+0.98 and so on...] and divide it by the count of distinct processes in the table [which is 2 {0 and 1}]. This can be achieved by following code:

SELECT 
    a.machine_id,
    ROUND(SUM(difference) / COUNT(DISTINCT process_id),
            3) AS processing_time
FROM
    a
GROUP BY a.machine_id;

-- Combining the sub-parts, final solution is:

with a as (SELECT a.machine_id AS machine_id, a.process_id as process_id, round((a.timestamp - b.timestamp),3) AS difference FROM activity a join activity b ON a.machine_id = b.machine_id and a.process_id = b.process_id WHERE a.activity_type = "end" AND b.activity_type = "start")

select a.machine_id, round(sum(difference)/count(distinct process_id),3) as processing_time from a group by a.machine_id;

-----------------------------------------------------------------------------------------------------------------------------------

-- BEST OPTIMIZED SOLUTION

SELECT 
    temp.machine_id, ROUND(AVG(temp.diff), 3) processing_time
FROM
    (SELECT 
        machine_id,
            process_id,
            SUM(CASE
                WHEN activity_type = 'start' THEN - 1 * timestamp -- Say -1 * 0.712
                WHEN activity_type = 'end' THEN timestamp -- Say 1.520
                ELSE 0
            END) AS diff 
    FROM
        activity
    GROUP BY machine_id , process_id) AS tmp
GROUP BY machine_id;

----------------------------------------------------------------------------------------------------------------------------------------

-- SIMPLER SOLUTION

SELECT s.machine_id, ROUND(AVG(e.timestamp-s.timestamp), 3) AS processing_time
FROM Activity s JOIN Activity e ON
    s.machine_id = e.machine_id AND s.process_id = e.process_id AND
    s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY s.machine_id;