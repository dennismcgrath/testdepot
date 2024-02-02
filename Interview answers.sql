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
WHERE winner='TRUE'
GROUP BY nominee
)
SELECT nominee, oscars 
FROM winners
WHERE oscars=(SELECT MAX(oscars) FROM winners) 

--sales revenue
SELECT salesperson, sales_revenue, 
SUM(sales_revenue) OVER() as total_sales_revenue
FROM sales_performance 


-- posts with likes (thanks to Anoush)
WITH liked_posts AS
	(
	SELECT fp.post_id, post_date, count(reaction) AS likes
	FROM facebook_posts fp
	INNER JOIN facebook_reactions fr ON fr.post_id = fp.post_id
	WHERE reaction = 'like'
	GROUP BY fp.post_id, fp.post_date
	ORDER BY post_date ASC
	)
SELECT count(post_id) AS num_posts, post_date, sum(likes)
FROM liked_posts
GROUP BY post_date