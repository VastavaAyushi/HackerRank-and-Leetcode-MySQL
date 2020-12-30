-- SOLUTION 1

SELECT 
    name,
    MAX(CASE
        WHEN Occupation = 'Doctor' THEN Name
        ELSE NULL
    END),
    MAX(CASE
        WHEN Occupation = 'Actor' THEN Name
        ELSE NULL
    END),
    MAX(CASE
        WHEN Occupation = 'Singer' THEN Name
        ELSE NULL
    END),
    MAX(CASE
        WHEN Occupation = 'Professor' THEN Name
        ELSE NULL
    END)
FROM
    Occupation
ORDER BY Name;

--------------------------------------------------------------------------------------------------------------

-- SOLUTION 2

SET @r1=0, @r2=0, @r3 =0, @r4=0; -- initializing each occupation's row variables
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor) FROM
(SELECT CASE Occupation WHEN 'Doctor' THEN @r1:=@r1+1
                       WHEN 'Professor' THEN @r2:=@r2+1
                       WHEN 'Singer' THEN @r3:=@r3+1
                       WHEN 'Actor' THEN @r4:=@r4+1 END
       AS RowLine,
       CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
       CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
       CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
       CASE WHEN Occupation = 'Actor' THEN Name END AS Actor
       FROM OCCUPATIONS ORDER BY Name) AS t
GROUP BY RowLine;

------------------------------------------------------------------------------------------------------------------

-- SOLUTION 3

SELECT *
FROM
  (SELECT MIN(DOCTOR) MIN_DOCTOR,
          MIN(PROFESSOR) MIN_PROFESSOR,
          MIN(SINGER) MIN_SINGER,
          MIN(ACTOR) MIN_ACTOR
   FROM
     (SELECT CASE
                 WHEN OCCUPATION = 'Doctor' THEN NAME
             END AS DOCTOR,
             CASE
                 WHEN OCCUPATION = 'Professor' THEN NAME
             END AS PROFESSOR,
             CASE
                 WHEN OCCUPATION = 'Singer' THEN NAME
             END AS SINGER,
             CASE
                 WHEN OCCUPATION = 'Actor' THEN NAME
             END AS ACTOR,
             RANK () OVER (PARTITION BY OCCUPATION  -- Assign a rank value to each row within a partition of a result set
                          ORDER BY NAME) AS ROW_RANK
      FROM OCCUPATIONS) X
   GROUP BY ROW_RANK)
ORDER BY MIN_DOCTOR,
         MIN_PROFESSOR,
         MIN_SINGER,
         MIN_ACTOR;
         
CREATE VIEW Occupation_Extended AS
    (SELECT 
        Occupation.*,
        CASE
            WHEN occupation = 'Doctor' THEN name
        END AS Doctor,
        CASE
            WHEN occupation = 'Actor' THEN name
        END AS Actor,
        CASE
            WHEN occupation = 'Singer' THEN name
        END AS Singer,
        CASE
            WHEN occupation = 'Professor' THEN name
        END AS Professor
    FROM
        Occupation);
        
CREATE VIEW Occupation_Pivot AS
    (SELECT 
        MIN(Doctor) AS Doctor,
        MIN(Actor) AS Actor,
        MIN(Singer) AS Singer,
        MIN(Professor) AS Professor
    FROM
        Occupation_Extended group by Name);
