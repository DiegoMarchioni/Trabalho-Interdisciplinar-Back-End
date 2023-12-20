-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


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


-- _________________________________________________________
--|                                                         |
--|                     Table Usuario                       |
--|                                                         |
--|_________________________________________________________|


CREATE SEQUENCE public."userId-usuario"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE 
    CACHE 1;


ALTER TABLE public."userId-usuario" OWNER TO ti2cc;

SET default_tablespace = '';

SET default_table_access_method = heap;



CREATE TABLE IF NOT EXISTS public.usuario
(
    userId integer NOT NULL DEFAULT nextval('public."userId-usuario"'::regclass),
    email text NOT NULL,
    login text NOT NULL,
    senha text NOT NULL,
	salt text NOT NULL
);

ALTER TABLE public.usuario OWNER TO ti2cc;


-- _________________________________________________________
--|                                                         |
--|                     Table Planta                        |
--|                                                         |
--|_________________________________________________________|

CREATE SEQUENCE public."plantId-planta"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE 
    CACHE 1;


ALTER TABLE public."plantId-planta" OWNER TO ti2cc;

SET default_tablespace = '';

SET default_table_access_method = heap;



CREATE TABLE IF NOT EXISTS public.planta
(
    plantId integer NOT NULL DEFAULT nextval('public."plantId-planta"'::regclass),
    slug text NOT NULL,
    nomecien text,
    imagemurl text,
    cresc_forma text,
    cresc_taxa text,
    ph_max real,
    ph_min real,
    luz_solar integer,
    solo_nutrientes integer,
    solo_salinidade integer,
    solo_textura integer,
    solo_umidade integer,
    nome_pop text
);

ALTER TABLE public.planta OWNER TO ti2cc;

-- _________________________________________________________
--|                                                         |
--|                     Table Produto                       |
--|                                                         |
--|_________________________________________________________|


CREATE SEQUENCE public."prodId-produto"
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE 
    CACHE 1;


ALTER TABLE public."prodId-produto" OWNER TO ti2cc;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE IF NOT EXISTS public.produto
(
    prodId integer NOT NULL DEFAULT nextval('public."prodId-produto"'::regclass),
    tipo text,
    nome text,
    funcao text,
    preco real,
    produrl text,
	empresa integer
);

ALTER TABLE public.produto OWNER TO ti2cc;

-- _________________________________________________________
--|                                                         |
--|                     Table Agenda                        |
--|                                                         |
--|_________________________________________________________|


CREATE TABLE IF NOT EXISTS public.agenda
(
    planta integer NOT NULL,
    usuario integer NOT NULL,
    datainicio date,
    nome text,
    descricao text,
    rega text,
    poda text,
    exposicao text
);

ALTER TABLE public.agenda OWNER TO ti2cc;



-- _________________________________________________________
--|                                                         |
--|                   Table Rating Prod                     |
--|                                                         |
--|_________________________________________________________|


CREATE TABLE IF NOT EXISTS public.rating
(
    usuario integer NOT NULL, 
    produto integer NOT NULL, 
    rating integer
);

ALTER TABLE public.rating OWNER TO ti2cc;


-- _________________________________________________________
--|                                                         |
--|                     Table Empresa                       |
--|                                                         |
--|_________________________________________________________|


CREATE SEQUENCE public."companyId-empresa"
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE 
    CACHE 1;


ALTER TABLE public."companyId-empresa" OWNER TO ti2cc;

SET default_tablespace = '';

SET default_table_access_method = heap;



CREATE TABLE IF NOT EXISTS public.empresa
(
    companyId integer NOT NULL DEFAULT nextval('public."companyId-empresa"'::regclass),
    email text NOT NULL,
    login text NOT NULL,
    senha text NOT NULL,
	salt text NOT NULL
);

ALTER TABLE public.empresa OWNER TO ti2cc;




-- _________________________________________________________
--|                                                         |
--|                     Primary Keys                        |
--|                                                         |
--|_________________________________________________________|



ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (prodId);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (userId);

ALTER TABLE ONLY public.planta
    ADD CONSTRAINT planta_pkey PRIMARY KEY (plantId);

ALTER TABLE ONLY public.agenda
    ADD CONSTRAINT agenda_pkey PRIMARY KEY (planta,usuario);


ALTER TABLE ONLY public.rating
    ADD CONSTRAINT adicionado_pkey PRIMARY KEY (produto,usuario);

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (companyId);



-- _________________________________________________________
--|                                                         |
--|                     Foreign Keys                        |
--|                                                         |
--|_________________________________________________________|

ALTER TABLE IF EXISTS public.produto
    ADD FOREIGN KEY (empresa)
    REFERENCES public.empresa (companyId) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.agenda
    ADD FOREIGN KEY (planta)
    REFERENCES public.planta (plantId) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.agenda
    ADD FOREIGN KEY (usuario)
    REFERENCES public.usuario (userId) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;




ALTER TABLE IF EXISTS public.rating
    ADD FOREIGN KEY (produto)
    REFERENCES public.produto (prodId) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.rating
    ADD FOREIGN KEY (usuario)
    REFERENCES public.usuario (userId) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;




END;