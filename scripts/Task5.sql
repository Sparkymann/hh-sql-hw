--так как тестовые данные никак не контролировались, могут быть отклики, сделанные
--раньше, чем создана вакансия - придется их отсеивать.
SELECT v.id,
       title
FROM vacancy AS v
    LEFT JOIN negotiation AS n ON v.id = n.vacancy_id AND n.creation_date >= v.creation_date
WHERE date_part('day', n.creation_date - v.creation_date) <= 7
GROUP BY v.id, title
HAVING count(n.id) > 5;
