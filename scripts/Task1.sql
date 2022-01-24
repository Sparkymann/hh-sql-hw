--Таблички, которые будут фигурировать в дальнейших заданиях
--Полями особо не перегружал, дабы не усложнять. Для запросов все нужные колонки есть
-- + еще немножко, чтобы совсем пустыми не выглядели
CREATE TABLE area (
    id   serial PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE employer (
    id           serial PRIMARY KEY,
    name         text                     NOT NULL,
    phone_number text                     NOT NULL,
    area_id      int REFERENCES area (id) NOT NULL
);

CREATE TABLE employee (
    id           serial PRIMARY KEY,
    first_name   text NOT NULL,
    second_name  text NOT NULL,
    middle_name  text,
    phone_number text NOT NULL, 
    --Судя по сайту регион для соискателя не обязателен к заполнению
    area_id      int REFERENCES area (id)
);

CREATE TABLE resume (
    id            serial PRIMARY KEY,
    title         text                         NOT NULL,
    description   text,
    creation_date TIMESTAMP                    NOT NULL DEFAULT now(),
    area_id       int REFERENCES area (id)     NOT NULL,
    employee_id   int REFERENCES employee (id) NOT NULL
);

CREATE TABLE vacancy (
    id                serial PRIMARY KEY,
    title             text                         NOT NULL,
    description       text,
    compensation_from int,
    compensation_to   int,
    creation_date     TIMESTAMP                    NOT NULL DEFAULT now(),
    area_id           int REFERENCES area (id)     NOT NULL,
    employer_id       int REFERENCES employer (id) NOT NULL
);

CREATE TABLE negotiation (
    id            serial PRIMARY KEY,
    creation_date TIMESTAMP,
    vacancy_id    int REFERENCES vacancy (id) NOT NULL,
    resume_id     int REFERENCES resume (id)  NOT NULL
);

--Таблички, которые нужно было создать в 1 задании и они в дальнейших заданиях мне не понадобились
--Отрасль
CREATE TABLE sector (
    id   serial PRIMARY KEY,
    name text
);

--Специализация
CREATE TABLE professional_role (
    id        serial PRIMARY KEY,
    name      text,
    sector_id int REFERENCES sector (id) NOT NULL
);

-- Таблички-связки многие ко многим для указания специлизаций в вакансиях/резюме
CREATE TABLE resume_role (
    id        serial PRIMARY KEY,
    resume_id int REFERENCES resume (id)            NOT NULL,
    role_id   int REFERENCES professional_role (id) NOT NULL
);

CREATE TABLE vacancy_role (
    id         serial PRIMARY KEY,
    vacancy_id int REFERENCES vacancy (id)           NOT NULL,
    role_id    int REFERENCES professional_role (id) NOT NULL
);