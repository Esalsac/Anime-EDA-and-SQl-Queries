-- Which anime has the highest score?
-- Identify the top‑rated title and its associated rating.
SELECT
	Score,
	Japanese,
	English
FROM Top_Anime_data
ORDER BY Score DESC
Limit 1;

--What are the top 10 most popular anime by number of members?
--Useful for ranking community favourites.

SELECT
	Japanese,
	English,
	Members
FROM Top_Anime_data
ORDER BY Members DESC
Limit 10;

--Which studio has produced the highest number of anime?
--Aggregate by studio and count.

WITH exploded AS (
    SELECT
        TRIM(value) AS specific_studio										-- TRIM() is just sql for strip()  -- value because it is default output of json_each
    FROM Top_Anime_data,
         json_each('["' || REPLACE(studios, ',', '","') || '"]')			-- Replace - replaces every comma in the original string with ",". -- SQLite uses || to concatenate strings. So  [" and "] at th beginning and the end of the string. -- json_each take the newly json formatted string and makes each entry a new row
)
SELECT specific_studio, COUNT(*) AS frequency
FROM exploded
GROUP BY specific_studio
ORDER BY frequency DESC
LIMIT 1;

	
--What is the average score for each anime type (TV, Movie, OVA, etc.) and their repsective count?
--Group by type, calculate averages.

SELECT
	type,
	avg(score) as avg_score,
	count(type) as count_score
FROM Top_Anime_data
GROUP BY type;

	

--Which year had the most anime releases?
--Count entries by start_year or year column.

SELECT
	first_year,
	count(*) as "number of releases"
From (
SELECT
	substr(
		substr(Aired, 1,																				-- beginning of "Aired"
            CASE
                WHEN instr(Aired, ' to ') > 0 THEN instr(Aired, ' to ') - 1								-- sets end point, if  " to " exists then end point is one index before " to " else the end point is just the end of the string.
                ELSE length(Aired)
            END
        ),
        -4																								-- starts 4 indexs from the end of the new truncated string
    ) AS first_year
FROM Top_Anime_data
)
group by first_year
order by "number of releases" DESC
limit 1;



	
--What is the distribution of number of episodes across all anime?
--Compute basic statistics like min, max, AVG.

SELECT 
	min(cast(episodes as unsigned)) as min_episodes,
	max(cast(episodes as unsigned)) as max_episodes,
	AVG(cast(episodes as unsigned)) as avg_episodes
FROM Top_Anime_data
where cast(episodes as unsigned) > 0;


--Which anime have a score above the overall dataset average?
--Calculate AVG(score) then filter.

select
	Japanese,
	English,
	Score
from Top_Anime_data
WHERE Score > (
	SELECT AVG(Score)
	FROM Top_Anime_data
)
order by Score DESC;


--What are the top 5 highest‑scoring anime in each genre?
--Requires splitting or filtering genre columns.

WITH exploded AS (
    SELECT
        Japanese,
        English,
        score,
        trim(value) AS genre
    FROM Top_Anime_data,
         json_each('["' || replace(genres, ', ', '","') || '"]')
)
SELECT
    Japanese,
    English,
    genre,
    score
FROM (
    SELECT
        Japanese,
        English,
        genre,
        score,
        ROW_NUMBER() OVER (
            PARTITION BY genre
            ORDER BY score DESC
        ) AS rn
    FROM exploded
)
WHERE rn <= 5; 
	
	

-- Which anime have the biggest gap between popularity rank and score rank?
-- Useful for finding “underrated” or “overrated” titles.

Select
    Japanese,
    English,
    Popularity,
    Score,
    ABS(Popularity - Score) AS rank_gap
From Top_Anime_data
Order By rank_gap DESC
limit 5;

--What are the most common genres across the dataset?
--Count genre occurrences, requires splitting multi‑value fields.

WITH exploded AS (
    SELECT
        trim(value) AS genre
    FROM Top_Anime_data,
         json_each('["' || replace(genres, ', ', '","') || '"]')
)
SELECT
	genre,
    count(*) as genre_count
FROM exploded
Group By Genre
Order By genre_count DESC;


