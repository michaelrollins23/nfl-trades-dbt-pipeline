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
    SUM(CASE WHEN asset_type = 'Player' THEN assets_given ELSE 0 END) AS players_traded_away,
    SUM(CASE WHEN asset_type = 'Draft Pick' THEN assets_given ELSE 0 END) AS picks_traded_away,
    SUM(CASE WHEN asset_type = 'Draft Pick' THEN assets_received ELSE 0 END) AS picks_acquired
    FROM trade_summaries
    GROUP BY 1
)

SELECT *,
       CASE
        WHEN players_acquired > players_traded_away THEN 'Win Now (Aggressive)'
        WHEN picks_acquired > players_acquired THEN 'Reguilding (Asset Hoarding)'
        ELSE 'Balanced/Neutral'
       END AS team_strategy
FROM final