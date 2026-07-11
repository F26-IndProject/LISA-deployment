--
-- PostgreSQL database dump
--

\restrict W49VL0La7w4XJBGWkeG6uz9LorKdLPMU40biJraA9HXhfBN90Gh4f6EHhrsMLfL

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agent_activities; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_activities (
    id integer NOT NULL,
    agent_id integer,
    activity_type character varying(50),
    activity_data json,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.agent_activities OWNER TO lisa;

--
-- Name: agent_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agent_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agent_activities_id_seq OWNER TO lisa;

--
-- Name: agent_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agent_activities_id_seq OWNED BY public.agent_activities.id;


--
-- Name: agent_builds; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_builds (
    id integer NOT NULL,
    agent_id integer NOT NULL,
    build_config json NOT NULL,
    build_status character varying(50) NOT NULL,
    binary_path text,
    binary_size integer,
    build_log text,
    build_time integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone
);


ALTER TABLE public.agent_builds OWNER TO lisa;

--
-- Name: agent_builds_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agent_builds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agent_builds_id_seq OWNER TO lisa;

--
-- Name: agent_builds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agent_builds_id_seq OWNED BY public.agent_builds.id;


--
-- Name: agent_deleted_crons; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_deleted_crons (
    agent_id character varying NOT NULL,
    job_name character varying NOT NULL
);


ALTER TABLE public.agent_deleted_crons OWNER TO lisa;

--
-- Name: agent_deleted_tasks; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_deleted_tasks (
    id integer NOT NULL,
    agent_id character varying(255) NOT NULL,
    task_name character varying(255) NOT NULL,
    deleted_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.agent_deleted_tasks OWNER TO lisa;

--
-- Name: agent_deleted_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agent_deleted_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agent_deleted_tasks_id_seq OWNER TO lisa;

--
-- Name: agent_deleted_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agent_deleted_tasks_id_seq OWNED BY public.agent_deleted_tasks.id;


--
-- Name: agent_role_definitions; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_role_definitions (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    os_type character varying(100) NOT NULL,
    actions json DEFAULT '{}'::json NOT NULL,
    is_builtin boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT agent_role_definitions_os_type_check CHECK (((os_type)::text = ANY (ARRAY[('windows'::character varying)::text, ('linux'::character varying)::text])))
);


ALTER TABLE public.agent_role_definitions OWNER TO lisa;

--
-- Name: agent_role_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agent_role_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agent_role_definitions_id_seq OWNER TO lisa;

--
-- Name: agent_role_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agent_role_definitions_id_seq OWNED BY public.agent_role_definitions.id;


--
-- Name: agent_schedules; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_schedules (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    work_days json DEFAULT '[1,2,3,4,5]'::json NOT NULL,
    work_start character varying(5) DEFAULT '09:00'::character varying NOT NULL,
    work_end character varying(5) DEFAULT '18:00'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    is_default boolean DEFAULT false
);


ALTER TABLE public.agent_schedules OWNER TO lisa;

--
-- Name: agent_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agent_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agent_schedules_id_seq OWNER TO lisa;

--
-- Name: agent_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agent_schedules_id_seq OWNED BY public.agent_schedules.id;


--
-- Name: agent_update_logs; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agent_update_logs (
    id integer NOT NULL,
    template_id integer NOT NULL,
    user_id text NOT NULL,
    old_version text,
    new_version text,
    update_status character varying(50) NOT NULL,
    update_log text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.agent_update_logs OWNER TO lisa;

--
-- Name: agent_update_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agent_update_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agent_update_logs_id_seq OWNER TO lisa;

--
-- Name: agent_update_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agent_update_logs_id_seq OWNED BY public.agent_update_logs.id;


--
-- Name: agents; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.agents (
    id integer NOT NULL,
    agent_id character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    status character varying(20),
    os_type character varying(100) NOT NULL,
    config json,
    last_seen timestamp without time zone,
    last_activity character varying(255),
    injection_target character varying(200),
    role_id integer,
    template_id integer,
    version_info json,
    build_time integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    agent_role character varying(20) DEFAULT 'user'::character varying,
    agent_schedule_id integer,
    agent_break_id integer,
    activity_interval_min integer,
    activity_interval_max integer
);


ALTER TABLE public.agents OWNER TO lisa;

--
-- Name: agents_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agents_id_seq OWNER TO lisa;

--
-- Name: agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.agents_id_seq OWNED BY public.agents.id;


--
-- Name: applications_template; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.applications_template (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    display_name character varying(150),
    category character varying(50),
    description text,
    version character varying(20),
    author character varying(100),
    template_config json NOT NULL,
    os_type character varying(20) NOT NULL,
    is_active boolean,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.applications_template OWNER TO lisa;

--
-- Name: applications_template_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.applications_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applications_template_id_seq OWNER TO lisa;

--
-- Name: applications_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.applications_template_id_seq OWNED BY public.applications_template.id;


--
-- Name: behavior_templates; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.behavior_templates (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    os_type character varying(20) NOT NULL,
    template_data json NOT NULL,
    is_active boolean,
    role_id integer,
    version character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.behavior_templates OWNER TO lisa;

--
-- Name: behavior_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.behavior_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.behavior_templates_id_seq OWNER TO lisa;

--
-- Name: behavior_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.behavior_templates_id_seq OWNED BY public.behavior_templates.id;


--
-- Name: break_times; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.break_times (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    break_start character varying(5) NOT NULL,
    break_end character varying(5) NOT NULL,
    is_default boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.break_times OWNER TO lisa;

--
-- Name: break_times_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.break_times_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.break_times_id_seq OWNER TO lisa;

--
-- Name: break_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.break_times_id_seq OWNED BY public.break_times.id;


--
-- Name: public_holidays; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.public_holidays (
    id integer NOT NULL,
    date date NOT NULL,
    name character varying(100),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.public_holidays OWNER TO lisa;

--
-- Name: public_holidays_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.public_holidays_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_holidays_id_seq OWNER TO lisa;

--
-- Name: public_holidays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.public_holidays_id_seq OWNED BY public.public_holidays.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    category character varying(50),
    is_active boolean,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.roles OWNER TO lisa;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO lisa;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: lisa
--

CREATE TABLE public.servers (
    id integer NOT NULL,
    name character varying(50),
    description character varying(100),
    ip character varying(20),
    login character varying(50),
    password character varying(50),
    os character varying(15)
);


ALTER TABLE public.servers OWNER TO lisa;

--
-- Name: servers_id_seq; Type: SEQUENCE; Schema: public; Owner: lisa
--

CREATE SEQUENCE public.servers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_id_seq OWNER TO lisa;

--
-- Name: servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lisa
--

ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;


--
-- Name: agent_activities id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_activities ALTER COLUMN id SET DEFAULT nextval('public.agent_activities_id_seq'::regclass);


--
-- Name: agent_builds id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_builds ALTER COLUMN id SET DEFAULT nextval('public.agent_builds_id_seq'::regclass);


--
-- Name: agent_deleted_tasks id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_deleted_tasks ALTER COLUMN id SET DEFAULT nextval('public.agent_deleted_tasks_id_seq'::regclass);


--
-- Name: agent_role_definitions id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_role_definitions ALTER COLUMN id SET DEFAULT nextval('public.agent_role_definitions_id_seq'::regclass);


--
-- Name: agent_schedules id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_schedules ALTER COLUMN id SET DEFAULT nextval('public.agent_schedules_id_seq'::regclass);


--
-- Name: agent_update_logs id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_update_logs ALTER COLUMN id SET DEFAULT nextval('public.agent_update_logs_id_seq'::regclass);


--
-- Name: agents id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents ALTER COLUMN id SET DEFAULT nextval('public.agents_id_seq'::regclass);


--
-- Name: applications_template id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.applications_template ALTER COLUMN id SET DEFAULT nextval('public.applications_template_id_seq'::regclass);


--
-- Name: behavior_templates id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.behavior_templates ALTER COLUMN id SET DEFAULT nextval('public.behavior_templates_id_seq'::regclass);


--
-- Name: break_times id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.break_times ALTER COLUMN id SET DEFAULT nextval('public.break_times_id_seq'::regclass);


--
-- Name: public_holidays id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.public_holidays ALTER COLUMN id SET DEFAULT nextval('public.public_holidays_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: servers id; Type: DEFAULT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);


--
-- Name: agent_activities agent_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_activities
    ADD CONSTRAINT agent_activities_pkey PRIMARY KEY (id);


--
-- Name: agent_builds agent_builds_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_builds
    ADD CONSTRAINT agent_builds_pkey PRIMARY KEY (id);


--
-- Name: agent_deleted_crons agent_deleted_crons_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_deleted_crons
    ADD CONSTRAINT agent_deleted_crons_pkey PRIMARY KEY (agent_id, job_name);


--
-- Name: agent_deleted_tasks agent_deleted_tasks_agent_id_task_name_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_deleted_tasks
    ADD CONSTRAINT agent_deleted_tasks_agent_id_task_name_key UNIQUE (agent_id, task_name);


--
-- Name: agent_deleted_tasks agent_deleted_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_deleted_tasks
    ADD CONSTRAINT agent_deleted_tasks_pkey PRIMARY KEY (id);


--
-- Name: agent_role_definitions agent_role_definitions_name_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_role_definitions
    ADD CONSTRAINT agent_role_definitions_name_key UNIQUE (name);


--
-- Name: agent_role_definitions agent_role_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_role_definitions
    ADD CONSTRAINT agent_role_definitions_pkey PRIMARY KEY (id);


--
-- Name: agent_schedules agent_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_schedules
    ADD CONSTRAINT agent_schedules_pkey PRIMARY KEY (id);


--
-- Name: agent_update_logs agent_update_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_update_logs
    ADD CONSTRAINT agent_update_logs_pkey PRIMARY KEY (id);


--
-- Name: agents agents_agent_id_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_agent_id_key UNIQUE (agent_id);


--
-- Name: agents agents_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);


--
-- Name: applications_template applications_template_name_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.applications_template
    ADD CONSTRAINT applications_template_name_key UNIQUE (name);


--
-- Name: applications_template applications_template_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.applications_template
    ADD CONSTRAINT applications_template_pkey PRIMARY KEY (id);


--
-- Name: behavior_templates behavior_templates_name_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.behavior_templates
    ADD CONSTRAINT behavior_templates_name_key UNIQUE (name);


--
-- Name: behavior_templates behavior_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.behavior_templates
    ADD CONSTRAINT behavior_templates_pkey PRIMARY KEY (id);


--
-- Name: break_times break_times_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.break_times
    ADD CONSTRAINT break_times_pkey PRIMARY KEY (id);


--
-- Name: public_holidays public_holidays_date_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.public_holidays
    ADD CONSTRAINT public_holidays_date_key UNIQUE (date);


--
-- Name: public_holidays public_holidays_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.public_holidays
    ADD CONSTRAINT public_holidays_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: servers servers_pkey; Type: CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: idx_role_definitions_active; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX idx_role_definitions_active ON public.agent_role_definitions USING btree (is_active);


--
-- Name: idx_role_definitions_os_type; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX idx_role_definitions_os_type ON public.agent_role_definitions USING btree (os_type);


--
-- Name: ix_agent_activities_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_agent_activities_id ON public.agent_activities USING btree (id);


--
-- Name: ix_agent_builds_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_agent_builds_id ON public.agent_builds USING btree (id);


--
-- Name: ix_agent_update_logs_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_agent_update_logs_id ON public.agent_update_logs USING btree (id);


--
-- Name: ix_agents_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_agents_id ON public.agents USING btree (id);


--
-- Name: ix_applications_template_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_applications_template_id ON public.applications_template USING btree (id);


--
-- Name: ix_behavior_templates_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_behavior_templates_id ON public.behavior_templates USING btree (id);


--
-- Name: ix_roles_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_roles_id ON public.roles USING btree (id);


--
-- Name: ix_servers_id; Type: INDEX; Schema: public; Owner: lisa
--

CREATE INDEX ix_servers_id ON public.servers USING btree (id);


--
-- Name: agent_activities agent_activities_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_activities
    ADD CONSTRAINT agent_activities_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id);


--
-- Name: agent_builds agent_builds_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agent_builds
    ADD CONSTRAINT agent_builds_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agents agents_agent_break_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_agent_break_id_fkey FOREIGN KEY (agent_break_id) REFERENCES public.break_times(id) ON DELETE SET NULL;


--
-- Name: agents agents_agent_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_agent_schedule_id_fkey FOREIGN KEY (agent_schedule_id) REFERENCES public.agent_schedules(id) ON DELETE SET NULL;


--
-- Name: agents agents_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: agents agents_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.behavior_templates(id);


--
-- Name: behavior_templates behavior_templates_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lisa
--

ALTER TABLE ONLY public.behavior_templates
    ADD CONSTRAINT behavior_templates_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict W49VL0La7w4XJBGWkeG6uz9LorKdLPMU40biJraA9HXhfBN90Gh4f6EHhrsMLfL

