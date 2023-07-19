SELECT
  e.firstName,
  e.lastName,
  COUNT(*) AS countOfSales
FROM
  sales s
  INNER JOIN employee e ON s.employeeId = e.employeeId
WHERE
  s.soldDate >= DATE ('now', 'start of year')
GROUP BY
  e.employeeId,
  e.firstName,
  e.lastName
ORDER BY
  countOfSales DESC;

SELECT
  e.firstName,
  e.lastName,
  MAX(s.salesAmount) AS MaxSold,
  MIN(s.salesAmount) AS MinSold
FROM
  sales s
  INNER JOIN employee e ON s.employeeId = e.employeeId
WHERE
  s.soldDate >= DATE ('now', 'start of year')
GROUP BY
  e.employeeId,
  e.firstName,
  e.lastName;

SELECT
  e.firstName,
  e.lastName,
  COUNT(*) AS countOfSales
FROM
  sales s
  INNER JOIN employee e ON s.employeeId = e.employeeId
WHERE
  s.soldDate >= DATE ('now', 'start of year')
GROUP BY
  e.employeeId,
  e.firstName,
  e.lastName
HAVING
  COUNT(*) > 5;