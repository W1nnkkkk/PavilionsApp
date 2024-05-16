--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

-- Started on 2024-05-16 20:20:45 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 214 (class 1255 OID 16414)
-- Name: PavilionsRent(integer, character varying, integer, character varying, character varying, date, date); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public."PavilionsRent"(IN id_ten integer, IN sc_nam character varying, IN id_emp integer, IN pav_n character varying, IN pav_stat character varying, IN date_b date, IN date_e date)
    LANGUAGE plpgsql
    AS $$
DECLARE id_re integer;
BEGIN
	SELECT id_rent INTO id_re FROM rent
    ORDER BY id_rent DESC
    LIMIT 1;
    
    id_re := COALESCE(id_re, 0) + 1;
	
	UPDATE pavilions
	SET pav_status = pav_stat
	WHERE sc_name = sc_nam AND pavilion_num = pav_n;

	INSERT INTO public.rent(
	id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end)
	VALUES (id_re, id_ten, sc_nam, id_emp, pav_n, pav_stat, date_b, date_e); 
END;
$$;


ALTER PROCEDURE public."PavilionsRent"(IN id_ten integer, IN sc_nam character varying, IN id_emp integer, IN pav_n character varying, IN pav_stat character varying, IN date_b date, IN date_e date) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16416)
-- Name: pavilions_rent(integer, character varying, integer, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.pavilions_rent(IN id_ten integer, IN sc_nam character varying, IN id_emp integer, IN pav_n character varying, IN pav_stat character varying, IN rent_pav_stat character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	id_re integer := (SELECT id_rent FROM rent ORDER BY id_rent DESC LIMIT 1) + 1;
	date_b date := CURRENT_DATE;
    date_e date := CURRENT_DATE + INTERVAL '1 month'; 
BEGIN 
	UPDATE pavilions
	SET pav_status = pav_stat
	WHERE sc_name = sc_nam AND pavilion_num = pav_n;

	INSERT INTO public.rent(
	id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end)
	VALUES (id_re, id_ten, sc_nam, id_emp, pav_n, rent_pav_stat, date_b, date_e); 
END;
$$;


ALTER PROCEDURE public.pavilions_rent(IN id_ten integer, IN sc_nam character varying, IN id_emp integer, IN pav_n character varying, IN pav_stat character varying, IN rent_pav_stat character varying) OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 16417)
-- Name: pavilions_rent_wrapper(integer, character varying, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pavilions_rent_wrapper(id_ten integer, sc_nam character varying, id_emp integer, pav_n character varying, pav_stat character varying, rent_pav_stat character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	CALL pavilions_rent(id_ten, sc_nam, id_emp, pav_n, pav_stat, rent_pav_stat);
	RETURN 0; 
END;
$$;


ALTER FUNCTION public.pavilions_rent_wrapper(id_ten integer, sc_nam character varying, id_emp integer, pav_n character varying, pav_stat character varying, rent_pav_stat character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 16395)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    login character varying(40),
    password character varying(40),
    role character varying(40),
    telephone_number character varying(40),
    gender character varying(10),
    id integer NOT NULL,
    second_name character varying(40),
    first_name character varying(40),
    third_name character varying(40)
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16390)
-- Name: pavilions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pavilions (
    sc_name character varying(40) NOT NULL,
    pavilion_num character varying(5) NOT NULL,
    floor integer,
    pav_status character varying(15),
    square real,
    cost_per_square real,
    value_added_coof real,
    city character varying(40) NOT NULL
);


ALTER TABLE public.pavilions OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16407)
-- Name: rent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rent (
    id_rent integer NOT NULL,
    id_tenat integer,
    sc_name character varying(40),
    id_employee integer,
    pavilion_num character varying(5),
    pav_status character varying(15),
    date_begin date,
    date_end date
);


ALTER TABLE public.rent OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: sc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc (
    name character varying(40) NOT NULL,
    sc_status character varying(15),
    pavilions_count integer,
    city character varying(40) NOT NULL,
    cost bigint,
    value_added_coof real,
    floor_count integer,
    photo character varying(300)
);


ALTER TABLE public.sc OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16402)
-- Name: tenats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenats (
    id integer NOT NULL,
    office_name character varying(40),
    telephone_number character varying(20),
    adress character varying(100)
);


