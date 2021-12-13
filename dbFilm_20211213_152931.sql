--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.0

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
-- Name: dbFilm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "dbFilm" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';


ALTER DATABASE "dbFilm" OWNER TO postgres;

\connect "dbFilm"

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
-- Name: artir(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.artir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE "toplamFilm" set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.artir() OWNER TO postgres;

--
-- Name: azalt(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.azalt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE "azalanFilm" set sayi=sayi-1;
return new;
end;
$$;


ALTER FUNCTION public.azalt() OWNER TO postgres;

--
-- Name: filmgetir(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.filmgetir(harf character varying) RETURNS TABLE(idsutun integer, adsutun character varying, tarihsutun date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
    film_id,
    film_ad,
    film_tarih
FROM
    film
WHERE
    film_ad LIKE harf;
END;
$$;


ALTER FUNCTION public.filmgetir(harf character varying) OWNER TO postgres;

--
-- Name: karaktertopla(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.karaktertopla() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
uzunluk integer;
BEGIN
uzunluk:=(SELECT length(film_ad) from film order by film_id desc limit 1);
update "toplamKarakter" set sayi=sayi+uzunluk;
return new;
end;
$$;


ALTER FUNCTION public.karaktertopla() OWNER TO postgres;

--
-- Name: karhesapla(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.karhesapla(butce bigint, gelir bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$ 
DECLARE
sonuc BIGINT;
BEGIN
sonuc:= gelir- butce;
RETURN sonuc;
end;
$$;


ALTER FUNCTION public.karhesapla(butce bigint, gelir bigint) OWNER TO postgres;

--
-- Name: oygetir(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.oygetir(oy double precision) RETURNS TABLE(idsutun integer, adsutun character varying, oysutun double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
    film_id,
    film_ad,
    film_oy
FROM
    film
WHERE
    film_oy > oy;
END;
$$;


ALTER FUNCTION public.oygetir(oy double precision) OWNER TO postgres;

--
-- Name: puantopla(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.puantopla() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
puan float;
BEGIN
puan:=(SELECT film_oy from film order by film_id desc limit 1);
update "puanTopla" set sayi=sayi+puan;
return new;
end;
$$;


ALTER FUNCTION public.puantopla() OWNER TO postgres;

--
-- Name: tarihgetir(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tarihgetir(tarih date) RETURNS TABLE(idsutun integer, adsutun character varying, tarihsutun date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
    film_id,
    film_ad,
    film_tarih
FROM
    film
WHERE
    film_tarih >= tarih;
END;
$$;


ALTER FUNCTION public.tarihgetir(tarih date) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: anahtar_kelime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anahtar_kelime (
    akelime_id integer NOT NULL,
    akelime_ad text NOT NULL
);


ALTER TABLE public.anahtar_kelime OWNER TO postgres;

--
-- Name: azalanFilm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."azalanFilm" (
    sayi integer NOT NULL
);


ALTER TABLE public."azalanFilm" OWNER TO postgres;

--
-- Name: cinsiyet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cinsiyet (
    cinsiyet_id integer NOT NULL,
    cinsiyet_ad character varying(6) NOT NULL
);


ALTER TABLE public.cinsiyet OWNER TO postgres;

--
-- Name: departman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departman (
    departman_id integer NOT NULL,
    departman_ad text NOT NULL
);


ALTER TABLE public.departman OWNER TO postgres;

--
-- Name: dil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dil (
    dil_id integer NOT NULL,
    dil_ad character varying(50) NOT NULL
);


ALTER TABLE public.dil OWNER TO postgres;

--
-- Name: dil_rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dil_rol (
    rol_id integer NOT NULL,
    dil_rolu character varying(10) NOT NULL
);


ALTER TABLE public.dil_rol OWNER TO postgres;

--
-- Name: film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film (
    film_id integer NOT NULL,
    film_ad character varying(50) NOT NULL,
    film_butce bigint NOT NULL,
    film_gelir bigint NOT NULL,
    film_tarih date NOT NULL,
    film_oy double precision NOT NULL
);


ALTER TABLE public.film OWNER TO postgres;

--
-- Name: film_akelime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_akelime (
    "FKfilm_id" integer NOT NULL,
    "FKakelime_id" integer NOT NULL
);


ALTER TABLE public.film_akelime OWNER TO postgres;

--
-- Name: film_dil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_dil (
    "FKfilm_id" integer NOT NULL,
    "FKdil_id" integer NOT NULL,
    "FKdilrol_id" integer NOT NULL
);


ALTER TABLE public.film_dil OWNER TO postgres;

--
-- Name: film_ekip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_ekip (
    "FKkisi_id" integer NOT NULL,
    "FKfilm_id" integer NOT NULL,
    "FKdep_id" integer NOT NULL
);


ALTER TABLE public.film_ekip OWNER TO postgres;

--
-- Name: film_kadro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_kadro (
    "FKfilm_id" integer NOT NULL,
    "FKcins_id" integer NOT NULL,
    "FKkisi_id" integer NOT NULL
);


ALTER TABLE public.film_kadro OWNER TO postgres;

--
-- Name: film_sirket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_sirket (
    "FKfilm_id" integer NOT NULL,
    "FKsirket_id" integer NOT NULL
);


ALTER TABLE public.film_sirket OWNER TO postgres;

--
-- Name: film_tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_tur (
    "FKfilm_id" integer NOT NULL,
    "FKtur_id" integer NOT NULL
);


ALTER TABLE public.film_tur OWNER TO postgres;

--
-- Name: film_ulke; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_ulke (
    "FKfilm_id" integer NOT NULL,
    "FKulke_id" integer NOT NULL
);


ALTER TABLE public.film_ulke OWNER TO postgres;

--
-- Name: kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kisi (
    kisi_id integer NOT NULL,
    kisi_ad text NOT NULL
);


ALTER TABLE public.kisi OWNER TO postgres;

--
-- Name: puanTopla; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."puanTopla" (
    sayi double precision NOT NULL
);


ALTER TABLE public."puanTopla" OWNER TO postgres;

--
-- Name: sirket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sirket (
    sirket_id integer NOT NULL,
    sirket_ad text NOT NULL
);


ALTER TABLE public.sirket OWNER TO postgres;

--
-- Name: toplamFilm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."toplamFilm" (
    sayi integer NOT NULL
);


ALTER TABLE public."toplamFilm" OWNER TO postgres;

--
-- Name: toplamKarakter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."toplamKarakter" (
    sayi integer NOT NULL
);


ALTER TABLE public."toplamKarakter" OWNER TO postgres;

--
-- Name: tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tur (
    tur_id integer NOT NULL,
    tur_ad character varying(30) NOT NULL
);


ALTER TABLE public.tur OWNER TO postgres;

--
-- Name: ulke; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ulke (
    ulke_id integer NOT NULL,
    ulke_ad character varying(60) NOT NULL
);


ALTER TABLE public.ulke OWNER TO postgres;

--
-- Data for Name: anahtar_kelime; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.anahtar_kelime VALUES
	(1, 'Telefon'),
	(2, 'Fotograf'),
	(3, 'Arkadas'),
	(4, 'Olum'),
	(5, 'Aglamak'),
	(6, 'Kan'),
	(7, 'Ozur'),
	(8, 'Patlama');


--
-- Data for Name: azalanFilm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."azalanFilm" VALUES
	(14);


--
-- Data for Name: cinsiyet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cinsiyet VALUES
	(1, 'Erkek'),
	(2, 'Kadin'),
	(3, 'Diger');


--
-- Data for Name: departman; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departman VALUES
	(1, 'Yurutme Departmani'),
	(2, 'Yonetmen'),
	(3, 'Yapımcı'),
	(4, 'Sanat Departmani'),
	(5, 'Kamera Departmani'),
	(6, 'Elektrik Departmani'),
	(7, 'Ses Departmani'),
	(8, 'Dublor Departmani');


--
-- Data for Name: dil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dil VALUES
	(1, 'Ingilizce'),
	(2, 'Cince'),
	(3, 'Hindistanca'),
	(4, 'Ispanyolca'),
	(5, 'Fransizca'),
	(6, 'Arapca'),
	(7, 'Rusca'),
	(8, 'Portekizce');


--
-- Data for Name: dil_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dil_rol VALUES
	(1, 'Orijinal'),
	(2, 'Konusulan');


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film VALUES
	(1, 'Avatar', 237000000, 2787965087, '2009-12-10', 7.2),
	(2, 'Titanic', 200000000, 1845034188, '1997-11-18', 7.5),
	(3, 'The Avengers', 220000000, 1519557910, '2012-04-25', 7.4),
	(4, 'Jurassic World', 150000000, 1513528810, '2015-06-09', 6.5),
	(5, 'Furious 7', 190000000, 1506249360, '2015-04-01', 7.3),
	(6, 'The Hobbit: An Unexpected Journey', 250000000, 1021103568, '2012-11-26', 7),
	(7, 'Alice in Wonderland', 200000000, 1025491110, '2010-03-03', 6.4),
	(8, 'Pirates of the Caribbean: Dead Man’s Chest', 200000000, 1065659812, '2006-06-20', 7),
	(9, 'The Dark Knight Rises', 250000000, 1084939099, '2012-07-16', 7.6),
	(10, 'Toy Story 3', 200000000, 1066969703, '2010-06-16', 7.6),
	(11, 'Skyfall', 200000000, 1108561013, '2012-10-25', 6.9),
	(12, 'Frozen', 150000000, 1274219009, '2013-11-27', 7.3);


--
-- Data for Name: film_akelime; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: film_dil; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: film_ekip; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: film_kadro; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: film_sirket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: film_tur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: film_ulke; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kisi VALUES
	(1, 'Sam Worthington'),
	(2, 'James Cameron'),
	(3, 'Kevin Feige'),
	(4, 'Charles Roven'),
	(5, 'Jerry Bruckheimer'),
	(6, 'Christopher Nolan'),
	(7, 'Neal Moritz'),
	(8, 'Frank Marshall'),
	(9, 'Christian Bale'),
	(10, 'Paul Walker'),
	(11, 'Chris Evans'),
	(12, 'Martin Freeman');


--
-- Data for Name: puanTopla; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."puanTopla" VALUES
	(270.2);


--
-- Data for Name: sirket; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sirket VALUES
	(1, 'Warner Bros'),
	(2, 'Sony Pictures'),
	(3, 'Walt Disney'),
	(4, 'Universal Pictures'),
	(5, '20th Century Fox'),
	(6, 'Paramount Pictures'),
	(7, 'Lionsgate'),
	(8, 'The Weinstein'),
	(9, 'Metro-Goldwyn-Mayer'),
	(10, 'DreamWorks');


--
-- Data for Name: toplamFilm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."toplamFilm" VALUES
	(12);


--
-- Data for Name: toplamKarakter; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."toplamKarakter" VALUES
	(270);


--
-- Data for Name: tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tur VALUES
	(1, 'Dram'),
	(2, 'Komedi'),
	(3, 'Aksiyon'),
	(4, 'Bilim-Kurgu'),
	(5, 'Korku'),
	(6, 'Romantik'),
	(7, 'Gerilim');


--
-- Data for Name: ulke; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ulke VALUES
	(1, 'Fransa'),
	(2, 'Ispanya'),
	(3, 'ABD'),
	(4, 'Cin'),
	(5, 'Italya'),
	(6, 'Turkiye'),
	(7, 'Meksika'),
	(8, 'Almanya'),
	(9, 'Japonya'),
	(10, 'Hindistan');


--
-- Name: anahtar_kelime anahtar_kelime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anahtar_kelime
    ADD CONSTRAINT anahtar_kelime_pkey PRIMARY KEY (akelime_id);


--
-- Name: cinsiyet cinsiyet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cinsiyet
    ADD CONSTRAINT cinsiyet_pkey PRIMARY KEY (cinsiyet_id);


--
-- Name: departman departman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departman
    ADD CONSTRAINT departman_pkey PRIMARY KEY (departman_id);


--
-- Name: dil dil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dil
    ADD CONSTRAINT dil_pkey PRIMARY KEY (dil_id);


--
-- Name: dil_rol dil_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dil_rol
    ADD CONSTRAINT dil_rol_pkey PRIMARY KEY (rol_id);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


--
-- Name: kisi kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT kisi_pkey PRIMARY KEY (kisi_id);


--
-- Name: sirket sirket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sirket
    ADD CONSTRAINT sirket_pkey PRIMARY KEY (sirket_id);


--
-- Name: tur tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT tur_pkey PRIMARY KEY (tur_id);


--
-- Name: ulke ulke_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ulke
    ADD CONSTRAINT ulke_pkey PRIMARY KEY (ulke_id);


--
-- Name: film artirtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER artirtrig AFTER INSERT ON public.film FOR EACH ROW EXECUTE FUNCTION public.artir();


--
-- Name: film azalttrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER azalttrig AFTER DELETE ON public.film FOR EACH ROW EXECUTE FUNCTION public.azalt();


--
-- Name: film karaktertoplatrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER karaktertoplatrig AFTER INSERT ON public.film FOR EACH ROW EXECUTE FUNCTION public.karaktertopla();


--
-- Name: film puantoplatrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER puantoplatrig AFTER INSERT ON public.film FOR EACH ROW EXECUTE FUNCTION public.puantopla();


--
-- Name: film_akelime film_akelime; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_akelime
    ADD CONSTRAINT film_akelime FOREIGN KEY ("FKakelime_id") REFERENCES public.anahtar_kelime(akelime_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_akelime film_akelime2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_akelime
    ADD CONSTRAINT film_akelime2 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_dil film_dil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_dil
    ADD CONSTRAINT film_dil FOREIGN KEY ("FKdil_id") REFERENCES public.dil(dil_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_dil film_dil2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_dil
    ADD CONSTRAINT film_dil2 FOREIGN KEY ("FKdilrol_id") REFERENCES public.dil_rol(rol_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_dil film_dil3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_dil
    ADD CONSTRAINT film_dil3 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_ekip film_ekip; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_ekip
    ADD CONSTRAINT film_ekip FOREIGN KEY ("FKdep_id") REFERENCES public.departman(departman_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_ekip film_ekip2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_ekip
    ADD CONSTRAINT film_ekip2 FOREIGN KEY ("FKkisi_id") REFERENCES public.kisi(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_ekip film_ekip3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_ekip
    ADD CONSTRAINT film_ekip3 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_kadro film_kadro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_kadro
    ADD CONSTRAINT film_kadro FOREIGN KEY ("FKcins_id") REFERENCES public.cinsiyet(cinsiyet_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_kadro film_kadro2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_kadro
    ADD CONSTRAINT film_kadro2 FOREIGN KEY ("FKkisi_id") REFERENCES public.kisi(kisi_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_kadro film_kadro3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_kadro
    ADD CONSTRAINT film_kadro3 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_sirket film_sirket; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_sirket
    ADD CONSTRAINT film_sirket FOREIGN KEY ("FKsirket_id") REFERENCES public.sirket(sirket_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_sirket film_sirket2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_sirket
    ADD CONSTRAINT film_sirket2 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_tur film_tur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_tur
    ADD CONSTRAINT film_tur FOREIGN KEY ("FKtur_id") REFERENCES public.tur(tur_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_tur film_tur2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_tur
    ADD CONSTRAINT film_tur2 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_ulke film_ulke; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_ulke
    ADD CONSTRAINT film_ulke FOREIGN KEY ("FKulke_id") REFERENCES public.ulke(ulke_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: film_ulke film_ulke2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_ulke
    ADD CONSTRAINT film_ulke2 FOREIGN KEY ("FKfilm_id") REFERENCES public.film(film_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

