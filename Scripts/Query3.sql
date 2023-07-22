WITH
  cte AS (
    SELECT
      strftime ('%Y', s.soldDate) AS soldYear,
      s.salesAmount
    FROM
      sales s
  )
SELECT
  soldYear,
  FORMAT ('$%.2f', sum(salesAmount)) AS totalSalesAmount
FROM
  cte
GROUP BY
  soldYear;

WITH
  cte AS (
    SELECT
      employeeId,
      CASE
        WHEN strftime ('%m', soldDate) = '01' THEN salesAmount
        ELSE 0
      END AS JanSales,
      CASE
        WHEN strftime ('%m', soldDate) = '02' THEN salesAmount
        ELSE 0
      END AS FebSales,
      CASE
        WHEN strftime ('%m', soldDate) = '03' THEN salesAmount
        ELSE 0
      END AS MarSales,
      CASE
        WHEN strftime ('%m', soldDate) = '04' THEN salesAmount
        ELSE 0
      END AS AprSales,
      CASE
        WHEN strftime ('%m', soldDate) = '05' THEN salesAmount
        ELSE 0
      END AS MaySales,
      CASE
        WHEN strftime ('%m', soldDate) = '06' THEN salesAmount
        ELSE 0
      END AS JunSales,
      CASE
        WHEN strftime ('%m', soldDate) = '07' THEN salesAmount
        ELSE 0
      END AS JulySales,
      CASE
        WHEN strftime ('%m', soldDate) = '08' THEN salesAmount
        ELSE 0
      END AS AugSales,
      CASE
        WHEN strftime ('%m', soldDate) = '09' THEN salesAmount
        ELSE 0
      END AS SepSales,
      CASE
        WHEN strftime ('%m', soldDate) = '10' THEN salesAmount
        ELSE 0
      END AS OctSales,
      CASE
        WHEN strftime ('%m', soldDate) = '11' THEN salesAmount
        ELSE 0
      END AS NovSales,
      CASE
        WHEN strftime ('%m', soldDate) = '12' THEN salesAmount
        ELSE 0
      END AS DecSales
    FROM
      sales
    WHERE
      strftime ('%Y', soldDate) = '2021'
  )
SELECT
  e.firstName,
  e.lastName,
  sum(cte.JanSales) AS totalJanSales,
  sum(cte.FebSales) AS totalFebSales,
  sum(cte.MarSales) AS totalMarSales,
  sum(cte.AprSales) AS totalAprSales,
  sum(cte.MaySales) AS totalMaySales,
  sum(cte.JunSales) AS totalJunSales,
  sum(cte.JulySales) AS totalJulySales,
  sum(cte.AugSales) AS totalAugSales,
  sum(cte.SepSales) AS totalSepSales,
  sum(cte.OctSales) AS totalOctSales,
  sum(cte.NovSales) AS totalNovSales,
  sum(cte.DecSales) AS totalDecSales
FROM
  employee e
  INNER JOIN cte ON e.employeeId = cte.employeeId
GROUP BY
  e.employeeId,
  e.firstName,
  e.lastName;


SELECT s.salesId, s.salesAmount, s.soldDate, s.inventoryId
FROM sales s
WHERE s.inventoryId IN (
  SELECT i.inventoryId
  from inventory i INNER JOIN model m ON i.modelId = m.modelId
  where m.EngineType = 'Electric'
);
