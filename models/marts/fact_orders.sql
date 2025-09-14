{{ config(materialized='incremental', unique_key='order_id', partition_by={"field":"date_id","data_type":"date"}) }}

with o as (
    select * from {{ ref('stg_order') }}
),
t as (
    select trip_id, airplane_id, start_timestamp from {{ ref('stg_trip') }}
),
p as (
    select airplane_id, airplane_model_id from {{ ref('dim_aeroplane') }}
)
select
    o.order_id,
    o.customer_id,
    t.trip_id,
    t.airplane_id,
    p.airplane_model_id,
    o.seat_no,
    o.price_eur,
    o.status,
    current_timestamp() as order_ts,
    case when o.status = 'Cancelled' then current_timestamp() end as cancelled_ts,
    cast(date_trunc('day', t.start_timestamp) as date) as date_id,
    current_timestamp() as ingestion_ts
from o
         join t on o.trip_id = t.trip_id
         left join p on t.airplane_id = p.airplane_id

    {% if is_incremental() %}
where o.order_id not in (select distinct order_id from {{ this }})
    {% endif %}
