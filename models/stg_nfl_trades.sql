WITH source AS
(
    SELECT *
    FROM {{source('nfl_raw','nfl')}}
),

renamed_and_cast AS
(
    SELECT
        SAFE_CAST(trade_id AS INTEGER) AS trade_id,
        SAFE_CAST(season AS INTEGER) AS trade_season,
        SAFE_CAST(trade_date AS DATE) AS trade_date,
        CAST(gave AS STRING) AS team_giving_asset,
        CAST(received AS STRING) AS team_receiving_asset,
        SAFE_CAST(pick_season AS INTEGER) AS pick_season,
        SAFE_CAST(pick_round AS INTEGER) AS pick_round,
        SAFE_CAST(pick_number AS INTEGER) as pick_number,
        SAFE_CAST(conditional AS INTEGER) AS is_conditional,
        CAST(pfr_id AS STRING) AS player_id,
        CAST(pfr_name AS STRING) as player_name,
        CASE
            WHEN pfr_name IS NOT NULL THEN 'Player'
            WHEN pick_round IS NOT NULL THEN 'Draft Pick'
            ELSE 'Other/Unknown'
        END AS asset_type
        FROM source
)

SELECT *
FROM renamed_and_cast