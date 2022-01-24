WITH names AS (
    SELECT
        md5(random()::text)
    FROM generate_series(1, 15)
)
INSERT INTO area(name)
SELECT *
FROM names;

WITH employer_data AS (
    SELECT md5(random()::text),
           md5(random()::text),
           trunc(random() * 10 + 1)
    FROM generate_series(1, 500)
)
INSERT INTO employer(name, phone_number, area_id)
SELECT *
FROM employer_data;

WITH employee_data AS (
    SELECT
        md5(random()::text),
        md5(random()::text),
        md5(random()::text)
    FROM generate_series(1, 40000)
)
INSERT INTO employee(first_name, second_name, phone_number)
SELECT *
FROM employee_data;

--Для простоты работаю только с одним годом
WITH vacancy_data(descr, title, comp, area, employer, date) AS (
    SELECT 
        md5(random()::text),
        md5(random()::text),
        round((random() * 100000)::int),
        trunc(random() * 10 + 1),
        trunc(random() * 500 + 1),
        ('2022-' || trunc(random() * 12 + 1)::text || '-01')::TIMESTAMP
    FROM generate_series(1, 10000))
INSERT INTO vacancy(description, title, compensation_from, compensation_to, area_id, employer_id, creation_date)
SELECT 
    descr,
    title,
    comp,
    (comp + 10000),
    area,
    employer,
    date
FROM vacancy_data;

WITH resume_data(descr, title, area, employee, date) AS (
    SELECT
        md5(random()::text),
        md5(random()::text),
        trunc(random() * 10 + 1),
        trunc(random() * 40000 + 1),
        ('2022-' || trunc(random() * 12 + 1)::text || '-01')::TIMESTAMP
    FROM generate_series(1, 100000)
)
INSERT INTO resume(description, title, area_id, employee_id, creation_date)
SELECT
    descr,
    title,
    area,
    employee,
    date
FROM resume_data;

--так как данные тестовые, думаю, не критично, что при таком наполнении возможна ситуация, когда дата отклика может быть
--меньше даты создания вакансии
WITH link AS (
    SELECT
        trunc(random() * 10000 + 1),
        trunc(random() * 100000 + 1),
        ('2022-' || trunc(random() * 12 + 1)::text || '-' || trunc(random() * 28 + 1)::text)::TIMESTAMP
    FROM generate_series(1, 1000000)
)
INSERT INTO negotiation(vacancy_id, resume_id, creation_date)
SELECT *
FROM link;

