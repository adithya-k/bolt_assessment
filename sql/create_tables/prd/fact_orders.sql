CREATE TABLE IF NOT EXISTS prd.fact_orders (
  order_id           BIGINT,
  customer_id        BIGINT,
  trip_id            BIGINT,
  airplane_id        BIGINT,
  airplane_model_id  STRING,
  price_eur          DECIMAL(12,2),
  seat_no            STRING,
  status             STRING,
  order_ts           TIMESTAMP,
  cancelled_ts       TIMESTAMP,
  date_id            DATE,   -- FK to dim_date
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (date_id)
LOCATION 's3://bucket-location/prd/fact_order/';
