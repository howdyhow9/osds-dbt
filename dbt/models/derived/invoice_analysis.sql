{{ config(
  materialized='table',
  file_format='delta'
) }}

select *
from {{ source('raw_storedb', 'invoice_totals') }}  a
join {{ source('raw_storedb', 'invoice_itemized') }}  a
on a.Invoice_Number = b.Invoice_Number limit 5;


