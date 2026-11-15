WITH f_sales AS (
    SELECT sales_id,
            product_sk,
            customer_sk,
            gross_amount,
            payment_method,
            {{ multiply('unit_price', 'quantity') }} as net_amount
    FROM {{ ref('bronze_f_sales') }}
),

d_product AS (
    SELECT product_sk,
            product_name,
            category
    FROM {{ ref('bronze_d_product') }}
),

d_customer AS (
    SELECT customer_sk,
            customer_code,
            email,
            gender
    FROM {{ ref('bronze_d_customer') }}
),

joined_query AS (
    SELECT a.sales_id,
        a.gross_amount,
        a.payment_method,
        a.net_amount,
        b.product_name,
        b.category,
        c.customer_code,
        c.gender
    FROM f_sales AS a
    LEFT JOIN d_product AS b
        ON a.product_sk = b.product_sk
    LEFT JOIN d_customer AS c
        ON a.customer_sk = c.customer_sk
)

SELECT 
    category,
    gender,
    SUM(gross_amount) AS total_sales
FROM joined_query
GROUP BY category, gender
ORDER BY SUM(gross_amount) DESC