-- TASK 1
SELECT DISTINCT MANUFACTURER.COMPANY
FROM MANUFACTURER
INNER JOIN PRODUCT ON MANUFACTURER.BILL_ID=PRODUCT.BILL_ID
WHERE PRODUCT.WARE='Drinking water'
ORDER BY MANUFACTURER.COMPANY ASC


--TASK 2
SELECT DISTINCT PRODUCT.WARE, MANUFACTURER.COMPANY
FROM MANUFACTURER
INNER JOIN PRODUCT ON PRODUCT.BILL_ID = MANUFACTURER.BILL_ID
INNER JOIN CATEGORY ON CATEGORY.WARE=PRODUCT.WARE
WHERE CATEGORY.CLASS='Raw food'
ORDER BY PRODUCT.WARE, MANUFACTURER.COMPANY ASC


--TASK 3
SELECT DISTINCT PRODUCT.WARE
FROM  PRODUCT
INNER JOIN MATERIAL ON MATERIAL.BILL_ID=PRODUCT.BILL_ID
INNER JOIN CATEGORY ON CATEGORY.WARE=MATERIAL.WARE
WHERE CATEGORY.CLASS='Mineral'
ORDER BY PRODUCT.WARE ASC


--TASK 4
SELECT DISTINCT MANUFACTURER.COMPANY
FROM MANUFACTURER 
INNER JOIN CATEGORY ON CATEGORY.WARE=PRODUCT.WARE
INNER JOIN PRODUCT ON PRODUCT.BILL_ID=MANUFACTURER.BILL_ID
WHERE CATEGORY.CLASS='Food'

INTERSECT

SELECT DISTINCT MANUFACTURER.COMPANY
FROM MANUFACTURER
INNER JOIN PRODUCT ON PRODUCT.BILL_ID=MANUFACTURER.BILL_ID
INNER JOIN CATEGORY ON CATEGORY.WARE=PRODUCT.WARE 
WHERE CATEGORY.CLASS='Fuel'
ORDER BY MANUFACTURER.COMPANY ASC


--TASK 5
SELECT DISTINCT M1.COMPANY, P1.WARE AS FOOD, P2.WARE AS FUEL
FROM MANUFACTURER M1
INNER JOIN PRODUCT P1 ON M1.BILL_ID = P1.BILL_ID
INNER JOIN CATEGORY C1 ON C1.WARE = P1.WARE
INNER JOIN MANUFACTURER M2 ON M1.COMPANY = M2.COMPANY
INNER JOIN PRODUCT P2 ON M2.BILL_ID = P2.BILL_ID
INNER JOIN CATEGORY C2 ON C2.WARE = P2.WARE
WHERE C2.CLASS = 'Fuel' AND C1.CLASS = 'Food' 
ORDER BY M1.COMPANY ASC


--TASK 6
SELECT DISTINCT M1.COMPANY--,P1.WARE || ' | ' || P2.WARE AS PRODUCTS
FROM MANUFACTURER M1
INNER JOIN MANUFACTURER M2 ON M1.COMPANY = M2.COMPANY
INNER JOIN PRODUCT P1 ON M1.BILL_ID = P1.BILL_ID
INNER JOIN PRODUCT P2 ON M2.BILL_ID = P2.BILL_ID
INNER JOIN CATEGORY C1 ON C1.WARE = P1.WARE
INNER JOIN CATEGORY C2 ON C2.WARE = P2.WARE
WHERE C1.CLASS = C2.CLASS AND P1.WARE <> P2.WARE
ORDER BY M1.COMPANY ASC


--TASK 7 --LEFT JOIN

SELECT DISTINCT P.WARE--, C.CLASS, M.WARE
FROM PRODUCT P
LEFT JOIN MATERIAL M ON P.BILL_ID = M.BILL_ID
LEFT JOIN CATEGORY C ON M.WARE = C.WARE 
WHERE C.CLASS IS NULL OR C.CLASS = 'Mineral'

EXCEPT

SELECT DISTINCT P.WARE--,C.CLASS, M.WARE
FROM PRODUCT P
JOIN MATERIAL M ON P.BILL_ID = M.BILL_ID
JOIN CATEGORY C ON C.WARE = M.WARE
WHERE C.CLASS <> 'Mineral' 


--TASK 8
SELECT DISTINCT M1.COMPANY  
FROM MANUFACTURER M1
INNER JOIN MANUFACTURER M2 ON M1.COMPANY = M2.COMPANY
INNER JOIN PRODUCT P ON M1.BILL_ID = P.BILL_ID
INNER JOIN MATERIAL MA ON P.WARE = MA.WARE
WHERE M2.BILL_ID = MA.BILL_ID
ORDER BY M1.COMPANY ASC;