{{ config(materialized='view') }}

select
    customer_id,
    name,
    lower(email) as email,
    regexp_replace(phone, '[^0-9+]', '') as phone,
    customer_group_id,
    ingestion_ts
from {{ source('src', 'customer') }};
