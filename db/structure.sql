SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: movies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    length_minutes integer NOT NULL,
    rating character varying(8) NOT NULL,
    CONSTRAINT movies_length_minutes_check CHECK ((length_minutes > 0)),
    CONSTRAINT movies_name_check CHECK ((length((name)::text) > 0)),
    CONSTRAINT movies_rating_check CHECK (((rating)::text = ANY ((ARRAY['Unrated'::character varying, 'G'::character varying, 'PG'::character varying, 'PG-13'::character varying, 'R'::character varying, 'NC-17'::character varying])::text[])))
);


--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: movies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: showtimes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.showtimes (
    id bigint NOT NULL,
    theatre_id bigint,
    movie_id bigint,
    auditorium character varying,
    start_time timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: showtimes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.showtimes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: showtimes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.showtimes_id_seq OWNED BY public.showtimes.id;


--
-- Name: theatres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.theatres (
    id bigint NOT NULL,
    name character varying(256),
    address_line_1 character varying(256),
    address_line_2 character varying(256),
    address_city character varying(128),
    address_state character varying(2),
    address_zip_code character varying(9),
    phone_number character varying(10)
);


--
-- Name: theatres_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.theatres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: theatres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.theatres_id_seq OWNED BY public.theatres.id;


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: showtimes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.showtimes ALTER COLUMN id SET DEFAULT nextval('public.showtimes_id_seq'::regclass);


--
-- Name: theatres id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theatres ALTER COLUMN id SET DEFAULT nextval('public.theatres_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: movies movies_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_name_key UNIQUE (name);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: showtimes showtimes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.showtimes
    ADD CONSTRAINT showtimes_pkey PRIMARY KEY (id);


--
-- Name: theatres theatres_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theatres
    ADD CONSTRAINT theatres_pkey PRIMARY KEY (id);


--
-- Name: index_showtimes_on_movie_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_showtimes_on_movie_id ON public.showtimes USING btree (movie_id);


--
-- Name: index_showtimes_on_theatre_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_showtimes_on_theatre_id ON public.showtimes USING btree (theatre_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200315234751'),
('20200322174323'),
('20200329223810'),
('20200329225049');