ALTER TABLE public.tenats OWNER TO postgres;

--
-- TOC entry 3378 (class 0 OID 16395)
-- Dependencies: 211
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Elizor@gmai.com', 'yntiRS', 'Администратор', ' +7(1070)628 29 16', 'Мужской', 1, 'Чашин', 'Елизар', 'Михеевич');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Vladlena@gmai.com', '07i7Lb', 'Менеджер А', ' +7(334)1460151', 'Женский', 2, 'Филенкова', 'Владлена', 'Олеговна');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Adam@gmai.com', '7SP9CV', 'Менеджер С', '+7(8560)519-32-99', 'Male', 3, 'Ломовцев', 'Адам', 'Владимирович');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Kar@gmai.com', '6QF1WB', 'Удален', '+7(824)893-24-03', 'Male', 4, 'Тепляков', 'Кир', 'Федосиевич');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Yli@gmai.com', 'GwffgE', 'Администратор', '+7(6402)701-31-09', 'Мужской', 5, 'Рюриков', 'Юлий', 'Глебович');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Vasilisa@gmai.com', 'd7iKKV', 'Администратор', '+7(92)920-74-47', 'Ж', 6, 'Беломестина', 'Василиса', 'Тимофеевна');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Galina@gmai.com', '8KC7wJ', 'Менеджер А', ' +7 (405) 088 73 89', 'Female', 7, 'Панькива', 'Галина', 'Якововна');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Miron@gmai.com', 'x58OAN', 'Администратор', '+7(6010)195-02-09', 'М', 8, 'Зарубин', 'Мирон', 'Мечиславович');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Vseslava@gmai.com', 'fhDSBf', 'Менеджер С', '+7(078)429-57-86', 'Женский', 9, 'Веточкина', 'Всеслава', 'Андрияновна');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Victoria@gmai.com', '9mlPQJ', 'Удален', '+7(6394)904-01-61', 'Female', 10, 'Рябова', 'Виктория', 'Елизаровна');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Anisa@gmai.com', 'Wh4OYm', 'Менеджер А', ' +7(22)3264959', 'М', 11, 'Федотов', 'Леон', 'Фёдорович');
INSERT INTO public.employee (login, password, role, telephone_number, gender, id, second_name, first_name, third_name) VALUES ('Feafan@gmai.com', 'Kc1PeS', 'Менеджер С', '+7(789)762-30-28', 'М', 12, 'Шарапов', 'Феофан', 'Кириллович');


