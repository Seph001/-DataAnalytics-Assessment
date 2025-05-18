/* Task 2: Calculate the average number of transactions per customer per month and categorize them

High Frequency (≥10 transactions/month)
Medium Frequency (3-9 transactions/month)
Low Frequency" (≤2 transactions/month) 

Solution using Common Table Expression (CTE) */
/* First CTE about transaction summary. It helps to breakdown and simplify
bulky SQL statement to smaller queries */

WITH transaction_summary AS (
SELECT 
	s.owner_id,
COUNT(*) AS total_transactions,
TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1 AS active_months
FROM savings_savingsaccount as s
WHERE s.transaction_date IS NOT NULL
AND s.confirmed_amount > 0
GROUP BY s.owner_id
),	

/* Second CTE about user frequency. Calculates the average number of transactions per month for each user
and categories users into High Frequency, Medium Frequency and Low Frequency */

user_freq_class AS (
SELECT 
	owner_id,
	total_transactions,
	active_months,
	ROUND(total_transactions / active_months, 2) AS avg_transaction_per_month,
CASE 
	WHEN (total_transactions / active_months) >= 10 THEN 'High Frequency'
	WHEN (total_transactions / active_months) BETWEEN 3 AND 9 THEN 'Medium Frequency'
	ELSE 'Low Frequency'
END AS frequency_category
FROM transaction_summary
)

/* Counts how many customers fall into each frequency category
Calculates the average of their monthly transactions
Uses FIELD(frequency category) to maintain sort order in the output */

SELECT 
    frequency_category,
COUNT(*) AS customer_count,
ROUND(AVG(avg_transaction_per_month), 2) AS avg_transactions_per_month
FROM user_freq_class
GROUP BY frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
