CREATE TABLE IF NOT EXISTS src.aeroplane_model (
    manufacturer   STRING,
    model          STRING,
    max_seats      INT,
    max_weight     INT,
    max_distance   INT,
    engine_type    STRING,
    ingestion_ts   TIMESTAMP DEFAULT current_timestamp()
)
USING delta
LOCATION 's3://bucket-location/src/aeroplane_model/';