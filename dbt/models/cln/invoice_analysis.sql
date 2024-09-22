{{ config(
  materialized='table',
  file_format='delta'
) }}



select IT.Invoice_Number ,LineNum,DiffItemName,"DateTime",
Quantity,CostPer,PricePer,origPricePer,Total_Cost,Payment_Method,
Total_UndiscountedSale,PricePerBeforeDiscount
from {{ source('raw_storedb', 'invoice_totals') }} IT
left join {{ source('raw_storedb', 'invoice_itemized') }} i
on I.Invoice_Number =IT.Invoice_Number
WHERE IT.DateTime > date_add(current_date(), -423);
