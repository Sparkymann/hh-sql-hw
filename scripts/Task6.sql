--думаю, что часто делаются выборки за конкретную дату или больше/меньше/в интервале,
--так что индекс по датам создания лишним не будет
CREATE INDEX vacancy_creation_date_idx ON vacancy (creation_date);
CREATE INDEX negotiation_creation_date_idx ON negotiation (creation_date);
CREATE INDEX resume_creation_date_idx ON resume (creation_date);

--скорее всего работодателя/резюме/вакансию могут искать по наименование, при чем не
--только по полному совпадению, но и по частичному
CREATE EXTENSION pg_trgm;
CREATE INDEX resume_title_idx ON resume USING gin (title gin_trgm_ops);
CREATE INDEX vacancy_title_idx ON vacancy USING gin (title gin_trgm_ops);
CREATE INDEX employer_name_idx ON employer USING gin (name gin_trgm_ops);

--ограничения по сумма тоже думаю частое явление
CREATE INDEX vacancy_compensation_from_idx ON vacancy (compensation_from);
CREATE INDEX vacancy_compensation_to_idx ON vacancy (compensation_to);
CREATE INDEX vacancy_compensation_from_to_idx ON vacancy (compensation_from, compensation_to);
