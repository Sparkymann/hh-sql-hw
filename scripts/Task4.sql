(
    SELECT
        extract(MONTH FROM v.creation_date) AS month_num
    FROM vacancy AS v
    GROUP BY extract(MONTH FROM v.creation_date)
    ORDER BY count(v.id) DESC LIMIT 1
)
UNION ALL
(
    SELECT
        extract(MONTH FROM r.creation_date)
    FROM resume AS r
    GROUP BY extract(MONTH FROM r.creation_date)
    ORDER BY count(r.id) DESC LIMIT 1
)