{{ config(materialized='view') }}

select
    id,
    type,
    name,
    registry_number,
    ingestion_ts
from {{ source('src', 'customer_group') }};
