--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: Abdellah
--

CREATE TABLE public.projects (
    title character varying,
    volunteer_id integer,
    id integer NOT NULL
);


ALTER TABLE public.projects OWNER TO "Abdellah";

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: Abdellah
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO "Abdellah";

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Abdellah
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: Abdellah
--

CREATE TABLE public.volunteers (
    name character varying,
    project_id integer,
    id integer NOT NULL
);


ALTER TABLE public.volunteers OWNER TO "Abdellah";

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: Abdellah
--

CREATE SEQUENCE public.volunteers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_id_seq OWNER TO "Abdellah";

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Abdellah
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.id;


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: Abdellah
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: Abdellah
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: Abdellah
--

COPY public.projects (title, volunteer_id, id) FROM stdin;
abc	\N	164
abc	\N	165
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: Abdellah
--

COPY public.volunteers (name, project_id, id) FROM stdin;
bobo	160	73
bobb	160	74
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Abdellah
--

SELECT pg_catalog.setval('public.projects_id_seq', 165, true);


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Abdellah
--

SELECT pg_catalog.setval('public.volunteers_id_seq', 74, true);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: Abdellah
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: Abdellah
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

