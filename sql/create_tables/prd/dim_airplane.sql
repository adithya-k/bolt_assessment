CREATE TABLE IF NOT EXISTS prd.dim_airplane (
  airplane_id        BIGINT,
  airplane_model     STRING,
  manufacturer       STRING,
  airplane_model_id  STRING,   -- FK to dim_airplane_model
  status             STRING,
  updated_at         TIMESTAMP,
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (manufacturer)
LOCATION 's3://bucket-location/prd/dim_airplane/';
