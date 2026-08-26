

   CREDIT CARD CUSTOMER ANALYTICS
   SQL ANALYSIS


   --1. DATA UNDERSTANDING


-- Q1. How many customers are there?

SELECT
    COUNT(*) AS Total_Customers
FROM customer;


-- Q2. Are there any duplicate customers?

SELECT
    Client_Num,
    COUNT(*) AS Customer_Count
FROM customer
GROUP BY Client_Num
HAVING COUNT(*) > 1;


/* =========================================================
   2. CUSTOMER ANALYSIS
   ========================================================= */

-- Q3. Which education group has the most customers?

SELECT
    Education_Level,
    COUNT(*) AS Customer_Count
FROM customer
GROUP BY Education_Level
ORDER BY Customer_Count DESC;


-- Q4. What is the average income by customer job?

SELECT
    Customer_Job,
    AVG(Income) AS Average_Income
FROM customer
GROUP BY Customer_Job
ORDER BY Average_Income DESC;


-- Q5. What is the maximum income by customer job?

SELECT
    Customer_Job,
    MAX(Income) AS Maximum_Income
FROM customer
GROUP BY Customer_Job
ORDER BY Maximum_Income DESC;


-- Q6. What is the total income by customer job?

SELECT
    Customer_Job,
    SUM(Income) AS Total_Income
FROM customer
GROUP BY Customer_Job
ORDER BY Total_Income DESC;


-- Q7. How many married customers are there?

SELECT
    COUNT(*) AS Married_Customers
FROM customer
WHERE Marital_Status = 'Married';


-- Q8. How many customers are in each age group?

SELECT
    CASE
        WHEN Customer_Age < 30 THEN 'Under 30'
        WHEN Customer_Age < 40 THEN '30-39'
        WHEN Customer_Age < 50 THEN '40-49'
        WHEN Customer_Age < 60 THEN '50-59'
        ELSE '60+'
    END AS Age_Group,

    COUNT(*) AS Customer_Count

FROM customer

GROUP BY
    CASE
        WHEN Customer_Age < 30 THEN 'Under 30'
        WHEN Customer_Age < 40 THEN '30-39'
        WHEN Customer_Age < 50 THEN '40-49'
        WHEN Customer_Age < 60 THEN '50-59'
        ELSE '60+'
    END

ORDER BY Customer_Count DESC;


/* =========================================================
   3. CUSTOMER + CREDIT CARD ANALYSIS
   ========================================================= */

-- Q9. Combine customer and credit-card information.

SELECT
    c.Client_Num,
    c.Customer_Age,
    c.Gender,
    c.Income,
    c.Customer_Job,

    cc.Card_Category,
    cc.Credit_Limit,
    cc.Total_Trans_Amt,
    cc.Total_Trans_Vol,
    cc.Interest_Earned

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num;


/* =========================================================
   4. CREDIT CARD ANALYSIS
   ========================================================= */

-- Q10. Which card category generates the highest
-- transaction amount?

SELECT
    Card_Category,
    SUM(Total_Trans_Amt) AS Total_Transaction_Amount
FROM credit_card
GROUP BY Card_Category
ORDER BY Total_Transaction_Amount DESC;


-- Q11. Which card category has the highest
-- average transaction volume?

SELECT
    Card_Category,
    AVG(Total_Trans_Vol) AS Average_Transaction_Volume
FROM credit_card
GROUP BY Card_Category
ORDER BY Average_Transaction_Volume DESC;


-- Q12. Which card category generates the most
-- interest earned?

SELECT
    Card_Category,
    SUM(Interest_Earned) AS Total_Interest_Earned
FROM credit_card
GROUP BY Card_Category
ORDER BY Total_Interest_Earned DESC;


/* =========================================================
   5. CUSTOMER VALUE ANALYSIS
   ========================================================= */

-- Q13. Who are the high-spending customers?
-- Customers spending above the overall average.

SELECT
    Client_Num,
    Total_Trans_Amt
FROM credit_card
WHERE Total_Trans_Amt >
(
    SELECT AVG(Total_Trans_Amt)
    FROM credit_card
)
ORDER BY Total_Trans_Amt DESC;


-- Q14. Who are the high-income and high-spending customers?

SELECT
    c.Client_Num,
    c.Income,
    c.Customer_Job,
    cc.Total_Trans_Amt,
    cc.Card_Category

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num

WHERE c.Income >
(
    SELECT AVG(Income)
    FROM customer
)

AND cc.Total_Trans_Amt >
(
    SELECT AVG(Total_Trans_Amt)
    FROM credit_card
)

ORDER BY cc.Total_Trans_Amt DESC;


-- Q15. Which customer jobs generate the highest
-- average customer value?
--
-- Customer Value = Annual Fees + Interest Earned

SELECT
    c.Customer_Job,

    AVG(
        cc.Annual_Fees + cc.Interest_Earned
    ) AS Average_Customer_Value

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num

