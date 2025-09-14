# 📘 Design Rationale — Air Boltic Data Model

This document explains the reasoning behind the data model design, how it aligns with Bolt’s stack and analytics needs, and trade-offs considered.

---

## 1. Business Context

Air Boltic is a hypothetical Bolt service providing an airplane ride-sharing marketplace.  
The analytics goals are to:
- Monitor adoption & usage across regions.
- Measure supply-demand balance (plane capacity vs bookings).
- Track revenue, utilization, cancellations, and customer activity.
- Ensure comparability with existing Bolt services (ride-hailing, food, micromobility).

The model must scale to support **global operations by 2030** while enabling **daily, weekly, and monthly analytics**.

---

## 2. Medallion Architecture

The model follows the **Medallion Architecture** (Bronze → Silver → Gold), which ensures scalability, maintainability, and reliability.

- **Bronze (src):**
    - Raw ingested data stored in Delta tables.
    - JSON (`aeroplane_model_json_raw`) is preserved unmodified for lineage and reprocessing.
    - Other source tables (`aeroplane`, `customer`, `customer_group`, `trip`, `order`) mirror source system structures.

- **Silver (staging):**
    - dbt models clean and standardize raw data.
    - Example: `stg_aeroplane_model` parses JSON into tabular columns.
    - Example: `stg_trip` derives `duration_minutes`.
    - Ensures consistent naming conventions and datatypes.

- **Gold (prd):**
    - Star schema optimized for self-service analysis in Looker.
    - Dimensions (`dim_aeroplane`, `dim_customer`, `dim_date`) provide context.
    - Facts (`fact_orders`, `fact_trips`) capture measures at the correct grain.

---

## 3. Star Schema Design

### Dimensions
- **dim_aeroplane:** Combines airplane registry data with model specifications (capacity, range, engine type). Enables utilization analysis.
- **dim_customer:** Combines individual and group-level attributes for segmentation and churn analysis.
- **dim_date:** Provides a consistent calendar hierarchy (day → week → month → quarter → year).

### Facts
- **fact_orders:**
    - Grain: **seat booking**.
    - Measures: revenue, cancellation, booking timestamps.
    - FKs: customer, trip, aeroplane, date.

- **fact_trips:**
    - Grain: **trip (flight instance)**.
    - Measures: total bookings, utilization rate, revenue, duration.
    - FKs: aeroplane, date.

### Why Star Schema?
- Intuitive for analysts.
- Optimized for BI tools like Looker.
- Ensures consistency in metric definitions.
- Scales better than wide flat tables.

---

## 4. Data Quality & Governance

- **Tests in dbt:**
    - Uniqueness & not-null on IDs.
    - Referential integrity between facts and dims.
    - Business rule tests (e.g., booked seats ≤ max seats, price ≥ 0, utilization ≤ 1).

- **Delta Lake Advantages:**
    - ACID compliance for concurrent workloads.
    - Schema evolution for changing business needs.
    - Time travel for auditing and debugging.

- **Unity Catalog (future):**
    - Centralized governance, lineage tracking, and role-based access.

---

## 5. Performance & Scalability

- **Partitioning:** Fact tables partitioned by `date_id` for efficient time-based queries.
- **Incremental Loads:** Facts (orders, trips) are materialized incrementally to reduce processing costs.
- **Surrogate Keys:** `airplane_model_id` = manufacturer|model ensures joins remain stable even if IDs change upstream.

---

## 6. Trade-offs Considered

- **Staging as Views vs Tables:**
    - Most staging models are `view` (light transformations).
    - JSON flattening (`stg_aeroplane_model`) is `table` since parsing is compute-heavy.

- **Schema Evolution:**
    - Chose Delta Lake for flexibility; in real-world scale, schema evolution will be common (new aircraft attributes, new booking fields).

- **Fact Table Grain:**
    - `fact_orders` chosen at **seat-level grain** instead of aggregated order-level to preserve flexibility (can aggregate later in Looker).

---

## 7. Future Enhancements

- Add **dim_route** (origin-destination dimension) for route-level insights.
- Implement **SCD Type 2 snapshots** (e.g., customer group changes over time).
- Add **fact_cancellations** or expand `fact_orders` to separate booking/cancellation events.
- Introduce **real-time ingestion** for monitoring seat utilization as flights approach departure.
- Build a **metrics layer** (dbt exposures) for core KPIs (DAU, WAU, MAU, utilization %, revenue).

---

## 8. Alignment with Bolt’s Stack

- **S3** → raw storage for JSON & tabular data.
- **Databricks** → Delta Lake tables, Spark SQL transformations.
- **dbt** → transformation logic, tests, and documentation.
- **Looker** → self-service analytics on top of star schema.
- **GitHub** → version control & CI/CD workflows.

---

✅ This design ensures the model is **scalable, maintainable, and business-aligned**, supporting Air Boltic’s vision to scale globally by 2030.  
