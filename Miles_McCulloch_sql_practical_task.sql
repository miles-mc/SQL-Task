-- 1. How many entries in the database are from Africa?
SELECT COUNT(*) AS africa_entry_count													--count the number of records and alias as africa_entry_count
FROM countries c																		--uses countries table and aliases countries as c
JOIN population_years p																	--left joins population_years table as p
	ON p.country_id = c.id																--sets join condition to match records by ID
WHERE continent = 'Africa';																--filters to records that match 'Africa' in continent 

--ANSWER = 616
--INSIGHT = There are 616 entries under the continent 'Africa'





-- 2. What was the total population of Africa in 2010?
SELECT SUM(p.population) AS total_population											--calculate the sum of population and alias as total_population
FROM countries c																		--uses countries table aliased as c
JOIN population_years p																	--left joins population_years table as p
	ON p.country_id = c.id																--sets join condition to match records by ID
WHERE continent = 'Africa' AND year = '2010';											--filters to records that match 'Africa' in continent and '2010' in year

--ANSWER = 89890209
--INSIGHT = The total population of Africa in 2010 is 89890209





-- 3. What is the average population of countries in South America in 2000?
SELECT AVG(p.population) AS average_population											--calculates the average population of all countries in south america and alias as average_population
FROM countries c																		--uses countries table aliased as c
JOIN population_years p																	--left joins population_years table as p
	ON p.country_id = c.id																--sets join condition to match records by ID
WHERE continent = 'South America' AND year = '2000';									--filters to records that match 'South America' in continent and '2000' in year

--ANSWER = 2264682
--INSIGHT = This question was quite ambiguous, I was unsure if you wanted the average of all countries or the average of each so I have also provided a query for the average of each country grouped by name below.


SELECT name, AVG(p.population) AS average_population							    	--as above but also adds the name column in order to group later
FROM countries c
JOIN population_years p 
	ON p.country_id = c.id 
WHERE continent = 'South America' AND year = '2000'
GROUP BY name																			--shows the average population in the year 2000 for each country
ORDER BY average_population DESC;														--orders by average population for readability







-- 4. What country had the smallest population in 2007?
SELECT TOP 1 c.name AS country_name, SUM(p.population) AS total_population_07         	--calculates the sum of population and aliases and total_population_07
FROM countries c																		--uses countries table aliased as c
JOIN population_years p																	--left joins population_years table as p
	 ON p.country_id = c.id																--sets join condition to match records by ID
WHERE p.year = '2007'																	--filters to records that match '2007' in year
GROUP BY c.name																			--groups result set by country name
ORDER BY total_population_07 ASC;														--orders result set by total population as calculated earlier, sorts by smallest first

--ANSWER = Saint Pierre and Miquelon with 61 but
--INSIGHT = The population seems extremely small. This would suggest either incorrect data, poor record keeping 
--			or the inability to conduct a proper census.







-- 5. How much has the population of Europe grown from 2000 to 2010?
SELECT (																									
	(SELECT SUM(p.population) 															--subquery 1, calculates the total population for the year 2010
	FROM countries c																	--uses countries table as c
	JOIN population_years p																--joins population_years table as p
	ON p.country_id = c.id																--sets join condition to match records by ID
	WHERE continent = 'Europe' AND year = 2010)											--filter to records that match 'Europe' in continent and '2010' in year
	-																					--subtracts results of subquery 2 from subquery 1
	(SELECT SUM(p.population)															--subquery 2, calcualates the total population for the year 2000
	FROM countries c																	--uses countries table as c
	JOIN population_years p																--joins population_years table as p
	ON p.country_id = c.id																--sets join condition to match records by ID
	WHERE continent = 'Europe' AND year = 2000))										--filter to records that match 'Europe' in continent and '2000' in year
	AS euro_population_change;															--aliases result as euro_population_change


	--ANSWER = 2674325
	--INSIGHT = The population has grown by 2674325 people




