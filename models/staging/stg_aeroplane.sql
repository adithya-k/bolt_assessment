{{ config(materialized='view') }}

select
    airplane_id,
    airplane_model,
    manufacturer,
    ingestion_ts
from {{ source('src', 'aeroplane') }};
