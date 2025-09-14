{{ config(materialized='view') }}

select
    order_id,
    customer_id,
    trip_id,
    price_eur,
    seat_no,
    status,
    ingestion_ts
from {{ source('src', 'order') }};
