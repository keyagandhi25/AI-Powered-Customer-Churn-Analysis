Select gender, COUNT (gender) as TotalCount,
COUNT (gender) *100.0 / (Select COUNT  (*) FROM stg_Churn) as Percentage
From stg_Churn
Group By gender 

Select Contract, COUNT (Contract) as TotalCount,
COUNT (Contract) *100.0 / (Select COUNT  (*) FROM stg_Churn) as Percentage
From stg_Churn
Group By Contract  

--Calculate churn rate with total churn
Select Churn, COUNT (Churn) as TotalChurn, Sum(TotalCharges) as TotalRevenue,
SUM(TotalCharges) / (Select SUM(TotalCharges) from stg_Churn )*100 as RevPerecentage
from stg_Churn
Group by Churn

SELECT 
    SeniorCitizen,
    Churn,
    COUNT(*) AS Customers
FROM stg_Churn
GROUP BY SeniorCitizen, Churn;

--Customer churn by contract types
SELECT 
    Contract,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM stg_Churn
GROUP BY Contract;
--insight doscovered : month to month contract have highest churn risk

--Average monthly charges by churn
SELECT 
    Churn,
    AVG(MonthlyCharges) AS Avg_Monthly_Charges
FROM stg_Churn
GROUP BY Churn;

--Tenure analysis
SELECT 
    Churn,
    AVG(tenure) AS Avg_Tenure
FROM stg_Churn
GROUP BY Churn;
--insight: customer with churn has lower tenure

--Payment method analyis : Electronic customer churn more
SELECT 
    PaymentMethod,
    Churn,
    COUNT(*) AS Customers
FROM stg_Churn
GROUP BY PaymentMethod, Churn
ORDER BY PaymentMethod;

--Question: Do customers with tech support churn less?
--Answer: Customer without tech support churn more
SELECT 
    TechSupport,
    Churn,
    COUNT(*) AS Customers
FROM stg_Churn
GROUP BY TechSupport, Churn;

--Churn rate by tenure group by segments
--Insight: New customers are more likely to churn
    SELECT 
Tenure_Group,
COUNT(*) AS Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2
) AS Churn_Rate
FROM
(
SELECT *,
CASE
WHEN tenure < 12 THEN '0-1 Year'
WHEN tenure < 24 THEN '1-2 Years'
WHEN tenure < 48 THEN '2-4 Years'
ELSE '4+ Years'
END AS Tenure_Group
FROM stg_Churn
) t
GROUP BY Tenure_Group
ORDER BY Churn_Rate DESC;

    --Top 5 High risk customers likely to churn by monthly charge
    SELECT TOP 5
    customerID,
    tenure,
    MonthlyCharges,
    Contract
FROM stg_Churn
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC;

--Rank customer by lifetime value using Windows function
--Insight: this helps company to identify and retain top-value customers
SELECT 
    customerID,
    tenure,
    MonthlyCharges,
    tenure * MonthlyCharges AS Lifetime_Value,
    RANK() OVER (ORDER BY tenure * MonthlyCharges DESC) AS Customer_Rank
FROM stg_Churn;

SELECT DISTINCT InternetService
FROM stg_Churn;

--Query to check null values in each column
--Found out total charges column has 11 null values
SELECT 
SUM(CASE WHEN customerID IS NULL THEN 1 ELSE 0 END) AS customerID_Nulls,
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_Nulls,
SUM(CASE WHEN SeniorCitizen IS NULL THEN 1 ELSE 0 END) AS SeniorCitizen_Nulls,
SUM(CASE WHEN Partner IS NULL THEN 1 ELSE 0 END) AS Partner_Nulls,
SUM(CASE WHEN Dependents IS NULL THEN 1 ELSE 0 END) AS Dependents_Nulls,
SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS tenure_Nulls,
SUM(CASE WHEN PhoneService IS NULL THEN 1 ELSE 0 END) AS PhoneService_Nulls,
SUM(CASE WHEN InternetService IS NULL THEN 1 ELSE 0 END) AS InternetService_Nulls,
SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Nulls,
SUM(CASE WHEN PaymentMethod IS NULL THEN 1 ELSE 0 END) AS PaymentMethod_Nulls,
SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS MonthlyCharges_Nulls,
SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS TotalCharges_Nulls,
SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS Churn_Nulls
FROM stg_Churn;

--Creating new prod_Churn table and removing null USED AS source table

SELECT
    CustomerID,
    ISNULL(gender, 'Unknown') AS gender,
    ISNULL(SeniorCitizen, 0) AS SeniorCitizen,
    ISNULL(Partner, 'No') AS Partner,
    ISNULL(Dependents, 'No') AS Dependents,
    ISNULL(tenure, 0) AS tenure,
    ISNULL(PhoneService, 0) AS PhoneService,
       ISNULL(InternetService, 0) AS InternetService,
          ISNULL(Contract, 0) AS Contract,
             ISNULL(PaymentMethod , 0) AS PaymentMethod,
    ISNULL(MonthlyCharges, 0) AS MonthlyCharges,
    ISNULL(TotalCharges, 0) AS TotalCharges,
    ISNULL(Churn, 'No') AS Churn
INTO dbo.prod_Churn
FROM dbo.stg_Churn;

--View : Create virtual table in db, will not have physical presence in db, and provide output when query calls for it. Used for complex queries.