-- SOLUTION 1

SELECT 
    patient_id, patient_name, conditions
FROM
    patients
WHERE
    conditions LIKE '%DIAB1%'
ORDER BY patient_id;

-----------------------------------------------------------

-- SOLUTION 2 (faster than 99.05% of MySQL online submissions)

SELECT 
    patient_id, patient_name, conditions
FROM
    patients
WHERE
    conditions LIKE '%DIAB1%' OR 'DIAB1%';