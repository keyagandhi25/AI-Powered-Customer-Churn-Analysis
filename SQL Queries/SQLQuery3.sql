--Created view for Power BI where Yes corresponds to Churn and No corresponds to Stayed
--vw_ChurnData can be used for churn analysis dashboards (pie charts, churn rates by gender, contract type, etc.)

Create or ALTER VIEW vw_ChurnData AS 
Select * from prod_Churn where Churn  In ('Yes' , 'No')


--This treates all customers with tenure 1 as newly joined
--vw_JoinData can be used if you want to analyze new customer patterns.
CREATE VIEW vw_JoinData AS
SELECT *
FROM prod_Churn
WHERE tenure = 1;