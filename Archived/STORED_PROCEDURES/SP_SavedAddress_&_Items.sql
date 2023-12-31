SET SERVEROUTPUT ON;
-- Stored Procedure to add saved addresses

create or replace procedure ADD_SAVED_ADDRESSES(
    ADDRESS_NAME varchar,
    STREET_ADDRESS varchar,
    CITY varchar,
    STATE varchar,
    ZIP_CODE number,
    V_CONTACT_NO number
)
AS
    V_CUST_ID NUMBER;
begin
    SELECT CUST_ID INTO V_CUST_ID FROM CUSTOMER WHERE CONTACT_NO = V_CONTACT_NO;

    INSERT INTO SAVED_ADDRESSES VALUES(
        SAVED_ADDR_SEQ.NEXTVAL,
        INITCAP(ADDRESS_NAME), 
        INITCAP(STREET_ADDRESS), 
        INITCAP(CITY), 
        INITCAP(STATE), 
        ZIP_CODE, 
        V_CUST_ID
    );
    
    commit;
    DBMS_OUTPUT.PUT_LINE('SAVED_ADDRESS Added');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Customer not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
end ADD_SAVED_ADDRESSES;
/

--EXEC ADD_SAVED_ADDRESSES('Home', '93 west walnut', 'Boston', 'MA', 02115, 5555555588);



--stored procedure for adding ITEMS

create or replace procedure ADD_ITEM(U_ORDER_ID NUMBER, ITEM_NAME varchar, SIZE_CATEGORY varchar)
AS
    INVALID_SIZE EXCEPTION;
    INVALID_ORDER_ID EXCEPTION;
    V_SIZE varchar2(6);
    V_ORDER_ID NUMBER;
begin
    V_SIZE := UPPER(SIZE_CATEGORY);
    
    IF V_SIZE NOT IN ('SMALL', 'MEDIUM', 'LARGE') THEN 
        RAISE INVALID_SIZE;
    END IF;

    SELECT COUNT(ORDER_ID) INTO V_ORDER_ID FROM ORDERS WHERE ORDER_ID = U_ORDER_ID;
    IF V_ORDER_ID = 0 THEN
        RAISE INVALID_ORDER_ID;
    END IF;

    INSERT INTO ITEM VALUES (
        ITEM_SEQ.NEXTVAL, 
        INITCAP(ITEM_NAME), 
        V_SIZE, 
        U_ORDER_ID
    );
    
    DBMS_OUTPUT.PUT_LINE('ITEM Added');
    commit;
EXCEPTION
    WHEN INVALID_SIZE THEN
        DBMS_OUTPUT.PUT_LINE('INVALID SIZE, Please select from the list');
    WHEN INVALID_ORDER_ID THEN
        DBMS_OUTPUT.PUT_LINE('Invalid order_id');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
end ADD_ITEM;
/
--EXEC ADD_ITEM(4,'CHAPATHI', 'small');