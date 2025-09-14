{{ config(materialized='table') }}

with dates as (
  select explode(sequence(to_date('2020-01-01'), to_date('2030-12-31'), interval 1 day)) as date_id
)
select
    date_id,
    year(date_id) as year,
    quarter(date_id) as quarter,
    month(date_id) as month,
    date_format(date_id, 'MMMM') as month_name,
    weekofyear(date_id) as week_of_year,
    day(date_id) as day_of_month,
    dayofweek(date_id) as day_of_week,
    date_format(date_id, 'EEEE') as day_name,
    case when dayofweek(date_id) in (1,7) then true else false end as is_weekend
from dates;
