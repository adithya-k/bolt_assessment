CREATE TABLE IF NOT EXISTS src.trip (
  trip_id            BIGINT,
  origin_city        STRING,
  destination_city   STRING,
  airplane_id        BIGINT,
  start_timestamp    TIMESTAMP,
  end_timestamp      TIMESTAMP,
  duration_minutes   INT,              --additional attributes
  status             STRING,           --additional attributes
  ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (date(start_timestamp))
LOCATION 's3://bucket-location/src/trip/';
