SELECT *
FROM {{ source('source', 'dim_items') }}