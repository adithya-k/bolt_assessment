{{ config(materialized='table') }}

with planes as (
    select * from {{ ref('stg_aeroplane') }}
),
models as (
    select * from {{ ref('stg_aeroplane_model') }}
)
select
    p.airplane_id,
    concat(p.manufacturer, '|', p.airplane_model) as airplane_model_id,
    p.airplane_model,
    p.manufacturer,
    m.max_seats,
    m.max_weight,
    m.max_distance,
    m.engine_type,
    'active' as status,
    current_date() as valid_from,
    null as valid_to,
    current_timestamp() as updated_at
from planes p
         left join models m
                   on p.manufacturer = m.manufacturer
                       and p.airplane_model = m.model;
