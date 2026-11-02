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


-- *********************** Clean costumer_name column ***************************

SELECT
    DISTINCT customer_name
FROM customer_orders;

WITH cap_name AS (
    WITH split_name AS (
        SELECT
            customer_name,
            SUBSTR(customer_name, 1, INSTR(customer_name, ' ') -1) AS first_name,
            SUBSTR(customer_name, INSTR(customer_name, ' ') +1) AS last_name
        FROM customer_orders
        WHERE customer_name IS NOT NULL)
    SELECT
        customer_name,
        UPPER(SUBSTR(first_name, 1, 1)) || LOWER(SUBSTR(first_name, 2)) AS cap_f_name,
        UPPER(SUBSTR(last_name, 1, 1)) || LOWER(SUBSTR(last_name, 2)) AS cap_l_name
    FROM split_name)
SELECT
    customer_name,
    TRIM(COALESCE(cap_f_name, '') || ' ' || COALESCE(cap_l_name, '')) AS full_name
FROM cap_name;    


-- *********************** Checking for duplicate orders and remove if exixtent ***************************

SELECT
    COUNT(*) AS qty,
    order_id
FROM customer_orders
GROUP BY order_id;


SELECT
    COUNT(order_id) AS qty,
    LOWER(email),
    LOWER(product_name)
FROM customer_orders
GROUP BY 2, 3
ORDER BY 2;

WITH dupe_check AS (
SELECT
    *,
    ROW_NUMBER() OVER(
        PARTITION BY LOWER(email), LOWER(product_name)
        ORDER BY order_id) AS dupe
FROM customer_orders)
SELECT 
    *
FROM dupe_check
WHERE dupe = 1;