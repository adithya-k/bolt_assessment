CREATE TABLE IF NOT EXISTS prd.customer (
  customer_id        BIGINT,
  name               STRING,
  email              STRING,
  phone              STRING,
  customer_group_id  BIGINT,
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/prd/customer/';
