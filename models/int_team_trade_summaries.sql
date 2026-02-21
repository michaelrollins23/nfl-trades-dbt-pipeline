WITH trades AS
(
    SELECT *
    FROM {{ref('stg_nfl_trades')}}
),

giving_summary AS
(
    SELECT
        team_giving_asset AS team,
        asset_type,
        COUNT(*) AS assets_given
    FROM trades
    GROUP BY 1, 2
),

receiving_summary AS
(
    SELECT
        team_receiving_asset AS team,
        asset_type,
        COUNT(*) AS assets_received
        FROM trades
        GROUP BY 1,2
)

SELECT
    COALESCE(g.team, r.team) AS TEAM,
    g.asset_type,
    COALESCE(g.assets_given, 0) AS assets_given,
    COALESCE(r.assets_received, 0) AS assets_received,
    COALESCE(r.assets_received, 0) - COALESCE(g.assets_given, 0) AS net_asset_change
FROM giving_summary AS g
FULL OUTER JOIN receiving_summary AS r
    ON g.team = r.team AND g.asset_type = r.asset_type