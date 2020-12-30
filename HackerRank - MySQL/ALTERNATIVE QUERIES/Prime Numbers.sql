-- SOLUTION 1

select count(*) from information_schema.tables;

SELECT GROUP_CONCAT(NUMB SEPARATOR '&')
FROM (
    SELECT @num:=@num+1 as NUMB FROM
    information_schema.tables t1,
    information_schema.tables t2,
    (SELECT @num:=1) tmp
) tempNum
WHERE NUMB<=1000 AND NOT EXISTS(
        SELECT * FROM (
            SELECT @nu:=@nu+1 as NUMA FROM
                information_schema.tables t1,
                information_schema.tables t2,
                (SELECT @nu:=1) tmp1
                LIMIT 1000
            ) tatata
        WHERE FLOOR(NUMB/NUMA)=(NUMB/NUMA) AND NUMA<NUMB AND NUMA>1
    );

------------------------------------------------------------------------------------------------------------------------------------------

-- OPTIMIZED SOLUTION

set @potential_prime = 1; -- initializing potential_prime variable to 1

SET @divisor = 1; -- initializing divisor variable to 1

SELECT GROUP_CONCAT(POTENTIAL_PRIME SEPARATOR '&') FROM
    (SELECT @potential_prime := @potential_prime + 1 AS POTENTIAL_PRIME FROM
    information_schema.tables t1,
    information_schema.tables t2
    LIMIT 1000) list_of_potential_primes
WHERE NOT EXISTS(
    SELECT * FROM
        (SELECT @divisor := @divisor + 1 AS DIVISOR FROM
        information_schema.tables t3,
        information_schema.tables t4
        LIMIT 1000) list_of_divisors
    WHERE MOD(POTENTIAL_PRIME, DIVISOR) = 0 AND POTENTIAL_PRIME <> DIVISOR);
 