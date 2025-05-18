/* Task 1: 

Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
solution using subquery */

SELECT 
    u.id,	
    CONCAT(u.first_name, ' ', u.last_name) AS name,  /* CONCAT combines both first_name and last_name */
(SELECT 
	COUNT(*)
FROM
	plans_plan AS p1
WHERE
	p1.owner_id = u.id
AND p1.is_regular_savings = 1) AS savings_count, /* A subquery that counts the number of savings plans */
(SELECT 
	COUNT(*)
FROM
	plans_plan AS p2	
WHERE
	p2.owner_id = u.id AND p2.is_a_fund = 1) AS investment_count,	/* Another subquery that counts how many investment plans */
(SELECT 
	ROUND(SUM(s1.amount) / 100, 2)
FROM
	savings_savingsaccount AS s1
WHERE
	s1.owner_id = u.id) AS total_deposit	/* third subquery that calculates the total confirmed deposit amount from the savings_savingsaccount table */
FROM
    users_customuser AS u;	/* u is an alias for users_cutomuser */
