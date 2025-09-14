-- RAW: store original JSON for aeroplane models
CREATE TABLE IF NOT EXISTS src.aeroplane_model_json_raw (
  raw_json STRING,
  ingestion_ts TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/src/aeroplane_model_json_raw/';
