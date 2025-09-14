{{ config(materialized='table', partition_by={"field":"date_id","data_type":"date"}) }}

with trips as (
    select * from {{ ref('stg_trip') }}
),
orders as (
    select trip_id, count(*) as booked_seats, sum(price_eur) as total_revenue_eur
    from {{ ref('stg_order') }}
    group by trip_id
),
planes as (
    select airplane_id, airplane_model_id, max_seats from {{ ref('dim_aeroplane') }}
)
select
    t.trip_id,
    t.airplane_id,
    p.airplane_model_id,
    t.origin_city,
    t.destination_city,
    t.start_timestamp,
    t.end_timestamp,
    t.duration_minutes,
    p.max_seats as total_seats,
    coalesce(o.booked_seats, 0) as booked_seats,
    case when p.max_seats > 0 then round(o.booked_seats / p.max_seats, 2) end as utilization_rate,
    coalesce(o.total_revenue_eur, 0) as total_revenue_eur,
    t.status,
    cast(date_trunc('day', t.start_timestamp) as date) as date_id,
    current_timestamp() as ingestion_ts
from trips t
         left join orders o on t.trip_id = o.trip_id
         left join planes p on t.airplane_id = p.airplane_id;
