--
-- PostgreSQL database dump
--

\restrict pfKKcOKyrNjwdWIJqh0zXawoos56JWc5VKLymCwSKpSZtB8VLaTRalCi4PIrhKW

-- Dumped from database version 15.18
-- Dumped by pg_dump version 15.18

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
-- Data for Name: agent_schedules; Type: TABLE DATA; Schema: public; Owner: lisa
--

COPY public.agent_schedules (id, name, work_days, work_start, work_end, created_at, updated_at, is_default) FROM stdin;
7	Standard Office Hours	[1,2,3,4,5]	09:00	18:00	2026-06-04 22:29:14.305823	2026-06-04 22:29:14.305823	t
8	Night Shift	[1, 2, 3, 4, 5]	22:00	06:00	2026-06-04 22:29:14.305823	2026-06-04 22:31:32.914791	t
10	Non- Stop Work	[1, 2, 3, 4, 5, 6, 7]	00:00	23:59	2026-06-06 20:27:47.558319	2026-06-06 20:27:47.558319	f
\.


--
-- Data for Name: break_times; Type: TABLE DATA; Schema: public; Owner: lisa
--

COPY public.break_times (id, name, break_start, break_end, is_default, created_at) FROM stdin;
1	Lunch Break	12:00	13:00	t	2026-06-06 19:54:58.896609
2	Night Break	02:00	03:00	t	2026-06-06 19:54:58.896609
6	Non-stop work break	12:00	12:05	f	2026-06-07 08:55:49.861281
\.


--
-- Data for Name: public_holidays; Type: TABLE DATA; Schema: public; Owner: lisa
--

COPY public.public_holidays (id, date, name, created_at) FROM stdin;
\.


--
-- Name: agent_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa
--

SELECT pg_catalog.setval('public.agent_schedules_id_seq', 12, true);


--
-- Name: break_times_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa
--

SELECT pg_catalog.setval('public.break_times_id_seq', 7, true);


--
-- Name: public_holidays_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lisa
--

SELECT pg_catalog.setval('public.public_holidays_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

\unrestrict pfKKcOKyrNjwdWIJqh0zXawoos56JWc5VKLymCwSKpSZtB8VLaTRalCi4PIrhKW

