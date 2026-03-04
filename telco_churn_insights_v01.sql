use TelcoChurn
go

--Churn rate by contract
SELECT
    Contract,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS ChurnRate,
    COUNT(*) AS Customers
FROM dbo.telcoclean
GROUP BY Contract;

--Top 100 high risk customers
SELECT TOP 100
    s.customerID,
    s.Churn_prob,
    s.Churn_flag,
    c.Contract,
    c.InternetService,
    c.MonthlyCharges,
    c.tenure
FROM dbo.telcochurnscore AS s
JOIN dbo.telcoclean AS c
    ON s.customerID = c.customerID
WHERE s.Churn_flag = 1
ORDER BY s.Churn_prob DESC;

--Churn rate by payment method
SELECT
    PaymentMethod,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS ChurnRate,
    COUNT(*) AS Customers
FROM dbo.telcoclean
GROUP BY PaymentMethod;


--Overall churn and non churn percentages
SELECT
    AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 AS ChurnPct,
    AVG(CASE WHEN Churn = 'No' THEN 1.0 ELSE 0 END) * 100 AS NotChurnPct
FROM dbo.telcoclean;



--Churn by tenure bucket
SELECT
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48'
        ELSE '49-72'
    END AS TenureGroup,
    COUNT(*) AS Customers,
    AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 AS ChurnRate
FROM dbo.telcoclean
GROUP BY CASE
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48'
        ELSE '49-72'
    END
ORDER BY MIN(tenure);


--Churn by MonthlyCharges band
SELECT
    CASE
        WHEN MonthlyCharges < 40 THEN '<40'
        WHEN MonthlyCharges BETWEEN 40 AND 70 THEN '40-70'
        WHEN MonthlyCharges BETWEEN 71 AND 90 THEN '71-90'
        ELSE '>90'
    END AS ChargeBand,
    COUNT(*) AS Customers,
    AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 AS ChurnRate
FROM dbo.telcoclean
GROUP BY CASE
        WHEN MonthlyCharges < 40 THEN '<40'
        WHEN MonthlyCharges BETWEEN 40 AND 70 THEN '40-70'
        WHEN MonthlyCharges BETWEEN 71 AND 90 THEN '71-90'
        ELSE '>90'
    END;


--High value, high risk customers
    SELECT TOP 100
    s.customerID,
    s.Churn_prob,
    c.TotalCharges,
    c.Contract,
    c.InternetService
FROM dbo.telcochurnscore AS s
JOIN dbo.telcoclean AS c
    ON s.customerID = c.customerID
WHERE s.Churn_flag = 1
  AND c.TotalCharges > 2000        -- high value filter
ORDER BY s.Churn_prob DESC;

--Churn rate by InternetService and Contract together
SELECT
    InternetService,
    Contract,
    COUNT(*) AS Customers,
    AVG(CASE WHEN Churn = 'Yes' THEN 1.0 ELSE 0 END) * 100 AS ChurnRate
FROM dbo.telcoclean
GROUP BY InternetService, Contract
ORDER BY InternetService, Contract;
















