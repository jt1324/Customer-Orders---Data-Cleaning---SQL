-- *********************** Checking the data ***************************

SELECT
    *
FROM customer_orders;


-- *********************** Standarize the order_status column ***************************

SELECT
    DISTINCT order_status
FROM customer_orders;

SELECT
    order_status,
    CASE
        WHEN LOWER(order_status) LIKE '%deliver%' THEN 'Deliver'
        WHEN LOWER(order_status) LIKE '%return%' THEN 'Returned'
        WHEN LOWER(order_status) LIKE '%shipped%' THEN 'Shipped'
        WHEN LOWER(order_status) LIKE '%pending%' THEN 'Pending'
        WHEN LOWER(order_status) LIKE '%refund%' THEN 'Refunded'
        ELSE 'Other'
    END AS cleaned_order_status
FROM customer_orders;