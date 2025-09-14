CREATE TABLE IF NOT EXISTS prd.fact_trips (
    trip_id            BIGINT,
    airplane_id        BIGINT,
    airplane_model_id  STRING,
    origin_city        STRING,
    destination_city   STRING,
    start_timestamp    TIMESTAMP,
    end_timestamp      TIMESTAMP,
    duration_minutes   INT,
    total_seats        INT,
    booked_seats       INT,
    utilization_rate   DECIMAL(5,2),   -- booked / total
    total_revenue_eur  DECIMAL(14,2),
    status             STRING,
    date_id            DATE,   -- FK to dim_date
    ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
COMMENT "Fact table for trips, aggregated with bookings and revenue metrics"
PARTITIONED BY (date_id)
LOCATION 's3://bucket-location/prd/fact_trips/';
