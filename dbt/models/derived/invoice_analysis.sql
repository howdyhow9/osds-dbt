{{ config(
  materialized='table',
  file_format='delta'
) }}

select *
from {{ source('osd_store', 'invoice_totals') }}  a
join {{ source('osd_store', 'invoice_itemized') }}  a
on a.Invoice_Number = b.Invoice_Number limit 5;


