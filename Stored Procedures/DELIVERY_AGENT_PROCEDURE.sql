SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE ADD_DELIVERY_AGENT (
    PI_FIRST_NAME DELIVERY_AGENT.FIRST_NAME%TYPE,
    PI_LAST_NAME DELIVERY_AGENT.LAST_NAME%TYPE,
    PI_PASSWORD DELIVERY_AGENT.PASSWORD%TYPE,
    PI_EMAIL DELIVERY_AGENT.EMAIL%TYPE,
    PI_CONTACT_NO DELIVERY_AGENT.CONTACT_NO%TYPE,
    PI_STREET_ADDRESS DELIVERY_AGENT.STREET_ADDRESS%TYPE,
    PI_CITY DELIVERY_AGENT.CITY%TYPE,
    PI_STATE DELIVERY_AGENT.STATE%TYPE,
    PI_ZIP_CODE DELIVERY_AGENT.ZIP_CODE%TYPE
) AS
    E_CONTACT_NO_LENGTH EXCEPTION;
    E_CONTACT_NO_EXISTS EXCEPTION;
    E_EMAIL_EXISTS EXCEPTION;
    E_PASSWORD_VALID EXCEPTION;

    V_CONTACT_NOS NUMBER;
    V_EMAIL_IDS NUMBER;
BEGIN
    IF LENGTH(PI_CONTACT_NO) != 10 THEN
        RAISE E_CONTACT_NO_LENGTH;
    END IF;

    IF LENGTH(PI_PASSWORD) < 8 THEN
        RAISE E_PASSWORD_VALID;
    END IF;

    SELECT COUNT(AGENT_ID) INTO V_CONTACT_NOS FROM DELIVERY_AGENT WHERE CONTACT_NO = PI_CONTACT_NO;
    IF V_CONTACT_NOS > 0 THEN
        RAISE E_CONTACT_NO_EXISTS;
    END IF;

    SELECT COUNT(AGENT_ID) INTO V_EMAIL_IDS FROM DELIVERY_AGENT WHERE EMAIL = LOWER(PI_EMAIL);
    IF V_EMAIL_IDS > 0 THEN
        RAISE E_EMAIL_EXISTS;
    END IF;

    INSERT INTO DELIVERY_AGENT VALUES (
        DELIVERY_AGENT_SEQ.NEXTVAL,
        INITCAP(PI_FIRST_NAME),
        INITCAP(PI_LAST_NAME),
        PI_PASSWORD,
        LOWER(PI_EMAIL),
        PI_CONTACT_NO,
        INITCAP(PI_STREET_ADDRESS),
        INITCAP(PI_CITY),
        INITCAP(PI_STATE),
        INITCAP(PI_ZIP_CODE)
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('DELIVERY AGENT ADDED SUCCESSFULLY');
EXCEPTION
    WHEN E_PASSWORD_VALID THEN
        DBMS_OUTPUT.PUT_LINE('PASSWORD SHOULD HAVE AT LEAST 8 CHARACTERS');
    WHEN E_EMAIL_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('EMAIL ID ALREADY EXISTS. PLEASE SIGN-IN DIRECTLTY');
    WHEN E_CONTACT_NO_EXISTS THEN
        DBMS_OUTPUT.PUT_LINE('CONTACT NO ALREADY EXISTS. PLEASE SIGN-IN DIRECTLY');
    WHEN E_CONTACT_NO_LENGTH THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE INPUT VALID CONTACT NUMBER');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ADD_DELIVERY_AGENT;
/




BEGIN
    ADD_DELIVERY_AGENT(
        PI_FIRST_NAME => 'John',
        PI_LAST_NAME => 'Doe',
        PI_PASSWORD => 'SecurePa',
        PI_EMAIL => 'john.doe@example.com',
        PI_CONTACT_NO => '1234567890',
        PI_STREET_ADDRESS => '123 Main St',
        PI_CITY => 'Cityville',
        PI_STATE => 'Stateville',
        PI_ZIP_CODE => '12345'
    );
END;
/















 
    
    
    
    