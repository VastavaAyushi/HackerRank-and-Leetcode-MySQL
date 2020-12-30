-- SOLUTION 1

SELECT N, -- select nodes 
    CASE -- case starts with multiple conditions
        WHEN P IS NULL THEN 'Root' -- if parent node is null for any N in BST, that means that node is a root (5 is N which has null parent)
        WHEN N IN (SELECT P FROM BST) THEN 'Inner' -- If value of N also exists in P, that means, it is not a leaf  node and has children, this has to be labelled as "Inner"
        ELSE 'Leaf' -- If any node is not root or inner, then it is definitely as a "leaf"
    END -- end the conditions
FROM BST
ORDER BY N; -- we have to order by the value of node

---------------------------------------------------------------------------------------------------------------------------

-- SOLUTION 2

SELECT 
    N,
    IF(P IS NULL,
        'Root',
        IF((SELECT 
                    COUNT(*)
                FROM
                    BST
                WHERE
                    P = B.N) > 0,
            'Inner',
            'Leaf'))
FROM
    BST AS B
ORDER BY N; -- Fancy code!!!