--
-- TOC entry 3377 (class 0 OID 16390)
-- Dependencies: 210
-- Data for Name: pavilions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Мега Белая Дача', '88А', 1, 'Свободен', 75, 3308, 0.1, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Авиапарк', '40А', 3, 'Забронировано', 96, 690, 1.1, 'Санкт-Петербург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Мега Белая Дача', '76Б', 2, 'Удален', 199, 4938, 0.9, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Гранд', '58В', 4, 'Арендован', 98, 1306, 1.9, 'Ростов-на-Дону ');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Лужайка', '7А', 2, 'Забронировано', 187, 2046, 1, 'Казань');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Кунцево Плаза', '13Б', 1, 'Забронировано', 141, 1131, 0.1, 'Челябинск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Мозаика', '60В', 2, 'Забронировано', 94, 361, 0.3, 'Самара');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Гранд', '56А', 1, 'Арендован', 148, 1163, 0.6, 'Ростов-на-Дону ');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Гранд', '63Г', 2, 'Забронировано', 153, 3486, 0.7, 'Ростов-на-Дону ');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Бутово Молл', '8Г', 1, 'Арендован', 122, 2451, 1.5, 'Москва');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Гранд', '94В', 3, 'Свободен', 132, 4825, 2, 'Ростов-на-Дону ');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Шоколад', '87Г', 1, 'Забронировано', 174, 793, 1.5, 'Челябинск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('АфиМолл Сити', '93В', 1, 'Арендован', 165, 4937, 0.8, 'Санкт-Петербург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Европейский', '10А', 3, 'Забронировано', 168, 1353, 1.7, 'Москва');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Шереметьевский', '53Г', 1, 'Арендован', 99, 3924, 1, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Шереметьевский', '73В', 2, 'Свободен', 116, 3418, 0, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Мега Химки', '89Б', 1, 'Арендован', 92, 562, 0.4, 'Нижний Новгород');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Рио', '61А', 1, 'Арендован', 186, 2115, 0.9, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Москва', '44Г', 2, 'Забронирован', 66.6, 870.3, 1, 'Москва');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Вегас Кунцево', '65А', 2, 'Забронирован', 95, 1381, 1.7, 'Москва');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Город Лефортово', '16Г', 2, 'Удален', 150, 747, 0.8, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Золотой Вавилон Ростокино', '61Б', 1, 'Свободен', 58, 1032, 1.7, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Шереметьевский', '34Б', 4, 'Забронировано', 102, 4715, 0.3, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Шереметьевский', '91Г', 3, 'Арендован', 171, 1021, 1.2, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Ашан Сити Капитолий', '70Г', 1, 'Забронировано', 83, 2246, 1.4, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Черемушки', '10А', 1, 'Забронирован', 187, 2067, 0, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Филион', '80Г', 1, 'Забронировано', 117, 1049, 1.3, 'Москва');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Весна', '2Б', 1, 'Удален', 176, 1673, 1.7, 'Нижний Новгород');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Гудзон', '41А', 1, 'Свободен', 108, 344, 0, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Калейдоскоп', '16Г', 2, 'Арендован', 125, 1037, 1.3, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Золотой Вавилон Ростокино', '13Б', 2, 'Свободен', 161.5, 2775.7, 0.4, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Хорошо', '83Г', 2, 'Арендован', 85.5, 4584, 0.3, 'Ростов-на-Дону ');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Щука', '9Г', 1, 'Забронировано', 131, 2477, 1.5, 'Нижний Новгород');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Атриум', '49Г', 1, 'Арендован', 164, 2728, 0.9, 'Казань');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Принц Плаза', '1Г', 1, 'Удален', 157, 1963, 1.6, 'Самара');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Золотой Вавилон Ростокино', '37А', 3, 'Арендован', 187, 3173, 0.3, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Золотой Вавилон Ростокино', '38Г', 4, 'Арендован', 97, 1364, 0.5, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Реутов Парк', '27В', 1, 'Забронировано', 96, 3134, 0.1, 'Ростов-на-Дону ');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('ЕвроПарк', '67Б', 1, 'Удален', 55, 4442, 0.8, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('ГУМ', '86Г', 1, 'Свободен', 58, 3707, 0.5, 'Санкт-Петербург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Райкин Плаза', '98А', 3, 'Забронировано', 172.5, 4951, 1.1, 'Санкт-Петербург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Новинский пассаж', '11Г', 2, 'Арендован', 194, 827, 0.6, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Фестиваль', '42В', 1, 'Свободен', 166, 4216, 0.7, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Красный Кит', '55А', 2, 'Забронировано', 127, 703, 1, 'Казань');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Фестиваль', '6Б', 2, 'Свободен', 119, 3262, 1.9, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Отрада', '15А', 1, 'Забронировано', 90, 1569, 1.3, 'Санкт-Петербург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Фестиваль', '27Б', 3, 'Арендован', 132, 627, 0.4, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Фестиваль', '65Б', 4, 'Удален', 60, 3052, 0.6, 'Новосибирск');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Времена Года', '26А', 1, 'Свободен', 95, 670, 1.7, 'Екатеринбург');
INSERT INTO public.pavilions (sc_name, pavilion_num, floor, pav_status, square, cost_per_square, value_added_coof, city) VALUES ('Времена Года', '53В', 3, 'Арендован', 132, 510, 1.2, 'Екатеринбург');


