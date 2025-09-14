CREATE TABLE IF NOT EXISTS prd.dim_aeroplane (
    airplane_id        BIGINT,
    airplane_model_id  STRING,   -- surrogate key manufacturer|model
    airplane_model     STRING,
    manufacturer       STRING,
    max_seats          INT,
    max_weight         INT,
    max_distance       INT,
    engine_type        STRING,
    status             STRING,
    valid_from         DATE,
    valid_to           DATE,
    updated_at         TIMESTAMP,
    ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
COMMENT "Dimension table combining physical airplanes with aeroplane model specs"
PARTITIONED BY (manufacturer)
LOCATION 's3://bucket-location/prd/dim_aeroplane/';
