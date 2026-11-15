{# SELECT
     {{ multiply(10, 2) }} AS result
 #}

{# SELECT
    sales_id,
    product_sk,
    customer_sk,
    gross_amount,
    payment_method,
    (units_price * quantity) AS net_amount,
    {{ multiply('units_price', 'quantity') }} AS sample_column
FROM {{ ref('bronze_f_sales') }} #}

SELECT *
FROM {{ source('source', 'dim_items') }}