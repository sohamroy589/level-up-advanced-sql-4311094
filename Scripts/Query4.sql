WITH
  salesWithModels AS (
    SELECT
      s.employeeId,
      m.model,
      COUNT(*) AS salesCount
    FROM
      sales s
      INNER JOIN inventory i ON s.inventoryId = i.inventoryId
      INNER JOIN model m ON m.modelId = i.modelId
    WHERE
      s.employeeId IN (
        SELECT
          employeeId
        FROM
          employee
        WHERE
          title = 'Sales Person'
      )
    GROUP BY
      s.employeeId,
      m.model
  )
SELECT
  *,
  DENSE_RANK() OVER (
    PARTITION BY
      sm.employeeId
    ORDER BY
      sm.salesCount DESC
  ) AS SalesRank
FROM
  salesWithModels sm;

WITH
  salesPerMonth AS (
    SELECT
      strftime ('%Y', soldDate) AS year,
      strftime ('%m', soldDate) AS month,
      SUM(salesAmount) AS salesAmountOfMonth
    FROM
      sales
    GROUP BY
      year,
      month
  )
SELECT
  year,
  month,
  salesAmountOfMonth,
  SUM(salesAmountOfMonth) OVER (
    PARTITION BY
      year
    ORDER BY
      month
  ) AS yearlyRunningSum
FROM
  salesPerMonth;

SELECT
  strftime ('%Y', soldDate) AS year,
  strftime ('%m', soldDate) AS month,
  LAG(COUNT(*), 1, 0) OVER salesPerMonthWindow AS salesCountPrevMonth,
  COUNT(*) AS salesCountThisMonth
FROM
  sales
GROUP BY year, month
WINDOW salesPerMonthWindow AS (ORDER BY strftime('%Y-%m', soldDate));
