WITH raw_events AS
(
    SELECT *
    FROM {{source('seatgeek_raw_data','event_details')}}
)

SELECT *
FROM raw_events