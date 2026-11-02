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
        WHEN LOWER(order_status) LIKE '%deliver%' THEN 'Delivered'
        WHEN LOWER(order_status) LIKE '%return%' THEN 'Returned'
        WHEN LOWER(order_status) LIKE '%shipped%' THEN 'Shipped'
        WHEN LOWER(order_status) LIKE '%pending%' THEN 'Pending'
        WHEN LOWER(order_status) LIKE '%refund%' THEN 'Refunded'
        ELSE 'Other'
    END AS cleaned_order_status
FROM customer_orders;



-- *********************** Standarize the product_name column ***************************

SELECT
    DISTINCT product_name
FROM customer_orders;

SELECT
    product_name,
    CASE
        WHEN LOWER(product_name) LIKE '%apple watch%' THEN 'Apple Watch'
        WHEN LOWER(product_name) LIKE '%samsung galaxy s22%' THEN 'Samsung Galaxy S22'
        WHEN LOWER(product_name) LIKE '%google pixel%' THEN 'Google Pixel'
        WHEN LOWER(product_name) LIKE '%iphone 14%' THEN 'Iphone 14'
        WHEN LOWER(product_name) LIKE '%macbook pro%' THEN 'MacBook Pro'
        ELSE 'Other'
    END AS cleaned_product_name
FROM customer_orders;


-- *********************** Clean quantity column ***************************

SELECT
    DISTINCT quantity
FROM customer_orders;

WITH qty_clean AS (
    SELECT
        quantity,
        CASE
            WHEN quantity = 'two' THEN 2
            ELSE CAST(quantity AS INT)
        END AS cleaned_quantity
    FROM customer_orders)
SELECT
    quantity,
    cleaned_quantity,
    typeof(cleaned_quantity) AS cleaned_qty_type
FROM qty_clean;


