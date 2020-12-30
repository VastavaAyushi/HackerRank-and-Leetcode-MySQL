-- SOLUTION 1

with c as(select distinct title as title, content_id, sum(case when kids_content = 'Y' then 1 else 0 end) as kid_friendly from content where content_type = "Movies" group by 1 having kid_friendly > 0 order by kid_friendly)

select distinct c.title as TITLE from c join tvprogram tv on c.content_id = tv.content_id where tv.program_date between "2020-06-01" and "2020-06-30";

-------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION (WOW!!)

SELECT DISTINCT
    c.title
FROM
    content c
        INNER JOIN
    TVProgram t ON c.content_id = t.content_id
WHERE
    c.kids_content = 'Y'
        AND c.content_type = 'Movies'
        AND EXTRACT(MONTH FROM t.program_date) = 06;
        
-------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION 2

SELECT DISTINCT
    TITLE
FROM
    Content,
    TVProgram
WHERE
    Content.content_id = TVProgram.content_id
        AND Kids_content = 'Y'
        AND content_type = 'Movies'
        AND LEFT(program_date, 7) = '2020-06';