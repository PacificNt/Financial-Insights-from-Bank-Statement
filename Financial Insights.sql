--Table check
Select *
From JuneToJanuary




--Checking Data Types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'JuneToJanuary'





--Replace the commas(",") in the "Amount"column with points(".") to facilitate calculations and data type convertion later
UPDATE JuneToJanuary
SET Amount =  REPLACE(Amount, ',', '.')




--Verify the change
Select *
From JuneToJanuary




--Clean the "Description" column
UPDATE JuneToJanuary
SET Description = REPLACE(Description,'[image]', '')




 --Check the result
Select *
From JuneToJanuary



--Convert the "Date" column from datetime to date
ALTER TABLE JuneToJanuary
ALTER COLUMN Date DATE




--Checking Data Types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'JuneToJanuary'


--Check the result
Select *
From JuneToJanuary


--- Add new columns for categorizations
Alter Table JuneToJanuary 
Add Amount_Clean float,
	Balance_clean float,
    TransactionType nvarchar(50),
	Category nvarchar(50),
	SubCategory nvarchar(50)




--- Set or add values to the 'Amount_Clean' Column
UPDATE JuneToJanuary
SET Amount_Clean = 
    CASE 
	 WHEN Amount LIKE '%Cr' THEN CAST(SUBSTRING(Amount, 1, LEN(Amount) - 2) AS DECIMAL(18, 2))
     ELSE CAST(Amount AS DECIMAL(18, 2))
	 END



-- Balance_Clean
UPDATE JuneToJanuary
SET Balance_Clean =
    CAST(SUBSTRING(Balance, 1, LEN(Balance) - 2) AS DECIMAL(18, 2))



-- TransactionType
UPDATE JuneToJanuary
SET TransactionType =
    CASE 
	 WHEN Amount LIKE '%Cr%' THEN 'Credit'
	 ELSE 'Debit'
	END 


-- Category - Credit
UPDATE JuneToJanuary
SET Category = 
    CASE 
	 WHEN Description like '%ADT%' THEN 'ATM Cash Deposit'
	 WHEN Description like '%Transfer%' THEN 'Transfer From Savings'
	 ELSE 'Other' 
	 END 
WHERE TransactionType = 'Credit'




-- Category - Debit
UPDATE JuneToJanuary
SET Category = 
    CASE 
	 WHEN Description like '%Purchase%' THEN 'Purchases & Payments'
	 WHEN Description like '%Prepaid%' THEN 'Purchases & Payments'
	 WHEN Description like '%Payment%' THEN 'Purchases & Payments'
	 WHEN Description like '%Byc%' THEN 'Savings'
	 WHEN Description like '%saving%' THEN 'Savings'
	 WHEN Description like '%Fee%' THEN 'Banking Fees'
	 WHEN Description like '%ATM%' THEN 'ATM Withdrawal'
	 WHEN Description like '%Send%Money%' THEN 'E-Wallet'
	 ELSE 'Other' 
	 END 
WHERE TransactionType = 'Debit'


--Subcategory - Debit
UPDATE JuneToJanuary
SET SubCategory = 
    CASE 
	 WHEN Description like '%Checker%' THEN 'Groceries & Toiletries'
	 WHEN Description like '%PNP%' THEN 'Groceries & Toiletries'
	 WHEN Description like '%PEP%' THEN 'Groceries & Toiletries'
	 WHEN Description like '%Shoprite%' THEN 'Groceries & Toiletries'
	 WHEN Description like '%Clicks%' THEN 'Groceries & Toiletries'
	 WHEN Description like '%Riviera%' THEN 'Groceries & Toiletries'
	 WHEN Description like '%Mr%Price%' THEN 'Clothing'
	 WHEN Description like '%Clothing%' THEN 'Clothing'
	 WHEN Description like '%Mcd%' THEN 'Food & Beverage'
	 WHEN Description like '%Roman%' THEN 'Food & Beverage'
	 WHEN Description like '%Starbucks%' THEN 'Food & Beverage'
	 WHEN Description like '%Arcadia%Fish%' THEN 'Food & Beverage'
	 WHEN Description like '%Mr%D%Food%' THEN 'Food & Beverage'
	 WHEN Description like '%Takea%' THEN 'OnlineShopping'
	 WHEN Description like '%Unisa%' THEN 'Tuition Fees'
	 WHEN Description like '%Electricity%' THEN 'Electricity'
	 WHEN Description like '%Bolt%' THEN 'Ride Services'
	 WHEN Description like '%Airtime%' THEN 'Airtime'
	 WHEN Description like '%PNA%' THEN 'Electronics & Stationaries'
	 WHEN Description like '%Esselen%' THEN 'Electronics & Stationaries'
	 WHEN Description like '%Cash%Crusaders%' THEN 'Electronics & Stationaries'
	 WHEN Description like '%Vodacom%' THEN 'Electronics & Stationaries'
	 WHEN Description like '%Game%' THEN 'Electronics & Stationaries'
	 WHEN Description like '%Post%' THEN 'Electronics & Stationaries'
	 ELSE 'Other' 
	 END 
