CREATE OR REPLACE PROCEDURE insert_customer(
        custType INTEGER, 
        custName TEXT


)
LANGUAGE plpgsql
AS $$
BEGIN
        INSERT INTO customer(cust_type, cust_name)
        VALUES (custType, custName);
        COMMIT;
END;
$$;

--calling insert_customer to insert cust_type of 4 and customer name is 'Hyperscale IO'
call insert_customer(4, 'Hyperscale IO')

--ecom=# select * from customer;
-- cust_id | cust_type |   cust_name   |         cust_date          | is_deleted 
-----------+-----------+---------------+----------------------------+------------
--     101 |         1 | retail        | 2026-04-23 16:09:11.756814 | 
--     102 |         2 | wholesale     | 2026-04-23 16:09:39.823262 | 
--     103 |         4 | internal      | 2026-04-23 16:09:57.183349 | 
--     104 |         4 | Hyperscale IO | 2026-04-23 18:04:47.098394 | 

CREATE OR REPLACE PROCEDURE public.insert_contact(
        IN fname text,
        IN lname text,
        IN phone text,
        IN email text,
        IN custId integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

        INSERT INTO contact(fname, lname, phone, email,cust_id)
        VALUES (fname, lname, phone, email,custId);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_contact(text, text, text, text,integer)
    OWNER TO hsio;

-- manual insert 
-- cust_id 104 is hyperscale IO
insert into contact(fname,lname,phone,email,cust_id) values('brady','chang','777-234-3987',
'bradycychang@gmail.com',104);

--calling insert_contact into customer hyperscale io cust_id 104  
call insert_contact('casper','chang','888-999-8888','casperchang@gmail.com',104);

select * from contact
----------------------------------------------------------------------------------------------------
101	"brady"	"chang"	"777-234-3987"	"bradycychang@gmail.com"	"2026-04-23 18:41:35.223668"
102	"casper"	"chang"	"888-999-8888"	"casperchang@gmail.com"	"2026-04-23 18:42:22.578325"`

CREATE OR REPLACE PROCEDURE insert_address(
        custId integer,
        contactId integer,
        attrId TEXT,
        addressAttrValue  varchar(20),
        streetAddress varchar(50),
        city varchar(20),
        province varchar(20),
        country varchar(20),
        zipcode varchar(20)
)
LANGUAGE plpgsql
AS $$
BEGIN

        INSERT INTO contact(cust_id, contact_id, attr_id, address_attr_value, street_address, city, province, country, zipcode)
        VALUES (custId, contactId, attrId, addressAttrValue, streetAddress,city,province,country, zipcode);
        COMMIT;
END;
$$;

-- PROCEDURE: public.insert_address(integer, integer, text, character varying, character varying, character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS public.insert_address(integer, integer, text, character varying, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.insert_address(
	IN custid integer,
	IN contactid integer,
	IN attrid text,
	IN addressattrvalue character varying,
	IN streetaddress character varying,
	IN city character varying,
	IN province character varying,
	IN country character varying,
	IN zipcode character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

        INSERT INTO contact(cust_id, contact_id, attr_id, address_attr_value, street_address, city, province, country, zipcode)
        VALUES (custId, contactId, attrId, addressAttrValue, streetAddress,city,province,country, zipcode);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_address(integer, integer, text, character varying, character varying, character varying, character varying, character varying, character varying)
    OWNER TO hyperscaleios;

-- PROCEDURE: public.insert_contact(text, text, text, text, integer)

-- DROP PROCEDURE IF EXISTS public.insert_contact(text, text, text, text, integer);

CREATE OR REPLACE PROCEDURE public.insert_contact(
	IN fname text,
	IN lname text,
	IN phone text,
	IN email text,
	IN custid integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

        INSERT INTO contact(fname, lname, phone, email,cust_id)
        VALUES (fname, lname, phone, email,custId);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_contact(text, text, text, text, integer)
    OWNER TO hsio;

-- PROCEDURE: public.insert_customer(integer, text)

-- DROP PROCEDURE IF EXISTS public.insert_customer(integer, text);

CREATE OR REPLACE PROCEDURE public.insert_customer(
	IN custtype integer,
	IN custname text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
        INSERT INTO customer(cust_type, cust_name)
        VALUES (custType, custName);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_customer(integer, text)
    OWNER TO hyperscaleios;

-- PROCEDURE: public.insert_product(character varying, character varying, numeric, character varying)

-- DROP PROCEDURE IF EXISTS public.insert_product(character varying, character varying, numeric, character varying);

CREATE OR REPLACE PROCEDURE public.insert_product(
	IN productname character varying,
	IN productdesc character varying,
	IN productprice numeric,
	IN productmsg character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	   INSERT INTO product( product_name,product_desc, product_price, product_msg)
        VALUES (productName, productDesc, productPrice, productMsg);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_product(character varying, character varying, numeric, character varying)
    OWNER TO hyperscaleios;

-- PROCEDURE: public.insert_product_attr(integer, integer, character varying)

-- DROP PROCEDURE IF EXISTS public.insert_product_attr(integer, integer, character varying);

CREATE OR REPLACE PROCEDURE public.insert_product_attr(
	IN productid integer,
	IN attrid integer,
	IN productattrvalue character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

        INSERT INTO product_attr( product_id,attr_id,product_attr_value) 
        VALUES (productId,attrId, productAttrValue);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_product_attr(integer, integer, character varying)
    OWNER TO hyperscaleios;

-- PROCEDURE: public.insert_product_attr(integer, character varying, timestamp without time zone)

-- DROP PROCEDURE IF EXISTS public.insert_product_attr(integer, character varying, timestamp without time zone);

CREATE OR REPLACE PROCEDURE public.insert_product_attr(
	IN productid integer,
	IN productattrvalue character varying,
	IN productattrdate timestamp without time zone)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

        INSERT INTO product_attr( product_id,product_attr_value, product_attr_date) 
        VALUES (productId, productAttrValue, productAttrDate);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_product_attr(integer, character varying, timestamp without time zone)
    OWNER TO hyperscaleios;


-- PROCEDURE: public.insert_ticket(integer, integer, character varying)

-- DROP PROCEDURE IF EXISTS public.insert_product_attr(integer, integer, character varying);

CREATE OR REPLACE PROCEDURE public.insert_product_attr(
	IN productid integer,
	IN attrid integer,
	IN productattrvalue character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

        INSERT INTO product_attr( product_id,attr_id,product_attr_value) 
        VALUES (productId,attrId, productAttrValue);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_product_attr(integer, integer, character varying)
    OWNER TO hyperscaleios;

-- PROCEDURE: public.insert_ticket(character varying, character varying, numeric, character varying)

-- DROP PROCEDURE IF EXISTS public.insert_ticket(character varying, character varying, numeric, character varying);

CREATE OR REPLACE PROCEDURE public.insert_ticket(
	IN custId integer ,
	IN productId integer ,
	IN ticketDesc varchar(200),
	IN ticketOwner varchar(20),
        IN contactId integer,
        IN priority  smallint,
        IN statu varchar(10) )
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	   INSERT INTO ticket( cust_id,product_id, ticket_desc, ticket_owner, contact_id, priority, status)
        VALUES (custId, productId, ticketDesc, ticketOwner,contactId,priority, statu);
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_ticket(integer,integer,character varying,character varying,integer,
smallint,character varying) OWNER TO hyperscaleios;

CREATE OR REPLACE PROCEDURE public.insert_ticket_detail(
	IN ticketNumber integer ,
	IN contactMedia integer ,
	IN contactDate varchar(200),
	IN contactId varchar(20),
        IN converse  text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	   INSERT INTO ticket_detail( ticket_number,contact_media, contact_date, contact_id, conversation)
        VALUES (ticketNumber, contactMedia, contactDate, contactId,converse );
        COMMIT;
END;
$BODY$;
ALTER PROCEDURE public.insert_ticket_detail(integer,integer,character varying,character varying, text)
OWNER TO hyperscaleios;
