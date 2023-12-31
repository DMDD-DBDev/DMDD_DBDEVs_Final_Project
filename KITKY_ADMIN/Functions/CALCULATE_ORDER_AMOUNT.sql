CREATE OR REPLACE FUNCTION CALCULATE_ORDER_AMOUNT (
    PI_ORDER_ID NUMBER
) RETURN NUMBER
AS
    ORDER_AMOUNT NUMBER := 0;
BEGIN
    FOR I IN (
        SELECT SIZE_CATEGORY FROM ITEM WHERE ORDER_ID = PI_ORDER_ID
    )
    LOOP 
        IF I.SIZE_CATEGORY = 'SMALL' THEN
            ORDER_AMOUNT := ORDER_AMOUNT + 10;
        ELSIF I.SIZE_CATEGORY = 'MEDIUM' THEN
            ORDER_AMOUNT := ORDER_AMOUNT + 30;
        ELSIF I.SIZE_CATEGORY = 'LARGE' THEN
            ORDER_AMOUNT := ORDER_AMOUNT + 50;
        END IF;
    END LOOP;
    
    RETURN ORDER_AMOUNT;
END CALCULATE_ORDER_AMOUNT;
/