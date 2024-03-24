CREATE TABLE public.cities (
    name character varying(50) NOT NULL,
    province_or_state character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    PRIMARY KEY (name, province_or_state)
);

CREATE TABLE public.donations (
    donor character varying(50) NOT NULL,
    date character varying(50) NOT NULL,
    amount integer NOT NULL,
    PRIMARY KEY (donor, date)
);

CREATE TABLE public.issues (
    name character varying(50) PRIMARY KEY,
    location character varying(50) NOT NULL
);

CREATE TABLE public.members (
    name character varying(50) NOT NULL,
    tier integer,
    number_of_campaigns integer,
    employee_schedule character varying(50),
    salary_amount integer,
    mid integer PRIMARY KEY
);

CREATE TABLE public.campaigns (
    name character varying(50) PRIMARY KEY,
    issue character varying(50) NOT NULL,
    current_cost integer NOT NULL,
    est_total_cost integer NOT NULL,
    lead_organizer_mid integer NOT NULL,
    FOREIGN KEY (issue) REFERENCES public.issues(name),
    FOREIGN KEY (lead_organizer_mid) REFERENCES public.members(mid)
);

CREATE TABLE public.expenses (
    transaction_number integer PRIMARY KEY ,
    use character varying(50) NOT NULL,
    date character varying(50) NOT NULL,
    payee_mid integer,
    campaign character varying(50),
    amount integer NOT NULL,
    FOREIGN KEY (campaign) REFERENCES public.campaigns(name),
    FOREIGN KEY (payee_mid) REFERENCES public.members(mid)
);

CREATE TABLE public.events (
    name character varying(50) PRIMARY KEY,
    campaign character varying(50) NOT NULL,
    date character varying(50) NOT NULL,
    "time" character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    province_or_state character varying(50) NOT NULL,
    address character varying(50) NOT NULL,
    FOREIGN KEY (campaign) REFERENCES public.campaigns(name),
    FOREIGN KEY (city, province_or_state) REFERENCES public.cities(name, province_or_state)
);

CREATE TABLE public.organizers (
    campaign character varying(50) NOT NULL,
    organizer_mid integer NOT NULL,
    FOREIGN KEY (campaign) REFERENCES public.campaigns(name),
    FOREIGN KEY (organizer_mid) REFERENCES public.members(mid)
);

CREATE TABLE public.participants (
    event character varying(50) NOT NULL,
    participant_mid integer NOT NULL,
    FOREIGN KEY (event) REFERENCES public.events(name),
    FOREIGN KEY (participant_mid) REFERENCES public.members(mid)    
);

CREATE TABLE public.website_updates (
    campaign character varying(50) NOT NULL,
    phase integer NOT NULL,
    date character varying(50) NOT NULL,
    PRIMARY KEY (campaign, phase),
    FOREIGN KEY (campaign) REFERENCES public.campaigns(name)
);

INSERT INTO cities (name, province_or_state, country)
VALUES ('Victoria',	'BC',	'Canada');
INSERT INTO cities (name, province_or_state, country)
VALUES ('Vancouver',	'BC',	'Canada');
INSERT INTO cities (name, province_or_state, country)
VALUES ('Nanaimo',	'BC',	'Canada');
INSERT INTO cities (name, province_or_state, country)
VALUES ('Calgary',	'AB',	'Canada');

INSERT INTO donations (donor, date, amount)
VALUES ('Tarence Mcgee',	'Jan 27 2019',	1000);
INSERT INTO donations (donor, date, amount)
VALUES ('Tarence Mcgee',	'Jan 27 2020',	500);
INSERT INTO donations (donor, date, amount)
VALUES ('Tarence Mcgee',	'Jan 28 2020',	1000);
INSERT INTO donations (donor, date, amount)
VALUES ('Tarence Mcgee',	'Jan 29 2020',	100);
INSERT INTO donations (donor, date, amount)
VALUES ('Jared Mac',	'July 08 2023',	170);

INSERT INTO issues(name, location)
VALUES ('Removal of Historical Site', 'Nanaimo BC');
INSERT INTO issues(name, location)
VALUES ('Destruction of Forest',	'Vancouver Island');

