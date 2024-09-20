{{ config(
  materialized='table',
  file_format='delta'
) }}

select a.*
from {{ source('raw_storedb', 'invoice_totals') }}  a
join {{ source('raw_storedb', 'invoice_itemized') }}  b
on a.Invoice_Number = b.Invoice_Number;


