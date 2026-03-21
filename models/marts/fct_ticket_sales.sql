WITH sales AS
(
    SELECT *
    FROM {{ref('stg_seatgeek_sales')}}
)

, events AS
(
    SELECT *
    FROM {{ref('stg_seatgeek_events')}}
)

, final_joined AS
(
    SELECT s.sale_id
        , s.customer_id
        , e.event_name
        , e.event_venue
        , e.event_type
        , s.ticket_price_usd
        , s.sold_at
        , e.event_date
        , ABS(DATE_DIFF(e.event_date, CAST(s.sold_at AS date), DAY)) AS days_until_event
    FROM sales AS s
    LEFT JOIN events AS e ON s.event_id = e.event_id
)

SELECT *
FROM final_joined