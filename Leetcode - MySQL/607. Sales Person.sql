-- SOLUTION 1

-- From looking at the tables and output expected, it is clear that company table will be used only to establish relationship between order table and itself to get the com_id of company name = "RED". Apart from that, company table can't be joined with salesperson due to absense of referential integrity between them. My idea was to first extract those sales_id that did business with company="RED" and after having those sales_id, finding the remaining ones using NOT IN.

with a as (SELECT 
    o.com_id, o.sales_id AS sales_id, s.name AS name -- After having executed the sub-query which results in o.com_id = 1, all these details are fetched basis on condition com_id = 1 or company name = RED
FROM
    orders o
        JOIN
    salesperson s USING (sales_id)
WHERE
    o.com_id = (SELECT -- this subquery saves com_id of company RED, which means, this sub-query will save o.com_id = 1
            com_id
        FROM
            company
        WHERE
            name = 'RED'))

-- Above query gives us sales_id of two names [John and Pam] because they did sales with company = RED. Having this information, we can easily find sales_id who didn't do any sales business with company RED by executing following query:

SELECT 
    s.name
FROM
    salesperson s
WHERE
    s.sales_id NOT IN (SELECT 
            a.sales_id
        FROM
            a);
            
----------------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

SELECT 
    name
FROM
    salesperson
WHERE
    sales_id NOT IN (SELECT 
            sales_id
        FROM
            orders o
                JOIN
            company c ON c.com_id = o.com_id
        WHERE
            c.name = 'RED');