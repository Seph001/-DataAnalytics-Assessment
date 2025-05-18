/* Task 4: 
 Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits. */
 
SELECT 
    u.id AS customer_id,
CONCAT(u.first_name, ' ', u.last_name) AS name,
TIMESTAMPDIFF(MONTH, u.date_joined,  u.last_login) AS tenure_months,		/* Calculates how long the customer has been active in month from joined date to last login */
COUNT(s.id) AS total_transactions,
ROUND(
	(COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, last_login), 0)) 
        * 12 
        * 0.001 
        * (SUM(s.confirmed_amount) / NULLIF(COUNT(s.id), 0)) / 100, 2) AS estimated_clv		/*  calculates Customer lifetime value */
FROM users_customuser u
JOIN savings_savingsaccount s ON s.owner_id = u.id		/* joins users with their savings transactions using owner ID */
GROUP BY u.id, name
ORDER BY estimated_clv DESC;
