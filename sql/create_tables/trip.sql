CREATE TABLE IF NOT EXISTS prd.trip (
  trip_id            BIGINT,
  origin_city        STRING,
  destination_city   STRING,
  airplane_id        BIGINT,
  start_timestamp    TIMESTAMP,
  end_timestamp      TIMESTAMP,
  distance_km        DECIMAL(10,2),
  duration_minutes   INT,
  status             STRING,
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (date(start_timestamp))
LOCATION 's3://bucket-location/prd/trip/';
