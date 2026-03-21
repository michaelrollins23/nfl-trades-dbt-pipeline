WITH raw_events AS
(
    SELECT *
    FROM {{source('seatgeek_raw_data','event_details')}}
)

, final AS
(
    SELECT CAST(event_id AS string) AS event_id
        , event_name
        , event_venue
        , event_type
        -- Casting to DATE for ease to filter by year/month later
        , CAST(event_date AS date) AS event_date
    FROM raw_events
)

SELECT *
FROM final