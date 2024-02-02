-- songs that were ranked #1
SELECT song, "Year"
FROM billboard_top 
WHERE "rank"=1 AND "Year">2001
GROUP BY song, "Year"
ORDER BY "Year" DESC

--customers who bought on more than one date
SELECT user_id, count(DISTINCT created_at)  
FROM amazon_transactions
GROUP BY  user_id
HAVING count(DISTINCT created_at) > 1

-- most 'cool' votes
SELECT business_name, cool, review_text 
FROM yelp_reviews 
WHERE cool=(SELECT MAX(cool) FROM yelp_reviews)
 
-- most oscars
WITH winners AS(
SELECT nominee, COUNT(winner) as oscars
FROM oscar_nominees 
WHERE winner
GROUP BY nominee
)
SELECT nominee, oscars 
FROM winners
WHERE oscars=(SELECT MAX(oscars) FROM winners) 

--sales revenue
SELECT salesperson, sales_revenue, 
SUM(sales_revenue) OVER() as total_sales_revenue
FROM sales_performance 
ORDER BY 2 desc

-- posts with likes 
SELECT fp.post_date, count(fr.post_id)
FROM facebook_posts fp
JOIN facebook_reactions fr ON fr.post_id = fp.post_id
WHERE fr.reaction = 'like'
GROUP BY 1
ORDER BY 1

