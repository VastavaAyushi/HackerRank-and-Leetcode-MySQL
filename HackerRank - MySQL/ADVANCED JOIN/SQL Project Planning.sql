-- SOLUTION 1

SELECT 
    a.Start_Date, MIN(b.End_Date) -- Why min()? To tag the first start_date to the closest end_date. When we run the second sub-query of selecting end_date that doesn't exist in start_date. We get many results from that. We need to select the end_date which is closest to the start_date because only that will satisfy the consecutive dates of project. Therefore, min(end_date) is used. For example: For 2015-10-01 as start date, we have many end_dates [20115-10-04, 2015-10-15, 2015-10-22 and so on], by using min(end_date), we'll get 2015-10-04 as the end_date and that is perfect!! Project 1: 2015-10-01 to 2015-10-04.
FROM
    (SELECT 
        Start_Date
    FROM
        Projects
    WHERE
        Start_Date NOT IN (SELECT 
                End_Date
            FROM
                Projects)) AS a, -- Threw error if not used end_date query without select. Selecting the start_date of project by checking iuf that particular start_date exists in end_date. For Example: 2015-10-01 doesn't exist in any End_date, hence, it can be taken as a start_date of one of the projects.
    (SELECT 
        End_Date
    FROM
        Projects
    WHERE
        End_Date NOT IN (SELECT 
                Start_Date
            FROM
                Projects)) AS b -- Similarly, if end_date doesn't exist in any start_date, then we can say that it marks the end_date of that particular project. For example: 2015-10-04 isn't in that start_date column, hence, it is the end_date of project that started on 2015-10-01
WHERE
    Start_Date < End_Date -- W/O this we won't get appropriate results. After a pair of (SD, ED) is selected, the query runs again and selects next (SD,ED) pair. Had this clause not existed, 2015-10-11 would choose 2015-10-04 as its ED, which would have been wrong!! Therefore, this clause ensures that 2015-10-11 tags to next date in ED sub-query (which is closest and greater to the SD) 
GROUP BY a.Start_Date
ORDER BY DATEDIFF(MIN(b.End_Date), Start_Date) , a.Start_Date;

-- FINAL SOLUTION

SELECT 
    a.Start_Date, MIN(b.End_Date) FROM
    (SELECT 
        Start_Date
    FROM
        Projects
    WHERE
        Start_Date NOT IN (SELECT 
                End_Date
            FROM
                Projects)) AS a,
    (SELECT 
        End_Date
    FROM
        Projects
    WHERE
        End_Date NOT IN (SELECT 
                Start_Date
            FROM
                Projects)) AS b
WHERE
    Start_Date < End_Date
    GROUP BY a.Start_Date
ORDER BY DATEDIFF(MIN(b.End_Date), Start_Date) , a.Start_Date;