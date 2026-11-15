WITH dedup_query AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY updateDate DESC) as deduplication_id
    FROM
        {{ ref('bronze_d_items') }}
)
SELECT
    id,name,category,updateDate
FROM
    dedup_query
WHERE
    deduplication_id = 1
