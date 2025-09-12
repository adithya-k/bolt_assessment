CREATE TABLE IF NOT EXISTS prd.customer_group (
  id                BIGINT,
  type              STRING,
  name              STRING,
  registry_number   STRING,
  ingestion_ts      TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/prd/customer_group/';
