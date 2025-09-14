{{ config(materialized='view') }}

select
    manufacturer,
    model,
    max_seats,
    max_weight,
    max_distance,
    engine_type,
    ingestion_ts
from {{ source('src', 'aeroplane_model') }};
