
CREATE OR REPLACE VIEW V_ORDER_HISTORY_LOG 
AS
WITH ORDER_HISTORY_LOGS AS (
    SELECT
    NULL HISTORY_ID, ORDER_ID, AGENT_ID, CUST_ID, ORDER_AMOUNT, TIP_TO_AGENT, PAYMENT_STATUS, RATING, FEEDBACK, NULL UPDATED_AT, NULL UPDATED_BY
    FROM ORDERS
    UNION ALL
    SELECT HISTORY_ID, ORDER_ID, AGENT_ID, CUST_ID, ORDER_AMOUNT, TIP_TO_AGENT, PAYMENT_STATUS, RATING, FEEDBACK, UPDATED_AT, UPDATED_BY
    FROM ORDER_HISTORY
)
SELECT ORDER_ID, AGENT_ID, CUST_ID, ORDER_AMOUNT, TIP_TO_AGENT, PAYMENT_STATUS, RATING, FEEDBACK, UPDATED_AT, UPDATED_BY 
FROM ORDER_HISTORY_LOGS 
ORDER BY ORDER_ID, HISTORY_ID DESC;


--views for all tables

CREATE OR REPLACE VIEW V_ITEM
AS
select * from  item;

CREATE OR REPLACE VIEW V_ORDER_TRACKING
AS
select * from  ORDER_TRACKING;

CREATE OR REPLACE VIEW V_ORDERS
AS
select * from  orders;

CREATE OR REPLACE VIEW V_VEHICLE
AS
select * from  VEHICLE;

CREATE OR REPLACE VIEW V_SAVED_ADDRESSES
AS
select * from  saved_addresses;

CREATE OR REPLACE VIEW V_CUSTOMER
AS
select * from  customer;

CREATE OR REPLACE VIEW V_DELIVERY_AGENT
AS
select * from  delivery_agent;


--VIEWING ALL VIEWS
--select * from V_ITEM;
--SELECT * FROM V_ORDER_TRACKING;
--select * from V_ORDERS;
--select * from V_VEHICLE;
--select * from V_SAVED_ADDRESSES;
--select * from V_CUSTOMER;
--select * from V_DELIVERY_AGENT;


