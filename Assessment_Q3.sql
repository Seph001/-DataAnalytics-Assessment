/* Task 3:
Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) */

SELECT 
    p.id AS plan_id,
    p.owner_id,
CASE
	WHEN p.is_regular_savings = 1 THEN 'Savings'
	WHEN p.is_a_fund = 1 THEN 'Investment'
	ELSE 'Other'
END AS category_type,		/* Categorizes the plan type as Savings, Investment, or Other using CASE clause */
MAX(s.transaction_date) AS last_transaction_date,
DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days		/* Uses most recent transaction date to calculate how many days have passed since the last transaction */
FROM
    plans_plan AS p
LEFT JOIN savings_savingsaccount AS s ON s.plan_id = p.id		/* Retrieves plans and joins them with the savings account */
WHERE (p.is_regular_savings = 1 OR p.is_a_fund = 1)		/* includes savings or investment plans */
GROUP BY p.id , p.owner_id , category_type
HAVING last_transaction_date IS NOT NULL
AND inactivity_days > 365		/* only plans with a recorded transaction date and over 1 year of inactive */
ORDER BY inactivity_days DESC;
