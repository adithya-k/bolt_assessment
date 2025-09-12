CREATE TABLE IF NOT EXISTS prd.dim_airplane_model (
  airplane_model_id  STRING,   -- surrogate key: manufacturer|model
  manufacturer       STRING,
  model              STRING,
  max_seats          INT,
  max_weight         INT,
  max_distance       INT,
  engine_type        STRING,
  valid_from         DATE,
  valid_to           DATE,
  updated_at         TIMESTAMP,
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (manufacturer)
LOCATION 's3://bucket-location/prd/dim_airplane_model/';
