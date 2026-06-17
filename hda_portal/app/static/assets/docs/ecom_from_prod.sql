- SEQUENCE: public.attr_id_seq

-- DROP SEQUENCE IF EXISTS public.attr_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.attr_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.attr_id_seq
    OWNER TO hsio;

-- Table: public.attribute

-- DROP TABLE IF EXISTS public.attribute;

CREATE TABLE attribute
(
    attr_id  SERIAL PRIMARY KEY ,
    attr_name character varying(25) COLLATE pg_catalog."default",
    attr_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT attribute_pkey PRIMARY KEY (attr_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.attribute
    OWNER to hsio;
-- SEQUENCE: public.cust_id_seq

-- DROP SEQUENCE IF EXISTS public.cust_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.cust_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.cust_id_seq
    OWNER TO hsio;
-- Table: public.customer
-- cust_type
-- 1  =  retail
-- 2  =  wholesale
-- 3  =  customer
-- 4  =  internal
-- 5  =  prospect
-- 6  =  vendor
-- 7  =  vendor/customer

-- DROP TABLE IF EXISTS public.customer;

CREATE TABLE customer
(
    cust_id serial primary key,
    cust_type integer DEFAULT 1,
    cust_name character varying(40) COLLATE pg_catalog."default",
    cust_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean,
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.customer
    OWNER to hsio;

-- SEQUENCE: public.cust_attr_id_seq

-- DROP SEQUENCE IF EXISTS public.cust_attr_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.cust_attr_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.cust_attr_id_seq
    OWNER TO hsio;

-- Table: public.cust_attr

-- DROP TABLE IF EXISTS public.cust_attr;

CREATE TABLE cust_attr
(
    cust_attr_id integer NOT NULL DEFAULT nextval('cust_attr_id_seq'::regclass),
    attr_id integer,
    cust_id integer,
    cust_attr_value character varying(100) COLLATE pg_catalog."default",
    cust_attr_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cust_attr_pkey PRIMARY KEY (cust_attr_id)
)
TABLESPACE pg_default;

-- SEQUENCE: public.contact_id_seq

-- DROP SEQUENCE IF EXISTS public.contact_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.contact_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.contact_id_seq
    OWNER TO hsio;

-- Table: public.contact

DROP TABLE IF EXISTS public.contact;

drop table contact

CREATE TABLE contact
(
    --contact_id integer NOT NULL DEFAULT nextval('contact_id_seq'::regclass),
    contact_id SERIAL PRIMARY KEY ,
    cust_id integer references customer(cust_id),
    fname character varying(30) COLLATE pg_catalog."default",	
    lname character varying(30) COLLATE pg_catalog."default",
    phone character varying(30) COLLATE pg_catalog."default",
    email character varying(30) COLLATE pg_catalog."default",
    contact_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP	
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contact
    OWNER to hsio;

-- SEQUENCE: public.address_id_seq

-- DROP SEQUENCE IF EXISTS public.address_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.address_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.address_id_seq
    OWNER TO hsio;

-- Table: public.address

-- DROP TABLE IF EXISTS public.address;


CREATE TABLE public.address
(
    address_id SERIAL PRIMARY KEY, 
    cust_id integer references customer(cust_id),
    contact_id integer references contact(contact_id) default 1,
    attr_id integer references attribute(attr_id),
    address_attr_value character varying(30) COLLATE pg_catalog."default",
    street_address character varying(50) COLLATE pg_catalog."default",
    city character varying(20) COLLATE pg_catalog."default",
    province character varying(20) COLLATE pg_catalog."default",
    country character varying(20) COLLATE pg_catalog."default",
    zipcode character varying(20) COLLATE pg_catalog."default",
    crdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.address
    OWNER to hsio;

-- SEQUENCE: public.product_id_seq

-- DROP SEQUENCE IF EXISTS public.product_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.product_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.product_id_seq
    OWNER TO h		sio;

- Table: public.product

-- DROP TABLE IF EXISTS public.product;

CREATE TABLE  public.product
(
    product_id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass),
    product_name character varying(50) COLLATE pg_catalog."default",
    product_status smallint DEFAULT 1,
    product_desc character varying(200) COLLATE pg_catalog."default",
    product_price numeric(6,2),
    product_msg character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT product_pkey PRIMARY KEY (product_id)
)
TABLESPACE pg_default;
-- product_status   
-- 1  = available
-- 15 = available and discounted 15%.
-- 2  = back ordered
-- 4  = discontinued

ALTER TABLE IF EXISTS public.product
    OWNER to hsio;


-- SEQUENCE: public.product_attr_seq

-- DROP SEQUENCE IF EXISTS public.product_attr_seq;

CREATE SEQUENCE IF NOT EXISTS public.product_attr_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.product_attr_seq
    OWNER TO hsio;

-- Table: public.product_attr

 DROP TABLE IF EXISTS public.product_attr;

CREATE TABLE public.product_attr
(
    product_attr_id SERIAL PRIMARY KEY,
    product_id integer references product(product_id),
    attr_id integer references attribute(attr_id),
    product_attr_value character varying(50) COLLATE pg_catalog."default",
    product_attr_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP 
    
 )
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.product_attr
    OWNER to hsio;

-- SEQUENCE: public.product_inv_id_seq

-- DROP SEQUENCE IF EXISTS public.product_inv_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.product_inv_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.product_inv_id_seq
    OWNER TO hsio;

-- Table: public.product_inv

-- DROP TABLE IF EXISTS public.product_inv;

CREATE TABLE public.product_inv
(
    product_inv_id integer NOT NULL DEFAULT nextval('product_inv_id_seq'::regclass),
    product_id integer,
    cust_id integer,
    qnty integer DEFAULT 1,
    location character varying(10) COLLATE pg_catalog."default" DEFAULT 'warehouse'::character varying,
    serial_number character varying(30) COLLATE pg_catalog."default" DEFAULT 99999,
    CONSTRAINT product_inv_pkey PRIMARY KEY (product_inv_id),
    CONSTRAINT product_inv_cust_id_fkey FOREIGN KEY (cust_id)
        REFERENCES public.customer (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_inv_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_inv
    OWNER to hsio;
-- SEQUENCE: public.order_id_seq

-- DROP SEQUENCE IF EXISTS public.order_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.order_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.order_id_seq
    OWNER TO hsio;

-- Table: public.s_order

-- DROP TABLE IF EXISTS public.s_order;

CREATE TABLE public.s_order
(
    order_id integer primary key,
    cust_id integer references customer(cust_id),
    order_date date DEFAULT CURRENT_DATE,
    total real,
    payment_method character varying(10) COLLATE pg_catalog."default",
    payment_term integer,
    due_date date,
    delivery_method integer references attribute(attr_id)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.s_order
    OWNER to hsio;

-- SEQUENCE: public.sorder_detail_id_seq

-- DROP SEQUENCE IF EXISTS public.sorder_detail_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.sorder_detail_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.sorder_detail_id_seq
    OWNER TO hsio;

-- Table: public.s_order_detail

-- DROP TABLE IF EXISTS public.s_order_detail;

CREATE TABLE public.s_order_detail
(
    sorder_detail_id integer primary key,
    order_id integer references s_order(order_id),
    product_id integer references product(product_id),
    qnty integer DEFAULT 1,
    location character varying(10) COLLATE pg_catalog."default" DEFAULT 'warehouse'::character varying,
    serial_number character varying(30) COLLATE pg_catalog."default" DEFAULT 99999
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.s_order_detail
    OWNER to hsio;

-- SEQUENCE: public.ticket_number_seq

-- DROP SEQUENCE IF EXISTS public.ticket_number_seq;

CREATE SEQUENCE IF NOT EXISTS public.ticket_number_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.ticket_number_seq
    OWNER TO hsio;

-- Table: public.ticket

-- DROP TABLE IF EXISTS public.ticket;

CREATE TABLE ticket
(
    ticket_number serial primary key,
    cust_id integer references customer(cust_id),
    product_id integer references product(product_id),
    crdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ticket_desc text COLLATE pg_catalog."default",
    ticket_owner varchar(20) COLLATE pg_catalog."default",
    contact_id integer,
    priority smallint,
    status varchar(10) COLLATE pg_catalog."default"
)
TABLESPACE pg_default;
alter table ticket add constraint ticket_priority check (priority in (1,2,3,4));
ALTER TABLE IF EXISTS public.ticket
    OWNER to hsio;

-- SEQUENCE: public.ticket_number_seq

-- DROP SEQUENCE IF EXISTS public.ticket_number_seq;

CREATE SEQUENCE IF NOT EXISTS public.ticket_number_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.ticket_number_seq
    OWNER TO hsio;

-- Table: public.ticket_detail

-- DROP TABLE IF EXISTS public.ticket_detail;

CREATE TABLE ticket_detail
(
    ticket_detail_id serial primary key,
    ticket_number integer references ticket(ticket_number),
    contact_media character varying(6) COLLATE pg_catalog."default",
    contact_date date,
    contact_id integer,
    conversation text COLLATE pg_catalog."default"
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.ticket_detail
    OWNER to hsio;


