SELECT
  e.firstName,
  e.lastName,
  m.firstName AS ManagerFirstName,
  m.lastName AS ManagerLastName
from
  employee e
  INNER JOIN employee m ON e.managerId = m.employeeId;

SELECT
  e.employeeId,
  e.firstName,
  e.lastName
FROM
  employee e
  LEFT JOIN sales s ON e.employeeId = s.employeeId
WHERE
  s.salesId IS NULL
  AND e.title = 'Sales Person';

SELECT DISTINCT
  c.firstName,
  c.lastName,
  c.email,
  s.salesAmount,
  s.soldDate
FROM
  customer c
  FULL OUTER JOIN sales s ON c.customerId = s.customerId
ORDER BY c.firstName, c.lastName;