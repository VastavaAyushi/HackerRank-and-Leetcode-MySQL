-- SOLUTION 1

SELECT 
    CASE
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN
            A = B AND A <> C OR A = C AND A <> B
                OR B = C AND A <> B
        THEN
            'Isosceles'
        ELSE 'Scalene'
    END
FROM
    Triangles;


-- select if((A+B)<=C or (A+C)<=B or (B+C)<=A, "Not a triangle", if(A==B or A==C or B==C, "Isosceles", if(A==B and B==C, "Equilateral", "Scalene"))) from triangles;