--
-- TOC entry 3380 (class 0 OID 16407)
-- Dependencies: 213
-- Data for Name: rent; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (1, 2, 'Мега Белая Дача', 2, '88А', 'Открыт', '2019-01-24', NULL);
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (2, 2, 'Авиапарк  ', 7, '40А', 'Ожидание', '2019-11-21', '2020-04-18');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (3, 5, 'Рио  ', 11, '61А', 'Закрыт', '2018-11-12', '2019-06-28');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (4, 1, 'Гранд  ', 2, '58В', 'Закрыт', '2018-10-18', '2019-09-16');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (5, 5, 'Лужайка  ', 7, '7А', 'Ожидание', '2019-12-19', '2020-06-26');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (6, 2, 'Кунцево Плаза ', 11, '13Б', 'Ожидание', '2019-12-16', '2020-05-12');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (7, 4, 'Мозаика  ', 2, '60В', 'Ожидание', '2019-12-06', '2020-10-16');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (8, 2, 'Гранд  ', 11, '56А', 'Закрыт', NULL, '2019-02-10');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (9, 2, 'Гранд  ', 2, '63Г', 'Ожидание', '2019-11-04', '2020-06-27');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (10, 4, 'Бутово Молл ', 7, '8Г', 'Закрыт', '2018-11-08', '2019-01-16');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (11, 1, 'Гранд  ', 2, '94В', 'Открыт', '2019-06-07', '2020-03-18');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (12, 1, 'Шоколад  ', 2, '87Г', 'Ожидание', '2019-11-15', '2020-06-20');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (13, 5, 'АфиМолл Сити ', 11, '93В', 'Закрыт', '2018-10-09', '2019-09-22');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (14, 5, 'Европейский  ', 7, '10А', 'Ожидание', '2019-11-24', '2020-07-17');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (15, 1, 'Шереметьевский  ', 7, '53Г', 'Закрыт', '2018-07-20', '2019-06-07');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (16, 3, 'Шереметьевский  ', 11, '73В', 'Открыт', '2019-02-04', '2019-06-07');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (17, 2, 'Мега Химки ', 2, '89Б', 'Открыт', '2019-08-06', '2020-08-20');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (18, 1, 'Золотой Вавилон Ростокино', 7, '61Б', 'Открыт', '2019-05-23', '2020-05-13');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (19, 3, 'Шереметьевский  ', 2, '34Б', 'Ожидание', '2019-12-16', '2020-03-16');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (20, 3, 'Шереметьевский  ', 11, '91Г', 'Закрыт', '2018-08-24', NULL);
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (21, 5, 'Ашан Сити Капитолий', 2, '70Г', 'Ожидание', '2019-11-09', '2020-08-17');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (22, 4, 'Европейский  ', 7, '10А', 'Ожидание', '2019-12-02', '2020-07-24');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (23, 2, 'Филион  ', 11, '80Г', 'Ожидание', '2019-11-23', '2020-08-06');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (24, 4, 'Гудзон  ', 7, '41А', 'Открыт', '2019-05-02', '2020-06-24');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (25, 3, 'Кунцево Плаза ', 2, '13Б', 'Ожидание', '2019-12-08', '2020-08-17');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (26, 3, 'Хорошо  ', 7, '83Г', 'Закрыт', '2018-11-14', '2019-04-19');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (27, 4, 'Щука  ', 11, '9Г', 'Ожидание', '2019-12-26', '2020-09-13');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (28, 1, 'Атриум  ', 2, '49Г', 'Закрыт', '2018-09-16', '2019-02-12');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (29, 3, 'Золотой Вавилон Ростокино', 2, '37А', 'Закрыт', '2018-10-18', '2019-06-22');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (30, 4, 'Золотой Вавилон Ростокино', 2, '38Г', 'Закрыт', '2018-06-23', '2019-08-26');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (31, 3, 'Реутов Парк ', 11, '27В', 'Ожидание', '2019-12-18', '2020-05-23');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (32, 5, 'ГУМ  ', 7, '86Г', 'Открыт', '2019-04-01', '2020-12-19');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (33, 4, 'Райкин Плаза ', 11, '98А', 'Ожидание', '2019-11-22', '2020-08-15');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (34, 3, 'Новинский пассаж ', 11, '11Г', 'Закрыт', '2018-10-08', '2019-07-21');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (35, 2, 'Фестиваль  ', 2, '42В', 'Открыт', '2019-04-07', '2020-03-05');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (36, 1, 'Красный Кит ', 7, '55А', 'Ожидание', '2019-11-07', '2020-03-08');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (37, 3, 'Фестиваль  ', 2, '6Б', 'Открыт', '2019-07-15', '2020-04-25');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (38, 1, 'Отрада  ', 2, '15А', 'Ожидание', '2019-07-15', '2020-12-02');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (39, 4, 'Фестиваль  ', 11, '27Б', 'Закрыт', '2018-08-05', '2019-06-14');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (40, 2, 'Времена Года ', 11, '26А', 'Открыт', '2019-08-19', '2020-09-02');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (41, 4, 'Времена Года ', 7, '53В', 'Закрыт', '2018-09-20', '2019-02-12');
INSERT INTO public.rent (id_rent, id_tenat, sc_name, id_employee, pavilion_num, pav_status, date_begin, date_end) VALUES (42, 12, 'Рио', 32, '61А', 'Ожидание', '2024-05-16', '2024-06-16');


