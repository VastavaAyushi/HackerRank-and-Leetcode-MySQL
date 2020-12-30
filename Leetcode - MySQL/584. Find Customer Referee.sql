select ifnull(referee_id,0) as null_ids from customer; -- This gives the following output
-- OUTPUT = {"headers": ["null_id"], "values": [[0], [0], [2], [0], [1], [2]]}

-- Now we can easily exclude referee_ids which are equal to 2 resulting in inclusion of values (0,0,0,1)
SELECT 
    name
FROM
    customer
WHERE
    IFNULL(referee_id, 0) <> 2;
    
-- Solution 2

-- Select id with referee id = 2
SELECT id FROM customer WHERE referee_id=2;

-- In order to exclude the ids which have referee id = 2, we'll use "not in" 
SELECT name
FROM customer
WHERE id not in (SELECT id FROM customer WHERE referee_id=2);