WHERE TransactionType = 'Debit'



--Replace the null cells with 'Other'
UPDATE JuneToJanuary
SET SubCategory = 
    CASE 
	 WHEN SubCategory is NULL THEN 'Other'
	 END
WHERE TransactionType = 'Credit'



 --Check the new added values to the table
Select *
From JuneToJanuary



--Create the final table - BankStatement which will contain clean data
CREATE TABLE BankStatement (
    Date DATE,
    Description NVARCHAR(255), -- I chose NVARCHAR(255) because when I tried inserting the 'Description' column from my initial table in this 'Description' with NARCHAR(50), it didn't work as it was too long so I went back to my initial column to check the NVARCHAR value and used it here too
    Amount DECIMAL(18, 2),
	Balance DECIMAL(18, 2),
    TransactionType NVARCHAR(50),
	Category NVARCHAR(255),
	SubCategory NVARCHAR(255)
)


INSERT INTO BankStatement
SELECT
    Date,
    Description,
    Amount_Clean,
	Balance_Clean,
    TransactionType,
	Category,
	SubCategory
FROM JuneToJanuary



Select *
From BankStatement





--Checking for duplicates
Select Date, Description, Amount, Balance, COUNT(*) As Count
From BankStatement
GROUP BY Date, Description, Amount, Balance
HAVING COUNT(*) > 1
ORDER BY Date 



--Contribution percentage for each category to the total Amount of credit transactions
Select Category, SUM(Amount) As Amount, SUM(Amount)/(Select SUM(Amount)From BankStatement Where TransactionType = 'Credit')*100 As Percentage 
From BankStatement
Where TransactionType = 'Credit'
GROUP BY Category
ORDER BY Percentage Desc



-- Credit Transactions : Category 'Other'
Select Date, Description, Amount
From BankStatement
Where TransactionType = 'Credit' AND Category = 'Other'


-- Total Credit Amount per month
Select FORMAT(Date, 'yyyy-MM') as Month, SUM(Amount)
From BankStatement
Where TransactionType = 'Credit'
GROUP BY FORMAT(Date, 'yyyy-MM')


-- Average Credit Amount per month
SELECT AVG(AverageAmount)
FROM (
    SELECT FORMAT(Date, 'yyyy-MM') AS Month, AVG(Amount) AS AverageAmount
    FROM BankStatement
    WHERE TransactionType = 'Credit'
    GROUP BY FORMAT(Date, 'yyyy-MM')
) AS MonthlyAverages



--Highest Cash Deposit Made
SELECT  MAX(Amount) AS HighestCashDepositMade
FROM BankStatement
WHERE TransactionType = 'Credit' AND Category = 'ATM Cash Deposit'



--Highest Cash Deposit Made with Date and Description
SELECT TOP 1 Date, Description, Amount AS HighestADTCashDeposit
FROM BankStatement
WHERE TransactionType = 'Credit' AND  Category = 'ATM Cash Deposit'
ORDER BY Amount Desc


--Lowest Cash Deposit Made with Date and Description
SELECT TOP 1 Date, Description, Amount AS HighestADTCashDeposit
FROM BankStatement
WHERE TransactionType = 'Credit' AND  Category = 'ATM Cash Deposit'
ORDER BY Amount --'Order By' by default orders in an ascending manner(from the smallest to the biggest) so it is not 



