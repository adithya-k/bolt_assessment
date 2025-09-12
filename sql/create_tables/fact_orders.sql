CREATE TABLE IF NOT EXISTS prd.fact_orders (
  order_id           BIGINT,
  customer_id        BIGINT,
  trip_id            BIGINT,
  price_eur          DECIMAL(12,2),
  seat_no            STRING,
  status             STRING,
  order_ts           TIMESTAMP,
  cancelled_ts       TIMESTAMP,
  revenue_date       DATE,
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (revenue_date)
LOCATION 's3://bucket-location/prd/fact_order/';
