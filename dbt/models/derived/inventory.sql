{{ config(
  materialized='table',
  file_format='delta'
) }}

SELECT
    ItemNum,
    ItemName,
    Store_ID,
    Vendor_Number,
    Cost,
    Price,
    In_Stock,
    Reorder_Level,
    (In_Stock - Reorder_Level) AS Stock_To_Reorder_Difference,
    Last_Sold
from
{{ source('osd_store', 'inventory') }}
WHERE
    In_Stock < Reorder_Level -- Identifies items that need reordering
    AND Inactive = 0         -- Filters out inactive items
ORDER BY
    Store_ID,
    Stock_To_Reorder_Difference ASC; -- Orders by stock level urgency
