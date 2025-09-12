-- RAW: store original JSON for airplane models
CREATE TABLE IF NOT EXISTS raw.airplane_models_json (
  raw_json STRING,
  ingest_ts TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/raw/airplane_models_json/';
