{{ config(materialized='table') }}

with cust as (
    select * from {{ ref('stg_customer') }}
),
grp as (
    select * from {{ ref('stg_customer_group') }}
)
select
    c.customer_id,
    c.name,
    c.email,
    c.phone,
    c.customer_group_id,
    g.name as customer_group_name,
    g.type as customer_group_type,
    g.registry_number,
    true as is_active,
    current_date() as valid_from,
    null as valid_to,
    current_timestamp() as updated_at
from cust c
         left join grp g on c.customer_group_id = g.id;
