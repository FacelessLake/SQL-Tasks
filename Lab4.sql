--0
SELECT m.COMPANY,
(SELECT p1.WARE
FROM PRODUCT p1, MANUFACTURER m1
WHERE p1.BILL_ID=m1.BILL_ID
AND m1.COMPANY=m.COMPANY
ORDER BY p1.PRICE DESC
LIMIT 1) AS EXP_WARE,
(SELECT p1.PRICE
FROM PRODUCT p1, MANUFACTURER m1
WHERE p1.BILL_ID=m1.BILL_ID
AND m1.COMPANY=m.COMPANY
ORDER BY p1.PRICE DESC
LIMIT 1) AS PRICE
FROM MANUFACTURER m
GROUP BY m.COMPANY;


--1
SELECT P.WARE, ROUND(AVG(P.PRICE),1) AS PRICE
FROM PRODUCT P
GROUP BY P.WARE
ORDER BY PRICE DESC
LIMIT 1;
 
 
--2
SELECT C.CLASS,
	           (SELECT C1.WARE
	            FROM CATEGORY C1
	            WHERE C1.CLASS = C.CLASS
	            LIMIT 1) AS PROD
FROM (SELECT DISTINCT CLASS FROM CATEGORY) C
ORDER BY C.CLASS;


--3
SELECT C.CLASS,
	           (SELECT P.WARE
		        FROM PRODUCT P
	            JOIN CATEGORY C1 ON P.WARE = C1.WARE
		        WHERE C.CLASS = C1.CLASS
		        ORDER BY P.PRICE DESC
		        LIMIT 1) AS WARE,
	           (SELECT P.PRICE
		        FROM PRODUCT P, CATEGORY C1
				JOIN CATEGORY C1
		        WHERE P.WARE = C1.WARE AND C.CLASS = C1.CLASS
		        ORDER BY P.PRICE DESC
		        LIMIT 1) AS PRICE
FROM (SELECT DISTINCT CLASS FROM CATEGORY) C
ORDER BY CLASS;


--4
SELECT MAN.COMPANY
FROM MANUFACTURER MAN

EXCEPT

SELECT MAN.COMPANY
FROM PRODUCT P
JOIN MANUFACTURER MAN ON MAN.BILL_ID = P.BILL_ID
JOIN (SELECT P.WARE, ROUND(AVG(P.PRICE),2) AS AVER
      FROM PRODUCT P
      GROUP BY P.WARE
      ORDER BY AVER DESC) AV
ON P.WARE = AV.WARE
WHERE AV.AVER * 1.2 > P.PRICE;


--5
SELECT C.CLASS, M.COMPANY, GROUP_CONCAT(DISTINCT P.WARE) AS PRODUCTS
FROM MANUFACTURER M
JOIN PRODUCT P ON M.BILL_ID = P.BILL_ID
JOIN CATEGORY C ON C.WARE = P.WARE
JOIN
	(SELECT C1.CLASS, COUNT(C1.WARE) AS CN
	 FROM CATEGORY C1
	 GROUP BY C1.CLASS) CNT
ON C.CLASS = CNT.CLASS
GROUP BY M.COMPANY, C.CLASS
HAVING COUNT(DISTINCT P.WARE) = CNT.CN
ORDER BY C.CLASS;


--6
SELECT MAN.BILL_ID, MAN.COMPANY, GROUP_CONCAT(DISTINCT P.WARE) AS PRODUCT, GROUP_CONCAT(DISTINCT M.WARE) AS MATERIALS, PR.MONEY
FROM MANUFACTURER MAN
JOIN PRODUCT P ON MAN.BILL_ID = P.BILL_ID
LEFT JOIN MATERIAL M ON M.BILL_ID = MAN.BILL_ID
JOIN (SELECT P.BILL_ID, SUM(P.PRICE*P.AMOUNT) AS MONEY
	  FROM PRODUCT P
	  GROUP BY P.BILL_ID) AS PR
ON PR.BILL_ID = MAN.BILL_ID
GROUP BY MAN.BILL_ID, MAN.COMPANY, PR.MONEY
ORDER BY MAN.COMPANY;