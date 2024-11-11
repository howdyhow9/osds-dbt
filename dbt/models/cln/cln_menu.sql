{{ config(
  materialized='table',
  file_format='delta'
) }}



select menu_item_id, item_name, category, price
from {{ source('raw_restaurant_db', 'menu') }}