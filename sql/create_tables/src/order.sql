CREATE TABLE IF NOT EXISTS src.order (
    order_id           BIGINT,
    customer_id        BIGINT,
    trip_id            BIGINT,
    price_eur          DECIMAL(12,2),
    seat_no            STRING,
    status             STRING,
    ingestion_ts       TIMESTAMP DEFAULT current_timestamp()
)
USING delta
PARTITIONED BY (date(start_timestamp))
LOCATION 's3://bucket-location/src/order/';
