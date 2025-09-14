{{ config(materialized='table') }}

with raw as (
    select
        raw_json,
        ingestion_ts
    from {{ source('src', 'aeroplane_model_json_raw') }}
),
parsed as (
    select
        from_json(
            raw_json,
            'manufacturer STRING, model STRING, max_seats INT, max_weight INT, max_distance INT, engine_type STRING'
        ) as j,
        ingestion_ts
    from raw
)
select
    j.manufacturer,
    j.model,
    j.max_seats,
    j.max_weight,
    j.max_distance,
    j.engine_type,
    ingestion_ts
from parsed;
