-- Aggregate Window Functions
	-- 1.	Running Total of Sales
	-- •	Calculate a day-by-day running total of sales amounts, ordered by sale date.
    select sale_id,
		customer_id,
		amount,
		Sum(amount) OVER (PARTITION BY AMOUNT ORDER BY sale_date ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) as Running_total
    FROM sales;
    
	-- 2.	Running Total by Customer
	-- •	Compute a running total of sales amounts for each customer separately (i.e., reset the total when the customer changes).
    select sale_id, 
	sale_date,
    customer_id,
    amount,
    SUM(amount) OVER ( PARTITION BY customer_id  ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ) AS CUST_Running_Total
    FROM SALES;
    
	-- 3.	Moving Average of Sales
	-- •	Determine a 3-day moving average of daily sales amounts.
    
    select sale_id,
    sale_date,
    customer_id,
    amount,
    AVG(amount) over (PARTITION BY sale_id ROWS BETWEEN CURRENT ROW and 3 FOLLOWING) AS Moving_Avg
    from SALES;
    
-- 4.Partitioned Average Score
-- Using the Students table, show each student’s score alongside the average score for their exam date (i.e., partition by exam_date)

select 
	student_id, 
    name, 
    score, 
    exam_date,
    avg(score) over (Partition By exam_date order by exam_date ROWS BETWEEN current row AND UNBOUNDED FOLLOWING) AS AVGSCORE
    from STUDENTS;

-- Ranking Window Functions
-- 	5.	Ranking Sales by Amount
-- 	•	Assign a rank to each sale based on the sale amount in descending order.
--  •	Compare the results using both RANK() and DENSE_RANK().


-- 	6.	Top Students Per Exam
-- •	Rank students within each exam date (partition by exam_date) based on their scores from highest to lowest.

SELECT 
	STUDENT_ID,
    NAME,
    SCORE,
    exam_date,
    RANK() OVER (PARTITION BY exam_date ORDER BY score) As Student_rank
    from Students ;
-- Display the top-ranked student for each date.
select Name, Score, exam_date,
	   Rank() OVER (PARTITION BY exam_date order by score) AS Student_rank 
FROM Students;

-- 7.	Sales Distribution
-- •	Divide all sales into 4 groups (quartiles) based on the sale amount using NTILE(4).

select sale_id, sale_date, customer_id, amount,
NTILE(4) OVER (ORDER BY amount)
from Sales;

-- 8 Percentile Ranking of Students
-- For all student scores, compute the percentile rank (PERCENT_RANK()) to see how each student’s score compares to others.

select student_id, name, score , exam_date,
ROUND(PERCENT_RANK() OVER (order by score),2) as ABC
from Students;

-- Value Window Functions
-- Comparing Current and Next Sales
-- For each sale (ordered by date), display the current sale amount and the amount of the next sale (LEAD).
SELECT * FROM vendor_scorecard.Sales;

select sale_id, sale_date, customer_id, amount,
LEAD(amount) OVER (ORDER BY sale_date) as Cumm_sale
from Sales;


-- Comparing Current and Previous Scores
-- For each student (ordered by exam_date), display the current score and the score of the previous student (LAG).

select student_id, name, score,
LAG(score) OVER (ORDER BY exam_date) as ABC
from Students;
    
-- 11.	First and Last Sales by Customer
-- Show the first and last sale amount for each customer. Use FIRST_VALUE and LAST_VALUE within a window partitioned by customer_id.

select customer_id, sale_id, sale_date, amount,
FIRST_VALUE(amount) OVER (PARTITION BY Customer_id ORDER BY amount) as Frst,
LAST_VALUE(amount) OVER ( Partition BY Customer_id ORDER BY amount) as last
from Sales;

-- 12.	Earliest and Latest Exam Scores per Date
--  For each exam_date, display the first and last score recorded using FIRST_VALUE and LAST_VALUE. Partition by 
--  exam_date and order by student_id or score as you see fit.

select student_id, name, score , exam_date,
FIRST_VALUE(score) OVER (PARTITION BY exam_date order by score) as firs,
LAST_VALUE(score) OVER ( PARTITION BY exam_date order by score) as lst
from Students;
