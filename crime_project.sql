-- Which districts have the highest crime rate once population and area are taken into account?

use crime;

select district_name,population,area_sq_km,

case 
	when population  >60000 then 'large'
    when population  >50000 then 'medium'
    else 'small'
end as population_category
from districts
order by district_name desc
;

-- Which crime categories make up most incidents, and what share of the total is each?

select s1.category, count(s2.incident_id) as number_of_incident,

round(count(s2.incident_id) / sum(count(s2.incident_id)) over () * 100, 2) as crime_percentage
from crime.crime_types as s1
inner join crime.incidents as s2
on s1.crime_type_id = s2.crime_type_id

group by s1.category

order by count(s2.incident_id) desc;

-- How do incidents compare year over year, using the same months in each year (January to September) so the partial 2025 data doesn’t mislead?

select count(incident_id) as number_of_incident, year(occurred_at) as year , monthname(occurred_at) as month_name, month(occurred_at) as month_number

from incidents
where year(occurred_at) between 2023 and 2024 and   month(occurred_at) between 1 and 9
group by  year(occurred_at) , monthname(occurred_at),month(occurred_at) 
order by count(incident_id)  desc
; 

-- At what times of day and on which weekdays do incidents peak, and does the pattern differ for violent crime?

select 

s1.category,
count(s2.incident_id) as number_of_incident, dayname(s2.occurred_at) days_name , hour(s2.occurred_at)as occured_time

from crime.crime_types as s1

inner join crime.incidents as s2
on s1.crime_type_id = s2.crime_type_id

group by s1.category, dayname(s2.occurred_at) ,hour(s2.occurred_at)
order by number_of_incident desc;

select 

s1.category,
count(s2.incident_id) as number_of_incident, dayname(s2.occurred_at) days_name , hour(s2.occurred_at)as occured_time

from crime.crime_types as s1

inner join crime.incidents as s2
on s1.crime_type_id = s2.crime_type_id
where s1.category = 'violent'
group by s1.category, dayname(s2.occurred_at) ,hour(s2.occurred_at)
order by number_of_incident desc;

-- Which felony cases are still open or under investigation after more than a year, and which crime types have the biggest backlog?

SELECT 
    s1.crime_type,
    COUNT(s2.incident_id) AS backlog_count
FROM crime.crime_types AS s1
INNER JOIN crime.incidents AS s2
    ON s1.crime_type_id = s2.crime_type_id
WHERE s2.status IN ('Open', 'Under Investigation')
  AND s1.offense_level = 'Felony'
  AND TIMESTAMPDIFF(MONTH, s2.occurred_at, CURRENT_DATE) > 12
GROUP BY s1.crime_type
ORDER BY backlog_count DESC;

-- Who handles the most cases, which officers carry more than the average, 
-- and does experience or rank change how many cases they close?

select s1.officer_name , count(s2.incident_id) as number_case 
from crime.officers as s1
inner join crime.incidents as s2
on s1.district_id = s2.district_id
group by s1.officer_name

having count(s2.incident_id) < avg (s2.incident_id)

;
-- Which crime types cause the largest total loss, and are any single incidents unusual outliers?

select s1.crime_type,round(sum(s2.loss_amount),2) as total_loss

from crime.crime_types as s1
inner join crime.incidents as s2
on s1.crime_type_id = s2.crime_type_id
group by s1.crime_type
order by round(sum(s2.loss_amount),2) desc
;
-- Where do violent crimes and vehicle thefts happen most (street, residence, parking lot and so on)

select s1.crime_type,s2.location_type,
count(s2.location_type) as most_happen
 from
crime.crime_types as s1
inner join crime.incidents as s2
on s1.crime_type_id = s2.crime_type_id
where s1.crime_type ='Vehicle Theft'
group by location_type
order by most_happen desc;




