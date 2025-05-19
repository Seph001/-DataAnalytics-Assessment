# -DataAnalytics-Assessment

Task 1:
project focuses on analyzing customer savings and investment behacios using funded saving plan and funded investment plan. It displays their total deposit amount sorted by deposit value. Each subquery is matched by user id from the outer query. 
while i was writing the query i encountered some challenges with firstly the subquery. I had tried to write my subqueries in the FROM clause assuming it was going to be much easier instead of SELECT clause but it appeared i got my syntax messed up and didnt have the luxury of time to start sorting where i must have being defaulting. i carefully applied my query in the SELECT clause which is my favourite way of wriring subqueries and arrived at the solution.

Task 2:
The goal is to analyze customer transaction activity and categorize them based on how frequent they transact every month. I used CTE transaction summary to calculate transaction for each customer by owner_id, count transation with date and calculate difference between the first and last transaction by month plus one to avoid division by zero.

challenges:
Being able to breakdown the problems into CTEs helped me in simplying complex calculation and improved my query readability.
some customers have irregular patterns example transactions only in single month, to avoid dividing by 0 i added 1 to the months calculation so if transactions are all in thesame month, active months = 1 not 0 but for transaction spread over multiple months, it counts the months inclusively.

Task 3:
The goal is to identify savings and investment plans that have no transation for over 365 days. i joined the plans with their transactions and labeled each plan as savings or investment,found the transaction date for each plan, calculated how many days since that last transaction, kept only those inactive for over a year and sorted them from most to least inactive.

Challenges:
I had inaccuracy aggregating last transaction date per plan until i added grouping by plan id and owner id.
I needed to use Datediff between the current date and latest transaction to correctly compute days of inactivity.

Task 4: 
The objective is to calculate customer lifetime value CLV for every user using their transaction behaviour and account tenure and sort users by their CLV in descending order. it joins user and transaction data, computes how long the user has been active in months, calculates total transaction and average profit, estimates CLV using formula and group result by user and sorts them from highest to lowest CLV.

Challenges faced:
I always had to take into account that values were in kobo and had to divide by 100 during CLV calculation.
Without NULLIF, if the denominator is 0, MySQL would throw a 'division by zero' error and stop the query execution. using NULLIF ensures the query runs safely by returning NULL for such cases instead of crashing.
