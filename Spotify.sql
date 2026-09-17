create database Spotify
use Spotify

select * from spotify_dataset

-- 1 Retrieve the names of all tracks that have more than 1 billion streams.

select 
Track,
Stream
from spotify_dataset
where Stream>1000000000
limit 5

-- 2 List all albums along with their respective artists.
select
Distinct Album,
Artist
from spotify_dataset

-- 3 Get the total number of comments for tracks where licensed = TRUE.
select
sum(Comments)
from spotify_dataset
where Licensed='True'

-- 4 Find all tracks that belong to the album type single.

select 
Track,Album_type
from spotify_dataset
where Album_type='single'
-- 5 Count the total number of tracks by each artist.
select
Artist,
count(Track) as total
from spotify_dataset
group by 1

-- Medium Level
-- 1 Calculate the average danceability of tracks in each album.
select
Album,
avg(Danceability) as AVG_D
from spotify_dataset
group by 1
order by 2 desc
-- 2 Find the top 5 tracks with the highest energy values.
select
Track,
Max(EnergyLiveness)
from spotify_dataset
group by 1
order by 2 desc
limit 5
-- another approach
select
Track,
EnergyLiveness
from spotify_dataset
order by 2 desc
limit 5

-- 3 List all tracks along with their views and likes where official_video = TRUE.
select
Track,
sum(Views) as Total_view,
sum(Likes) as total_like,
official_video
from spotify_dataset
where official_video='True'
group by 1
order by 2,3 desc
limit 5

-- 4 For each album, calculate the total views of all associated tracks.
select * from spotify_dataset

select 
Album,
Track,
sum(Views) as total_view
from spotify_dataset
group by 1,2

-- 5 Retrieve the track names that have been streamed on Spotify more than YouTube.
select *
from
(select
Track,
coalesce(sum(case when most_playedon='youtube' then Stream End),0) as streamed_on_youtube,
coalesce(sum(case when most_playedon='spotify' then Stream End),0) as streamed_on_spotify
from spotify_dataset
Group by 1) as t1
where streamed_on_spotify>streamed_on_youtube
and
streamed_on_youtube != 0

-- Advanced Level
-- 1 Find the top 3 most-viewed tracks for each artist using window functions.
with Cte_table
as
(select
Artist,
Track,
sum(views) as Total_view,
dense_rank() over(partition by Artist order by sum(views) desc) as rnk
from spotify_dataset
group by 1,2
order by 1,3 desc)
select *
-- Artist,
-- Track,
-- Total_view
from Cte_table
where rnk<=3


-- 2 Write a query to find tracks where the liveness score is above the average.
select *
from spotify_dataset
where Liveness> (select avg(Liveness) from spotify_dataset)

-- 3 Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

with CTE
as
(select
Album,
Max(energy) as Max_energy,
Min(energy) as Min_energy
from spotify_dataset
group by 1)
select
Album,
Max_energy-Min_energy as Dff
from CTE
order by 2 desc

-- 4 Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT
    Track,
    energy,
    liveness,
    energy / liveness AS energy_liveness_ratio
FROM spotify_dataset
WHERE energy / liveness > 1.2;



-- 5 Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
SELECT
    Track,
    views,
    likes,
    SUM(likes) OVER (
        ORDER BY views
    ) AS cumulative_likes
FROM spotify_dataset;