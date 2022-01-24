SELECT 
    round(avg(v.compensation_from), 2) AS avg_from,
    round(avg(v.compensation_to), 2) AS avg_to,
    round(avg(v.compensation_from + v.compensation_to), 2),
    area_id
FROM vacancy AS v
GROUP BY area_id;