
-- How many events did Jesse Owens win in 1936? 
SELECT athlete, count(medal) FROM Olympic_Athlete_Event_Results oaer 
WHERE athlete = 'Jesse Owens' AND medal = 'Gold'

-- What country has the most individual medals in fencing? 
SELECT oc.country, count(medal) 
FROM Olympic_Athlete_Event_Results oaer 
JOIN Olympics_Country oc 
ON oc.country_noc = oaer.country_noc 
WHERE sport = 'Fencing' AND medal <> 'na' AND isTeamSport = 'False'
GROUP BY country
ORDER BY count(medal) DESC

-- What country has the most gold medals in team gymnastics? 
SELECT oc.country, count(medal)
FROM Olympic_Athlete_Event_Results oaer 
JOIN Olympics_Country oc 
ON oc.country_noc = oaer.country_noc 
WHERE sport like '%Gymnastics%' AND medal = 'Gold' AND isTeamSport = 'True'
GROUP BY oc.country
ORDER BY count(medal) DESC




-- what athletes have won more than 5 gold medals in individual sport? 
SELECT athlete, count(medal)
FROM Olympic_Athlete_Event_Results oaer 
JOIN Olympics_Country oc 
ON oc.country_noc = oaer.country_noc 
WHERE  medal = 'Gold' AND isTeamSport = 'False'
GROUP BY athlete
HAVING count(medal) > 5
ORDER BY count(medal) DESC


-- what country has the heaviest wrestlers ?
SELECT oc.country, avg(weight) AS avg_weight 
FROM Olympic_Athlete_Bio oab 
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id 
JOIN Olympics_Country oc 
ON oc.country_noc = oab.country_noc 
WHERE oab.weight <> 'na' AND sport = 'Wrestling'
GROUP BY oc.country 
ORDER BY avg_weight DESC