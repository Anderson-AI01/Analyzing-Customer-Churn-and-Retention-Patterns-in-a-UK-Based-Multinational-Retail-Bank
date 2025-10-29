-- select to view my tables

select *
FROM dbo.accounts;

select *
FROM dbo.customerinfo;

-- i will be creating a staging to work on, just a practice for me

CREATE SCHEMA stg; 
GO

SELECT *
INTO stg.customer
FROM dbo.customerinfo;

SELECT *
INTO stg.accounts
FROM dbo.accounts;

-- for my data transformation or cleaning, i want to start by checking for duplicates 
-- i will be using my stating tables (column)

SELECT customerid, COUNT(*) AS dupicate
FROM stg.customer
GROUP BY customerid
HAVING COUNT(*) > 1;

-- checking for duplicates via row. 

SELECT *, COUNT(*) AS duplicate
FROM stg.customer
GROUP BY CustomerId, LastName, Country, Gender, Age
HAVING COUNT(*) > 1;

-- checking for duplicates in my second table (account table)

SELECT customerid, COUNT(*) AS dupicate
FROM stg.accounts
GROUP BY customerid
HAVING COUNT(*) > 1;

-- checking for Null values using the isnull function

SELECT
SUM(CASE WHEN customerid is NULL then 1 else 0 END) AS id_null, 
SUM(CASE WHEN LastName is NULL then 1 else 0 END) AS LN_null
FROM stg.customer;

-- we also use the statement above to check null in  accounts table 

SELECT
SUM(CASE WHEN customerid is NULL then 1 else 0 END) AS id_null, 
SUM(CASE WHEN CreditScore is NULL then 1 else 0 END) AS LN_null
FROM stg.accounts;


-- Now i will be checking for outliers

SELECT MIN(Age) AS Min_age, 
MAX(Age) AS MAX_age
FROM stg.customer;

SELECT MIN(CreditScore) AS Min_age, 
MAX(CreditScore) AS MAX_age, 
AVG(CreditScore) AS Avg_cs
FROM stg.accounts;

SELECT customerid, Balance
FROM stg.accounts
WHERE Balance < 0;

-- Number of customers in each country

SELECT Country, count(CustomerId)
FROM stg.customer
GROUP BY Country
ORDER BY count(CustomerId) DESC;

-- Distribution of Gender

SELECT Gender, count(CustomerId) AS no_of_customers
FROM stg.customer
GROUP BY Gender;

-- Churn Distribution

SELECT Exited, count(CustomerId)
FROM stg.accounts
GROUP BY Exited;

-- Active Distribution

SELECT ActiveMember, count(CustomerId)
FROM stg.accounts
GROUP BY ActiveMember;


-- Column Derivation

Alter table stg.accounts
Add ChurnStatus as 
case when Exited = 1 then 'Churned' else 'Not Churned' end

SELECT * 
FROM stg.accounts;

Alter table stg.accounts
Drop Column ChurnStatus;

Alter table stg.accounts
Add 
ActiveStatus Varchar(40),
ChurnStatus Varchar(40),
CreditScoreCat Varchar(40),
TenureCat Varchar(40),
BalanceCat Varchar(40),
ProductsCat Varchar(40);

Update stg.accounts
Set,
	ActiveStatus = Case
		when ActiveMember= 1 then 'Active'
		when ActiveMember = 0 then 'Inactive'
		else 'unknown'
		end, 

	ChurnStatus = Case
		when Exited = 1 then 'Churned'
		when Exited = 0 then 'Not Churned'
		else 'unknown'
		end, 

	CreditScoreCat = Case
		when CreditScore < 580 then 'Poor'
		when CreditScore between 580 and 669 then 'Fair'
		when CreditScore between 670 and 739 then 'Good'
		when CreditScore between 740 and 799 then 'Very Good'
		when CreditScore between 800 and 850 then 'Excellent'
		else 'Out of Range'
		end, 

	TenureCat = Case
		when Tenure <=2 then 'New'
		when Tenure between 3 and 5 then 'Established'
		else 'Loyal'
		end,

	BalanceCat = Case
		when Balance <30000 then '0 - 30,000'
		when Balance between 30001 and 50000 then '30,001 - 50,000'
		when Balance between 50001 and 80000 then '50,001 - 80,000'
		when Balance between 80001 and 100000 then '80,001 - 100,000'
		else '>100,000'
		end, 

	ProductsCat = case
		when Products <=1 then 'Low Engagement'
		when Products =2 then 'Moderate Engagement'
		when Products >=3 then 'High Engagement'
		else 'unknown'
		end;


select * from stg.customer
select * from stg.accounts


Alter table stg.customer
Add AgeGroup as
case when Age between 18 and 35 then '18 - 35'
	when Age between 36 and 45 then '36 - 45'
	when Age between 46 and 55 then '46 - 55'
	when Age between 56 and 65 then '56 - 65'
	else 'Above 65'
	end;


-- creating a view 

CREATE VIEW CustomerDetails AS
SELECT 
c.*,
a.CreditScore,
a.Tenure,
a.Balance,
a.Products,
a.CreditCard,
a.ActiveMember, 
a.Exited,
a.ActiveStatus,
a.ChurnStatus,
a.CreditScoreCat,
a.TenureCat, 
a.BalanceCat,
a.ProductsCat
from stg.customer AS c
Left join stg.accounts AS a
on c.CustomerId = a.CustomerId;

SELECT * 
FROM CustomerDetails

Drop view ChurnRiskLevel

CREATE VIEW ChurnRiskLevel AS
select
CustomerId,
LastName,
Age,
ActiveStatus,
ChurnStatus,
TenureCat,
BalanceCat,
ProductsCat,
Case 
when CreditScoreCat in ('Poor', 'Fair') and BalanceCat = '0 - 30,000' and ProductsCat = 'Low Engagement' and TenureCat = 'New' then 'High Risk'
when (CreditScoreCat in ('Poor', 'Fair') and BalanceCat in ('0 - 30,000', '30,001 - 50,000')) 
	or (CreditScoreCat in ('Poor', 'Fair') and ProductsCat = 'Low Engagament')
	or (BalanceCat in ('0 - 30,000', '30,0001 - 50,000') and ProductsCat = 'Low Engagament')
	then 'Elevated Risk'
when ProductsCat = 'Moderate Engagement' or TenureCat = 'Established'
	then 'Medium Risk'
else 'Low Risk' end as ChurnRiskLevel
from CustomerDetails;

select * from ChurnRiskLevel


-- Deep-Dive Analysis

-- Number of churn in each country

select Country, count(*) as no_of_churn
from CustomerDetails
where Exited = 1
group by Country
order by count(*)


-- Number of Churn in each country and gender

select Country, Gender, count(*) as no_of_churn
from CustomerDetails
where Exited = 1
group by Country, Gender


-- Overall Churn Rate

-- Total Customer
-- Total number of people who has churned
-- %age = no of churned customers/ total customer *100

select count(CustomerId) as Total_Customer, sum(case when Exited = 1 then 1 else 0 end) as no_of_churned,
100*sum(case when Exited = 1 then 1 else 0 end)/count(CustomerId) as pct
from CustomerDetails


-- Churn Rate by Age Group
select AgeGroup , count(CustomerId) as Total_Customer, sum(case when Exited = 1 then 1 else 0 end) as no_of_churned,
100*sum(case when Exited = 1 then 1 else 0 end)/count(CustomerId) as pct
from CustomerDetails
group by AgeGroup;