INSERT INTO members (name, tier, number_of_campaigns, employee_schedule, salary_amount, mid) 
VALUES ('Hayden Dunstan',	2,	10,	NULL,	NULL,	256);
INSERT INTO members (name, tier, number_of_campaigns, employee_schedule, salary_amount, mid)
VALUES ('Jeff Hewit',	1,	2,	NULL,	NULL,	257);
INSERT INTO members (name, tier, number_of_campaigns, employee_schedule, salary_amount, mid)
VALUES ('Jacob Smith',2,	5,	NULL,	NULL,	258);
INSERT INTO members (name, tier, number_of_campaigns, employee_schedule, salary_amount, mid)
VALUES ('Mack Jack',NULL,	NULL,	'9am-5pm, Monday to Friday', 2000	, 381);
INSERT INTO members (name, tier, number_of_campaigns, employee_schedule, salary_amount, mid)
VALUES ('Steve Lewis',NULL,	NULL,	'9am-5pm, Tuesday to Saturday', 2500	, 291);
INSERT INTO members (name, tier, number_of_campaigns, employee_schedule, salary_amount, mid)
VALUES ('John Doe', NULL,	NULL,	NULL,	NULL,	431);
    
INSERT INTO campaigns (name, issue, current_cost, est_total_cost, lead_organizer_mid)
VALUES ('Save the Vancouver Island Forest',	'Destruction of Forest',	0,	400,	381);
INSERT INTO campaigns (name, issue, current_cost, est_total_cost, lead_organizer_mid)
VALUES ('Save the Neck Point Lookout',	'Removal of Historical Site',	100,	200,	291);

INSERT INTO events (name, campaign, date, time, city, province_or_state, address)
VALUES ('Nanaimo City Hall Protest for Neck Point',	'Save the Neck Point Lookout',	'April 8, 2024',	'2pm',	'Nanaimo',	'BC',	'City Hall');
INSERT INTO events (name, campaign, date, time, city, province_or_state, address)
VALUES ('Neck Point Protest for Neck Point',	'Save the Neck Point Lookout',	'April 12, 2024',	'2pm',	'Nanaimo',	'BC',	'Neck Point Park');
INSERT INTO events (name, campaign, date, time, city, province_or_state, address)
VALUES ('Forest Preserving Protest at BC Parliament',	'Save the Vancouver Island Forest',	'April 27, 2024',	'12pm',	'Victoria',	'BC',	'BC Parliament Building');

INSERT INTO expenses (transaction_number, use, date, payee_mid, campaign, amount)
VALUES (1,	'Mack Jack Salary',	'March 17, 2024',	381,	NULL,	2000);
INSERT INTO expenses (transaction_number, use, date, payee_mid, campaign, amount)
VALUES (2,	'Steve Lewis Salary',	'March 17, 2024',	291,	NULL,	2500);
INSERT INTO expenses (transaction_number, use, date, payee_mid, campaign, amount)
VALUES (3,	'Buy sign boards for protest',	'March 18, 2024',	NULL,	'Save the Neck Point Lookout',	50);
INSERT INTO expenses (transaction_number, use, date, payee_mid, campaign, amount)
VALUES (4,	'Buy supplies sign boards for protest',	'March 18, 2024',	NULL,	'Save the Neck Point Lookout',	50);

INSERT INTO organizers (campaign, organizer_mid)
VALUES ('Save the Neck Point Lookout', 381);
INSERT INTO organizers (campaign, organizer_mid)
VALUES ('Save the Neck Point Lookout', 291);
INSERT INTO organizers (campaign, organizer_mid)
VALUES ('Save the Vancouver Island Forest', 381);
INSERT INTO organizers (campaign, organizer_mid)
VALUES ('Save the Vancouver Island Forest', 291);

INSERT INTO public.participants (event, participant_mid)
VALUES ('Nanaimo City Hall Protest for Neck Point',	256);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Nanaimo City Hall Protest for Neck Point',	257);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Nanaimo City Hall Protest for Neck Point',	258);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Neck Point Protest for Neck Point',	258);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Neck Point Protest for Neck Point',	256);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Neck Point Protest for Neck Point',	431);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Forest Preserving Protest at BC Parliament',	381);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Forest Preserving Protest at BC Parliament',	291);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Forest Preserving Protest at BC Parliament',	257);
INSERT INTO public.participants (event, participant_mid)
VALUES ('Forest Preserving Protest at BC Parliament',	258);

INSERT INTO website_updates (campaign, phase, date)
VALUES ('Save the Vancouver Island Forest',	1	,'March 16, 2024');
INSERT INTO website_updates (campaign, phase, date)
VALUES ('Save the Neck Point Lookout',	1	,'March 20, 2024');
INSERT INTO website_updates (campaign, phase, date)
VALUES ('Save the Neck Point Lookout',	2	,'April 16, 2024');