GROUP BY c.Customer_Job

ORDER BY Average_Customer_Value DESC;


-- Q16. Which customer jobs generate the highest
-- average net value?
--
-- Net Value = Annual Fees + Interest Earned
--             - Customer Acquisition Cost

SELECT
    c.Customer_Job,

    AVG(
        cc.Annual_Fees
        + cc.Interest_Earned
        - cc.Customer_Acq_Cost
    ) AS Average_Net_Value

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num

GROUP BY c.Customer_Job

ORDER BY Average_Net_Value DESC;


/* =========================================================
   6. RISK ANALYSIS
   ========================================================= */

-- Q17. What is the overall delinquency rate?

SELECT
    100.0
    * SUM(CAST(Delinquent_Acc AS INT))
    / COUNT(*) AS Delinquency_Rate

FROM credit_card;


-- Q18. Which card category has the highest
-- delinquency rate?

SELECT
    Card_Category,

    COUNT(*) AS Customers,

    SUM(CAST(Delinquent_Acc AS INT))
        AS Delinquent_Customers,

    100.0
    * SUM(CAST(Delinquent_Acc AS INT))
    / COUNT(*) AS Delinquency_Rate

FROM credit_card

GROUP BY Card_Category

ORDER BY Delinquency_Rate DESC;


-- Q19. Which customer jobs have the most
-- delinquent customers?

SELECT
    c.Customer_Job,

    COUNT(*) AS Customers,

    SUM(CAST(cc.Delinquent_Acc AS INT))
        AS Delinquent_Customers

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num

GROUP BY c.Customer_Job

ORDER BY Delinquent_Customers DESC;


-- Q20. Which customers have both high credit
-- utilization and delinquency?

SELECT
    c.Client_Num,
    c.Customer_Age,
    c.Income,
    c.Customer_Job,

    cc.Credit_Limit,
    cc.Avg_Utilization_Ratio,
    cc.Delinquent_Acc

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num

WHERE cc.Avg_Utilization_Ratio > 0.70

AND CAST(cc.Delinquent_Acc AS INT) = 1

ORDER BY cc.Avg_Utilization_Ratio DESC;


/* =========================================================
   7. ACQUISITION & PROFITABILITY
   ========================================================= */

-- Q21. Which card category has the lowest
-- average customer acquisition cost?

SELECT
    Card_Category,

    AVG(Customer_Acq_Cost)
        AS Average_Acquisition_Cost

FROM credit_card

GROUP BY Card_Category

ORDER BY Average_Acquisition_Cost ASC;


/* =========================================================
   8. TIME ANALYSIS
   ========================================================= */

-- Q22. Which quarter has the highest
-- transaction amount?

SELECT
    Qtr,

    SUM(Total_Trans_Amt)
        AS Total_Transaction_Amount

FROM credit_card

GROUP BY Qtr

ORDER BY Total_Transaction_Amount DESC;


-- Q23. What is the weekly transaction trend?

SELECT
    Week_Start_Date,

    SUM(Total_Trans_Amt)
        AS Weekly_Transaction_Amount

FROM credit_card

GROUP BY Week_Start_Date

ORDER BY Week_Start_Date;


/* =========================================================
   9. ADVANCED SQL - WINDOW FUNCTIONS
   ========================================================= */

-- Q24. Rank customer jobs by total transaction amount.

SELECT
    c.Customer_Job,

    SUM(cc.Total_Trans_Amt)
        AS Total_Transaction_Amount,

    RANK() OVER
    (
        ORDER BY SUM(cc.Total_Trans_Amt) DESC
    ) AS Job_Rank

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num

GROUP BY c.Customer_Job;


-- Q25. Compare each customer's transaction amount
-- with the average transaction amount of their job.

SELECT
    c.Client_Num,
    c.Customer_Job,
    cc.Total_Trans_Amt,

    AVG(cc.Total_Trans_Amt) OVER
    (
        PARTITION BY c.Customer_Job
    ) AS Job_Average_Transaction

FROM customer AS c

JOIN credit_card AS cc
    ON c.Client_Num = cc.Client_Num;


-- Q26. Find customers whose transaction amount
-- is above their job's average.

WITH Customer_Performance AS
(
    SELECT
        c.Client_Num,
        c.Customer_Job,
        cc.Total_Trans_Amt,

        AVG(cc.Total_Trans_Amt) OVER
        (
            PARTITION BY c.Customer_Job
        ) AS Job_Average_Transaction

    FROM customer AS c

    JOIN credit_card AS cc
        ON c.Client_Num = cc.Client_Num
)

SELECT
    Client_Num,
    Customer_Job,
    Total_Trans_Amt,
    Job_Average_Transaction

FROM Customer_Performance

WHERE Total_Trans_Amt > Job_Average_Transaction

ORDER BY Total_Trans_Amt DESC;
