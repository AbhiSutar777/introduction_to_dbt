SELECT *
FROM {{ ref('bronze_f_sales') }}
WHERE gross_amount < 0 OR net_amount < 0 
