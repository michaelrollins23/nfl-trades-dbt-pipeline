WITH sales_fact AS
(
    SELECT *
    FROM fct_ticket_sales
)

, final AS
(
    SELECT event_type
        , COUNT(sale_id) AS total_tickets_sold
        , SUM(ticket_price_usd) AS totla_revenue
        , AVG(days_until_event) AS avg_booking_window_days
        , MIN(days_until_event) AS closest_purchse_days
        , MAX(days_until_event) AS furthest_purchase_days
    FROM sales_fact
    GROUP BY 1
)

SELECT *
FROM final