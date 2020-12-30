-- MY SOLUTION

-- STEP 1
SELECT 
    st.student_id,
    st.student_name,
    su.subject_name,
    IFNULL(COUNT(e.subject_name), 0) AS attended_exams
FROM
    students st
        CROSS JOIN
    subjects su
        LEFT JOIN
    examinations e ON su.subject_name = e.subject_name
        AND st.student_id = e.student_id
GROUP BY st.student_id , st.student_name , su.subject_name
ORDER BY st.student_id , su.subject_name; 

-- OPTIMAL SOLUTION

SELECT DISTINCT
    s.student_id,
    student_name,
    t.subject_name,
    IFNULL(c, 0) AS attended_exams
FROM
    students s
        JOIN -- A join without "ON" clause is a cross join in MYSQL
    subjects t
        LEFT JOIN
    (SELECT 
        student_id, subject_name, COUNT(subject_name) AS c
    FROM
        examinations
    GROUP BY student_id , subject_name) m ON s.student_id = m.student_id
        AND m.subject_name = t.subject_name
ORDER BY s.student_id ASC , t.subject_name;