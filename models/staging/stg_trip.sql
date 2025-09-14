{{ config(materialized='view') }}

select
    trip_id,
    origin_city,
    destination_city,
    airplane_id,
    start_timestamp,
    end_timestamp,
    datediff(minute, start_timestamp, end_timestamp) as duration_minutes,
    status,
    ingestion_ts
from {{ source('src', 'trip') }};