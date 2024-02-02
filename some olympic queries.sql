
SELECT * FROM Olympic_Athlete_Bio oab 
WHERE name LIKE '%Louganis%'

-- what events did Greg Louganis compete in
SELECT * FROM Olympic_Athlete_Event_Results oaer 
WHERE athlete_id = 51468 AND edition_id = 22

-- all diving events in 1988
SELECT sport, event, count(medal)
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport = 'Diving' AND medal <> 'na'AND edition_id = 22
GROUP BY sport, event

-- what is the average height of athletes by country in 1920
SELECT oc.country, avg(height) AS avg_height 
FROM Olympic_Athlete_Bio oab 
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id 
JOIN Olympics_Country oc 
ON oc.country_noc = oab.country_noc 
WHERE oab.height <> 'na' AND oaer.edition = '1920 Summer Olympics'
GROUP BY oc.country 
ORDER BY avg_height DESC


-- How many events did Jesse Owens win in 1936? 

-- What country has the most individual medals in fencing? 

-- What country has the most gold medals in team gymnastics? 

-- what athletes have won more than 5 gold medals in individual sport? 

-- what country has the heaviest wrestlers ?
