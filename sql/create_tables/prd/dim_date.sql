CREATE TABLE IF NOT EXISTS prd.dim_date (
  date_id        DATE,
  year           INT,
  quarter        INT,
  month          INT,
  month_name     STRING,
  week_of_year   INT,
  day_of_month   INT,
  day_of_week    INT,
  day_name       STRING,
  is_weekend     BOOLEAN
)
USING delta
LOCATION 's3://bucket-location/prd/dim_date/';
