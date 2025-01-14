{{ config(
  materialized='table',
  file_format='delta'
) }}



--select menu_item_id, item_name, category, price from {{ source('raw_restaurant_db', 'menu') }}

SELECT
    m.menu_item_id,
    m.item_name,
    m.category,
    TO_DATE(o.order_date, 'M/d/yy') AS order_date,
    COUNT(o.order_details_id) AS total_orders,
    SUM(CAST(m.price AS DOUBLE)) AS total_sales
FROM
    {{ source('raw_restaurant_db', 'menu') }} AS m
JOIN
    {{ source('raw_restaurant_db', 'orders') }} AS o
ON
    CAST(m.menu_item_id AS STRING) = o.item_id
GROUP BY
    m.menu_item_id,
    m.item_name,
    m.category,
    TO_DATE(o.order_date, 'M/d/yy')
ORDER BY
    order_date ASC,
    total_sales DESC;

