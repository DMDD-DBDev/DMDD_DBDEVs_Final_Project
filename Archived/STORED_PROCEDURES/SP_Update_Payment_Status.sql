-- Stored procedure to update payment status
CREATE OR REPLACE PROCEDURE UPDATE_PAYMENT_STATUS(
    PI_ORDER_ID NUMBER,
    PI_PAYMENT_STATUS VARCHAR
) AS
    INVALID_ORDER EXCEPTION;
    INVALID_STATUS EXCEPTION;
    V_ORDER_ID NUMBER;
BEGIN
    IF UPPER(PI_PAYMENT_STATUS) NOT IN ('FAILED', 'SUCCESSFUL', 'REFUNDED') THEN
        RAISE INVALID_STATUS;
    END IF;
    
    SELECT COUNT(ORDER_ID) INTO V_ORDER_ID FROM ORDERS WHERE ORDER_ID = PI_ORDER_ID;
    
    IF V_ORDER_ID = 0 THEN
        RAISE INVALID_ORDER;
    END IF;
    
    BEGIN
        UPDATE ORDERS SET PAYMENT_STATUS = UPPER(PI_PAYMENT_STATUS) WHERE ORDER_ID = PI_ORDER_ID;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Payment status updated');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error updating payment status: ' || SQLERRM);
            ROLLBACK;
    END;
    
EXCEPTION
    WHEN INVALID_STATUS THEN
        DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID PAYMENT STATUS');
    WHEN INVALID_ORDER THEN
        DBMS_OUTPUT.PUT_LINE('ORDER DOES NOT EXIST');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END UPDATE_PAYMENT_STATUS;
/

--exec UPDATE_PAYMENT_STATUS(4, 'successful');