--
-- TOC entry 3376 (class 0 OID 16385)
-- Dependencies: 209
-- Data for Name: sc; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Ривьера', 'План', 0, 'Москва', 8260042, 0.5, 4, 'qrc:/Images/images/Image ТЦ/Ривьера.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Мега Белая Дача', 'Удален', 16, 'Новосибирск', 9006645, 1.7, 4, 'qrc:/Images/images/Image ТЦ/Мега Белая Дача.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Рио', 'Реализация', 5, 'Екатеринбург', 1888653, 0.5, 1, 'qrc:/Images/images/Image ТЦ/Рио.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Вегас', 'План', 0, 'Нижний Новгород', 7567411, 0.4, 3, 'qrc:/Images/images/Image ТЦ/Вегас.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Океания', 'План', 0, 'Самара', 5192089, 1.8, 2, 'qrc:/Images/images/Image ТЦ/Океания.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Бутово Молл', 'План', 0, 'Москва', 5327641, 1.7, 1, 'qrc:/Images/images/Image ТЦ/Бутово Молл.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Рига Молл', 'План', 0, 'Ростов-на-Дону ', 9788316, 0.7, 3, 'qrc:/Images/images/Image ТЦ/Рига Молл.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('АфиМолл Сити', 'Реализация', 9, 'Санкт-Петербург', 8729160, 0.9, 3, 'qrc:/Images/images/Image ТЦ/АфиМолл Сити.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Гагаринский', 'План', 0, 'Екатеринбург', 1508807, 1.6, 1, 'qrc:/Images/images/Image ТЦ/Гагаринский.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Метрополис', 'План', 0, 'Санкт-Петербург', 8117913, 0, 2, 'qrc:/Images/images/Image ТЦ/Метрополис.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Мега Химки', 'Реализация', 3, 'Нижний Новгород', 3373234, 0.4, 1, 'qrc:/Images/images/Image ТЦ/Мега Химки.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Москва', 'Реализация', 12, 'Москва', 4226505, 0.3, 3, 'qrc:/Images/images/Image ТЦ/Москва.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Вегас Кунцево', 'Реализация', 12, 'Москва', 3878254, 0.2, 4, 'qrc:/Images/images/Image ТЦ/Вегас Кунцево.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Город Лефортово', 'Удален', 12, 'Новосибирск', 1966214, 1.7, 4, 'qrc:/Images/images/Image ТЦ/Город Лефортово.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Золотой Вавилон Ростокино', 'Реализация', 16, 'Екатеринбург', 1632702, 1.8, 4, 'qrc:/Images/images/Image ТЦ/Золотой Вавилон Ростокино.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Черемушки', 'Реализация', 15, 'Новосибирск', 7344604, 1, 3, 'qrc:/Images/images/Image ТЦ/Черемушки.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Калейдоскоп', 'Реализация', 10, 'Новосибирск', 7847659, 0.7, 2, 'qrc:/Images/images/Image ТЦ/Калейдоскоп.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Хорошо', 'Реализация', 0, 'Ростов-на-Дону ', 8306576, 1.9, 4, 'qrc:/Images/images/Image ТЦ/Хорошо.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Атриум', 'Реализация', 4, 'Казань', 5059779, 0.2, 1, 'qrc:/Images/images/Image ТЦ/Атриум.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Принц Плаза', 'Реализация', 8, 'Самара', 1786688, 1.5, 2, 'qrc:/Images/images/Image ТЦ/Принц Плаза.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Облака', 'План', 0, 'Санкт-Петербург', 1688905, 0.6, 3, 'qrc:/Images/images/Image ТЦ/Облака.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Три Кита', 'План', 0, 'Казань', 3089700, 1.7, 1, 'qrc:/Images/images/Image ТЦ/Три Кита.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('ЕвроПарк', 'Удален', 20, 'Новосибирск', 9391338, 0.7, 4, 'qrc:/Images/images/Image ТЦ/ЕвроПарк.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('ГУМ', 'Реализация', 5, 'Санкт-Петербург', 6731491, 1.9, 1, 'qrc:/Images/images/Image ТЦ/ГУМ.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Новинский пассаж', 'Реализация', 8, 'Екатеринбург', 3158957, 1.7, 2, 'qrc:/Images/images/Image ТЦ/Новинский пассаж.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Наш Гипермаркет', 'План', 0, 'Ростов-на-Дону ', 1088735, 1.2, 4, 'qrc:/Images/images/Image ТЦ/Наш Гипермаркет.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Мегаполис', 'План', 0, 'Челябинск', 2175218, 0.5, 2, 'qrc:/Images/images/Image ТЦ/Мегаполис.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Твой дом', 'План', 0, 'Челябинск', 6810865, 1.7, 4, 'qrc:/Images/images/Image ТЦ/Твой дом.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Новомосковский', 'План', 0, 'Казань', 7161962, 0.4, 1, 'qrc:/Images/images/Image ТЦ/Новомосковский.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Ханой-Москва', 'План', 0, 'Самара', 9580221, 0.3, 4, 'qrc:/Images/images/Image ТЦ/Ханой-Москва.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Лужайка', 'Строительство', 10, 'Казань', 4603336, 0.8, 2, 'qrc:/Images/images/Image ТЦ/Лужайка.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Авиапарк', 'План', 9, 'Санкт-Петербург', 3297976, 0.1, 3, 'qrc:/Images/images/Image ТЦ/Авиапарк.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Фестиваль', 'Удален', 16, 'Новосибирск', 1828013, 0.2, 4, 'qrc:/Images/images/Image ТЦ/Фестиваль.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Времена Года', 'Реализация', 15, 'Екатеринбург', 2650484, 1.7, 3, 'qrc:/Images/images/Image ТЦ/Времена Года.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Весна', 'Удален', 3, 'Нижний Новгород', 4687701, 0.8, 1, 'qrc:/Images/images/Image ТЦ/Весна.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Гудзон', 'Реализация', 3, 'Екатеринбург', 7414460, 0, 1, 'qrc:/Images/images/Image ТЦ/Гудзон.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Кунцево Плаза', 'Строительство', 8, 'Челябинск', 6797653, 1.1, 2, 'qrc:/Images/images/Image ТЦ/Кунцево Плаза.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Мозаика', 'Строительство', 20, 'Самара', 1429419, 0, 4, 'qrc:/Images/images/Image ТЦ/Мозаика.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Гранд', 'Строительство', 20, 'Ростов-на-Дону ', 2573981, 0.1, 4, 'qrc:/Images/images/Image ТЦ/Гранд.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Шоколад', 'Строительство', 12, 'Челябинск', 2217279, 1.1, 3, 'qrc:/Images/images/Image ТЦ/Шоколад.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Европейский', 'Строительство', 9, 'Москва', 5690500, 0.7, 3, 'qrc:/Images/images/Image ТЦ/Европейский.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Шереметьевский', 'Строительство', 16, 'Новосибирск', 2941379, 1, 4, 'qrc:/Images/images/Image ТЦ/Шереметьевский.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Ашан Сити Капитолий', 'Строительство', 4, 'Екатеринбург', 5309117, 1.9, 1, 'qrc:/Images/images/Image ТЦ/Ашан Сити Капитолий.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Филион', 'Строительство', 8, 'Москва', 5343904, 0.3, 2, 'qrc:/Images/images/Image ТЦ/Филион.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Щука', 'Строительство', 5, 'Нижний Новгород', 5428485, 0.4, 1, 'qrc:/Images/images/Image ТЦ/Щука.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Реутов Парк', 'Строительство', 4, 'Ростов-на-Дону ', 1995904, 1.5, 1, 'qrc:/Images/images/Image ТЦ/Реутов Парк.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Райкин Плаза', 'Строительство', 12, 'Санкт-Петербург', 8498470, 1.8, 3, 'qrc:/Images/images/Image ТЦ/Райкин Плаза.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Красный Кит', 'Строительство', 9, 'Казань', 1912149, 1.1, 3, 'qrc:/Images/images/Image ТЦ/Красный Кит.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Отрада', 'Строительство', 4, 'Санкт-Петербург', 6760316, 0.9, 1, 'qrc:/Images/images/Image ТЦ/Отрада.jpg');
INSERT INTO public.sc (name, sc_status, pavilions_count, city, cost, value_added_coof, floor_count, photo) VALUES ('Армада', 'Реализация', 0, 'Ростов-на-Дону ', 9172489, 0.9, 1, 'qrc:/Images/images/Image ТЦ/Армада.jpg');


--
-- TOC entry 3379 (class 0 OID 16402)
-- Dependencies: 212
-- Data for Name: tenats; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tenats (id, office_name, telephone_number, adress) VALUES (1, 'AG Marine', '+7(495)526-14-53', 'Москва Бабаевская улица д.16');
INSERT INTO public.tenats (id, office_name, telephone_number, adress) VALUES (2, 'Art-elle', '+7(495)250-58-94', 'Санкт-Петербург Амбарная улица д.25 корп.1');
INSERT INTO public.tenats (id, office_name, telephone_number, adress) VALUES (3, 'Atlantis', '+7(495)424-11-65', 'Новосибирск Улица Каменская д.16');
INSERT INTO public.tenats (id, office_name, telephone_number, adress) VALUES (4, 'Corporate Travel', '+7(495)245-39-05', 'Екатеринбург  Улица Антона Валека д.56');
INSERT INTO public.tenats (id, office_name, telephone_number, adress) VALUES (5, 'GallaDance', '+7(495)316-77-94', 'Нижний Новгород Улица Ларина д. 34');


--
-- TOC entry 3232 (class 2606 OID 16401)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 16394)
-- Name: pavilions pavilions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pavilions
    ADD CONSTRAINT pavilions_pkey PRIMARY KEY (pavilion_num, sc_name, city);


--
-- TOC entry 3236 (class 2606 OID 16411)
-- Name: rent rent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rent
    ADD CONSTRAINT rent_pkey PRIMARY KEY (id_rent);


--
-- TOC entry 3228 (class 2606 OID 16389)
-- Name: sc sc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc
    ADD CONSTRAINT sc_pkey PRIMARY KEY (name, city);


--
-- TOC entry 3234 (class 2606 OID 16406)
-- Name: tenats tenats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenats
    ADD CONSTRAINT tenats_pkey PRIMARY KEY (id);


-- Completed on 2024-05-16 20:20:46 MSK

--
-- PostgreSQL database dump complete
--

