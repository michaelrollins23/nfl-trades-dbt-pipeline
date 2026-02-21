WITH trade_summaries AS
(
  SELECT *
  FROM `nfl-engineering.dbt_mrollins.int_team_trade_summaries`
),

final AS
(
  SELECT
    team,
    SUM(CASE WHEN asset_type = 'Player' THEN assets_received ELSE 0 END) AS players_acquired,
    SUM(CASE WHEN asset_type = 'Draft Pick' THEN assets_given ELSE 0 END) AS picks_traded_away,
    SUM(net_asset_change) AS total_net_assets,
    CASE
      WHEN SUM(CASE WHEN asset_type = 'Player' THEN assets_received ELSE 0 END) >
           SUM(CASE WHEN asset_type = 'Draft Pick' THEN assets_received ELSE 0 END)
      THEN 'Win Now (Aggressive)'
      ELSE 'Reguilding (Conservative)'
    END AS team_strategy
    FROM trade_summaries
    GROUP BY 1
)

SELECT *
FROM final