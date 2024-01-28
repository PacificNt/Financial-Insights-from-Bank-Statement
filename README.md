# Financial-Insights-from-Bank-Statement

**1. INTRODUCTION**





This is a financial analysis project. The objective of the project is to gain valuable insights from a personal 6 months bank statement, starting from June the 15th, 2023 to January the 15th, 2024.
The project involves transaction categorization, expense tracking, and visualization of financial trends.



Tools :


**- Microsoft Excel** : Microsoft Excel was used to import the raw bank statement data(pdf), perform preliminar data cleaning and preparation using Power Query in the process.


**- SQL Server** : SQL Server is used for data exploration, further data preparation, transaction caegorization and expense tracking.

**- PowerBI** : PowerBi will be used to visualize financial trends. 

**2. DATA PROCESSING WITH SQL SERVER**

- Table Check



<img width="765" alt="Financial Insights Project - Table Check" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/df0d6878-b8a5-4f16-9b6f-de08af13262b">





**Remark** : 
1. The table shows that there is the presence of letters('Cr') in the columns 'Amount' and 'Balance'. These two columns are supposed to contain numbers only, the presense of 'Cr' will not make calculations on these columns possible.
2. We can also notice the presence of commas(',') in instead of points('.') to delimit decimals in the 'Amount' column. This will also make calculations in this column.
These two issues will be addressed later.






- Data Type Check






<img width="765" alt="Financial Insights Project - Table Check" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/33abb163-bf0a-4d52-8c1e-0cafd48c7d4f">




**Remark** : The result shows that the columns 'Amount' and 'Balance' are NVARCHAR which is a strong data type but it should be a number data type. And the 'Date' column apprears as 'datetime' but since the time part doesn't reflect any info, we can keep it just as 'date'. These will be fixed later.







**DATA CLEANING**

1. Replacing commas


<img width="765" alt="Financial Insights Project - Commas replacement" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/e53c046d-09d1-4074-9003-95c02c0bc0eb">






2. Clean the 'Description' column.



<img width="767" alt="Financial Insights Project - Clean Description Column" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/20da6969-fcd0-4b6e-90a6-4c7d0b0caf6d">





3. Convert 'Date' column from datetime to date





<img width="765" alt="Financial Insights Project - Convert data" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/aa8d9fe6-c06f-4f63-a981-37359a7ae37b">






4. Add new columns for data cleaning and categorization






<img width="767" alt="Financial Insights Project - Adding new columns" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/e16bd4fe-b065-4fe1-b3f8-45f7d302730b">





**Remark** : - Columns 'Amount_Clean' and 'Balance_Clean' are created to contain the clean 'Amount' and 'Balance' meaning without the 'Cr'
             - Columns 'TransactionType', 'Category' and 'SubCategory' are added for transaction categorization.




5. Add values to the new columns


- 'Amount_Clean'





<img width="767" alt="Financial Insights Project - Set values form 'Amount_Clean'" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/78578082-565d-4e83-97a4-8f3921f95473">





- 'Balance_Clean'




<img width="767" alt="Financial Insights Project - Set values for 'Balance_Clean'" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/d9a449e9-578f-4d56-a28e-9364bb305f5c">





- 'TransactionType'





<img width="766" alt="Financial Insights Project - Set values for 'TransactionType'" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/51fa8d41-8574-436e-be62-2c58c2122e90">







- 'Category' and 'SubCategory'






<img width="765" alt="Financial Insights Project - category - Credit" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/677ec4c6-1f09-417e-bd33-d5c69779c3fe">





<img width="766" alt="Financial Insights Project - Category - Debit" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/3101133a-039c-4c22-9355-f0678142d2ea">






<img width="765" alt="Financial Insights Project - SubCategory Debit" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/fdc1ec1b-f994-49b0-8785-e8d9e8c50ba4">






<img width="767" alt="Financial Insights Project - Replace null cells" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/68bd9035-0ab3-4758-8248-14efcd4a57e6">









- Check the new values added to the table









<img width="766" alt="Financial Insights Project - Values Check 1" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/170697a1-2ed7-44e5-a5d8-10f8ad54c59b">

<img width="767" alt="Financial Insights Project - Values Check 2" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/224da514-4e14-4d7e-93dc-6df64a6361b0">



6. Create a new Table(BankStatement) that will contain only the needed columns






- Creating the new table






<img width="766" alt="Financial Insights Project - Bank Statement" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/3a3924e9-038b-4b1f-b79e-313602fc1e20">





- Inserting values in the new table






<img width="766" alt="Financial Insights Project - Bank statement values" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/6981b49e-8c26-4bda-a228-faf923340b59">










- Verifying the new table





<img width="766" alt="Financial Insights Project - Bank Statement Check" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/0d6c800c-4ffb-4af1-ba6a-7f71adcb18c6">












7. Checking for duplicates






<img width="766" alt="Financial Insights Project - Duplicates Check" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/4e25d3f0-afd3-49ff-ad72-25631fb35707">









From the result, we can see that there is no duplicates in the 'BankStatement' table









**EXPENSE AND INCOME TRACKING - DATA EXPLORATION**




**Note** : These are just some of the queries used in the project, to see all the project please check the '*Financial Insights*' file.





- 1. Contribution Percentage for Credit Categories.






<img width="766" alt="Financial Insights Project - Contribution Percentage -Credit" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/d4aab0c4-5417-4f4d-9dc3-31b4663927e3">






