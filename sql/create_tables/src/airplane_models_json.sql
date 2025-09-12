-- RAW: store original JSON for airplane models
CREATE TABLE IF NOT EXISTS src.airplane_models_json_raw (
  raw_json STRING,
  ingestion_ts TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/src/airplane_models_json/';
