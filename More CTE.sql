
-- What is the average number of products for all categories?
  
  
   
--------Split the question:
--1Total (count) number of products per category
--2Average of answer to (a)

 -----What’s the number of products for all categories?
--Output: 2 columns
---Aggregate?  Yes, count (product_id)
--Join?  Yes.  2 Tables, categories and products.  Left or Inner? 

   --What’s the average number of products/category
--Input: Table from CTE
--Output: 1 number 
---Aggregate? Yes, avg()
--Join? No

   -- let's try it with a subquery
   
SELECT avg(count) FROM 
(SELECT c.category_name, COUNT(DISTINCT p.product_id) FROM categories c 
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name) AS pc
    
-- Same thing but using a CTE instead of the subquery 

WITH pc AS 
(
SELECT c.category_name, COUNT(p.product_id) AS prod_count
FROM categories c 
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY prod_count DESC
) 
SELECT avg(prod_count) FROM pc
    
   
-- COUNT DISTINCT gives us unique values 
 SELECT count(title) FROM employees  --9
   
   
 SELECT count(DISTINCT title) FROM employees --4

   
   
   
   
   
   