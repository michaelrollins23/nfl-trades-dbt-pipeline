WITH raw_sales AS
(
    SELECT *
    FROM {{source('seatgeek_raw_data','raw_ticket_sales')}}
)

, renamed AS
(
    SELECT sale_id
        , CAST(event_id AS string) AS event_id
        , customer_id
        -- Renaming 'final_price' to be more descriptive
        , final_price AS ticket_price_usd
        , sale_status
        -- Standardizing the timestamp
        , CAST(sale_timestamp AS timestamp) AS sold_at
    FROM raw_sales
)

, final AS
(
    SELECT *
    FROM renamed
    -- Only care about completed transactions for our revenue reports
    WHERE sale_status = 'completed'
)

SELECT *
FROM final