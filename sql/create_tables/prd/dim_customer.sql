CREATE TABLE IF NOT EXISTS prd.dim_customer (
    customer_id         BIGINT,
    name                STRING,
    email               STRING,
    phone               STRING,
    customer_group_id   BIGINT,
    customer_group_name STRING,
    customer_group_type STRING,
    registry_number     STRING,
    is_active           BOOLEAN,
    valid_from          DATE,
    valid_to            DATE,
    updated_at          TIMESTAMP,
    ingestion_ts        TIMESTAMP DEFAULT current_timestamp()
)
USING delta
COMMENT "Dimension table combining customer and customer_group details"
LOCATION 's3://bucket-location/prd/dim_customer/';
