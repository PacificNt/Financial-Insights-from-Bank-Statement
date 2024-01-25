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










  
















  
