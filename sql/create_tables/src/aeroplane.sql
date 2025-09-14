CREATE TABLE IF NOT EXISTS src.aeroplane (
    airplane_id     BIGINT,
    airplane_model  STRING,
    manufacturer    STRING,
    ingestion_ts    TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/src/aeroplane/';