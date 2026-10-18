-- How many incidents are in the table?
use crime;
select count(incident_id) from incidents;

-- How many incidents are there per crime type, from highest to lowest?
use crime;

select s1.crime_type,count(s2.incident_id) as number_of_incident

from crime.crime_types as s1
inner join crime.incidents as s2
on s1.crime_type_id  = s2.crime_type_id
group by s1.crime_type
order by count(s2.incident_id)  desc
;
-- 
select weapon_used, count(weapon_used) as number_of_time_used
 from incidents
where year(occurred_at) = 2024 and weapon_used = 'Firearm'	
group by weapon_used
;

-- Which districts have more than 2,000 incidents?
select s1.district_name,count(s2.incident_id) as number_of_incident
from crime.districts as s1
inner join crime.incidents as s2
on s1.district_id = s2.district_id
group by s1.district_name
having count(s2.incident_id) > 2000;

-- Find any duplicate incident IDs.

select incident_id,
count(*) as duplicate_count
from incidents
group by incident_id
having count(*) >1;

-- How many incidents have a missing victim age, and what is the average victim age?


SELECT
    SUM(CASE WHEN victim_age IS NULL THEN 1 ELSE 0 END) AS missing_age_count,
    AVG(victim_age) AS avg_victim_age
FROM incidents;



-- 