**Insights** : The credit transactions represent the incoming money in the Bank account and their source. In our case, the sources were identified as ATM Cash Deposit, Transfer from Savings(Savings Account) and other. The results shows that +/- 83%(or R30100) of incoming money in the account from June 2023(the 15th) to January 2024(the 15th) came from ATM Cash Deposit, while only 5%(R1884) came from the savings account. The remaining contribution(~11% or R4148.44) is classified as other.  But since it represent a good 11% of the total contribution, it is also important to have a closer look at it and find out, what it represents.





- 'Other'.





<img width="766" alt="Financial Insights Project - Credit Transactions - Other" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/3325963c-c064-4928-ba43-80326be00629">







Looking at what 'Other' in the credit transactions represent, we can see that this category contains transactions such as payment/transfer received from other Bank accounts as well as an Inward Swift which represent a money transfer from a foreign bank account.






- 2. Highest Cash Deposit made.






<img width="766" alt="Financial Insights Project - Highest Deposit" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/0737efe6-ab57-4064-8df2-5b81a24dafc4">






**Insights** : The result shows that the highest Cash deposited on the account is R7100 and it was deposited on the 20th of November 2023 and as per the description it is referred to as 'Laptop Money'






- 3. Contribution Percentage for debit categories.







<img width="766" alt="Financial Insights Project - Contribution Percentage - Debit" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/847728a6-b97e-4885-b2c8-2efb395d676b">







**Insights** : The result shows that around 81%(or R28294.16) of the money that went out of the account in the period covered in this table(15 June 2023 to 15 January 2024) went to 'Purchases & Payments', 7%(or R2530.83) went into savings, around 6%(or R1940.00) went to E-Wallets, around 3%(or R1250.00) went to ATM Withdrawals and around 2%(R828.00) went to Banking fees. The remaining contribution(0.2%0=) is classified as 'Other'.






- 4. Contribution percentage of Subcategories in 'Purchases & Payements'.






<img width="767" alt="Financial Insights Project - Contribution percentage of Subcategories under 'Purchases   Payments'" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/edd97eec-162c-44c8-a1e6-e2eaaa24a50f">











**Insights** : As seen in the previous case, the 'Purchases & Payments' Category accounts around 81% of all debit transactions so it is important to have a closer look at what data in contained in this category.
The result shows that the biggest contribustion(around 32% of total) in this category is classified as 'Other'(We will have a closer look at it after). The second biggest contribution is 'Tuition Fees' which accounts around 31% of total contribution or R8860. The result shows that around R2062(or around 7%) was spent on 'Airtime' which is quite close to the amount spent on 'Groceries & Toiletries'(R2384.92 or around 8%). We can aslo hihlights 'Ride Services' wich accounts around 1% of total 'Purchase & Payments'. It is important to note here the the amount on 'Ride Services' doest not really reflect the reality as this reflects only rides that we paid with the Bank card; the rides paid in cash are not reflected here.






- Overview of SubCategory 'Other' under Category 'Purchases & Payments'






<img width="766" alt="Financial Insights Project - Overview of 'Other' in 'Purchases   Payments' category" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/96124d02-2992-452d-a0ca-07ebe5a5cc3a">








The result shows that under the 'Other' SubCategory are mainly miscellaneous payments that didn't fit the main conditions set 'SubCategories', Ticket purchases and other purchases made at some unidentified shops(Point Of Sales).









- 5.  Monthly spending on 'Purchases & Payments'.







<img width="766" alt="Financial Insights Project - Total Purchases Per Month" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/435b14c0-ad34-40ad-ae6d-18b9491a3af8">











**Insights** : From the results we can see that the month of October was the month with the highest spending on 'Purchases & Payments' with R1276.30






- 6. Monthly spending on 'Airtime'.
 


  






<img width="767" alt="Financial Insights Project - Total Spending on Airtime per month" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/2866618d-5514-4db8-b00c-d390161c6683">










**Insights** : The shows that the month of November was the month with the highest spending on 'Airtime.







- 7. Monthly Spending on 'Groceries & Toiletries'.






<img width="767" alt="Financial Insights Project - Total Spending on Groceries per month" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/c19c9186-536e-484e-88a0-cd303b4b7cf9">










**Insights** : The result shows the month of September was the month with the highest spendind on 'Groceries & Toiletries' with R728.45 while the month of July had the lowest amount spent on 'Groceries & Toiletries' with just R95.06









- 8. Highest and lowest amount withdrawn.










<img width="764" alt="Financial Insights Project - Max and Min Withdraw" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/1adc127a-20ed-475e-a2f6-1d9e664617ca">










- 9. Total Banking fees per month.







<img width="766" alt="Financial Insights Project - Total Banking Fees per month" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/a8ecb2ad-6b90-4823-9fed-3e8cafd3df41">









**Insights** : The result shows that June was the month with the highest 'Banking Fees'(R150). So let's have a closer look and see what were those fees about.








- Details on Banking fees of the month of June.






<img width="766" alt="Financial Insights Project - Highest banking fee month details" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/d1e9da6e-f95c-4285-946c-69ce6b71d224">





From the results we can see that the fees were all on about the foreign exchange commission.





- 10. Highest and Lowest Balance.







  <img width="764" alt="Financial Insights Project - Highest Balance" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/d50b03d9-0d55-424e-afc8-2576a3f15a58">









<img width="767" alt="Financial Insights Project - Lowest Balance" src="https://github.com/PacificNt/Financial-Insights-from-Bank-Statement/assets/112112663/79756903-de53-4cf8-ad17-28eb16b60e7d">








**Insights** :

- The highest 'Balance' registered in the account was R14226.44 and that was registered on the 12th of December 2023.

- The lowest 'Balance' was R0.45 and it was registered on the 27th of December 2023.
  













**Note** : These are just some of the queries used in the project, to see all the project please check the '*Financial Insights*' file.


































  
















  
