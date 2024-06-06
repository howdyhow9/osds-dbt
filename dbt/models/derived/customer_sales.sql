{{ config(
  materialized='table',
  file_format='delta'
) }}


SELECT customerid, count(customerid) as customer_count FROM
{{ source('osdp_sales', 'customer') }}
group by customerid;