--Contribution or distribution percentage for each category to the total Amount of debit transactions
Select Category, SUM(Amount) As Amount, SUM(Amount)/(Select SUM(Amount)From BankStatement Where TransactionType = 'Debit')*100 As Percentage 
From BankStatement
Where TransactionType = 'Debit'
GROUP BY Category
ORDER BY Percentage Desc




--Overview of Category 'Other' in Debit transactions
Select Date, Description, Amount
FROM BankStatement
WHere TransactionType = 'Debit' AND Category = 'Other'



--Contribution percentage of subcategories under 'Purchases & Payements' category compared to total Amount of 'Purchases & Payements' category
Select Subcategory , SUM(Amount) As Amount, (SUM(Amount)/(Select Sum(Amount) From BankStatement Where Category = 'Purchases & Payments'))*100 As Percentage
From BankStatement
Where TransactionType = 'Debit' AND Category = 'Purchases & Payments'
GROUP BY SubCategory
ORDER BY Percentage Desc




--Overview of Subcategory other in 'Purchases % Payments' Category of the debit transactions
Select Date, Description, Amount
From BankStatement
Where Category = 'Purchases & Payments' AND SubCategory = 'Other'




-- Total 'Purchases & Payments' per months
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month, SUM(Amount) AS TotalPurchasesPayments
FROM BankStatement
WHERE Category = 'Purchases & Payments'
GROUP BY FORMAT(Date, 'yyyy-MM')



-- Average Money Spent on Airtime
SELECT AVG(Amount) AS AverageAirtimeSpent
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Airtime'



--Total spending on Airtime per month
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    SUM(Amount) AS TotalAirtimeSpent
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Airtime'
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY TotalAirtimeSpent Desc



-- Total spending on 'Groceries % Toiletries' per month
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    SUM(Amount) AS TotalGroceriesSpent
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Groceries & Toiletries'
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY TotalGroceriesSpent Desc




--Highest spending on 'Groceries and Toiletries'
SELECT TOP 1
    Date,
    Amount
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Groceries & Toiletries'
ORDER BY Amount DESC




--Average Groceries
Select Subcategory, AVG(Amount) as AvgAmount
From BankStatement
Where SubCategory = 'Groceries & Toiletries'
Group by SubCategory


--Average Amount spent on Rides per month
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    AVG(Amount) AS AverageRideServicesSpent
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Ride Services'
GROUP BY FORMAT(Date, 'yyyy-MM')

-- Highest Amount spent on Rides
SELECT MAX(Amount)
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Ride Services'

-- Lowest Amount
SELECT MIN(Amount)
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Ride Services'

--Total Amount spent on rides per month
SELECT FORMAT(Date, 'yyyy-MM') AS Month, SUM(Amount)
FROM BankStatement
WHERE Category = 'Purchases & Payments' AND SubCategory = 'Ride Services'
GROUP BY FORMAT(Date, 'yyyy-MM')



--Highest Amount Withdrawn
SELECT TOP 1
    Date,
    Amount
FROM BankStatement
WHERE TransactionType = 'Debit' AND Category = 'ATM Withdrawal'
ORDER BY Amount DESC

--Lowest Amount Withdrawn
SELECT TOP 1
    Date,
    Amount
FROM BankStatement
WHERE TransactionType = 'Debit' AND Category = 'ATM Withdrawal'
ORDER BY Amount 



--Total Banking fees per month
SELECT 
    FORMAT(Date, 'yyyy-MM') AS Month,
    SUM(Amount) AS TotalBankingFees
FROM BankStatement
WHERE Category = 'Banking Fees'
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY TotalBankingFees DESC




--Details on the month with the highest total Banking fees
SELECT Date, Description, Amount
FROM BankStatement
WHERE Category = 'Banking Fees' AND FORMAT(Date, 'yyyy-MM') = '2023-06'







--Average Banking fees per month
Select Avg(Amount)
From BankStatement
WHERE Category = 'Banking Fees'


--Details on month with lowest banking fees
SELECT Date, Description, Amount
FROM BankStatement
WHERE Category = 'Banking Fees' AND FORMAT(Date, 'yyyy-MM') = '2023-10'



















    













