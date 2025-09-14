# ✈️ Air Boltic — Bolt Analytics Assessment

This repository contains the dbt implementation for Air Boltic, a hypothetical Bolt service for airplane ride-sharing.
The goal of this project is to design a scalable and analytics-ready data model following Medallion Architecture (Bronze → Silver → Gold) and enable self-service analytics in Looker.

---

## 📂 Repository Contents

| Directory / File | Description |
|------------------|-------------|
| `erd/` | ER diagrams (Source vs PRD star schema) |
| `sql/create_tables/` | Delta SQL `CREATE TABLE` statements for raw (src) and PRD (star schema) tables |
| `dbt/` | dbt project implementing staging → PRD transformations and tests |
| `docs/design_rationale.md` | Additional context on modeling choices and trade-offs |
| `README.md` | This file |

---

## 🏗 Architecture

### Medallion Layers
- **Bronze (src)**  
  Raw ingested data from source systems, stored in Delta tables with minimal transformation.  
  Example: `src.aeroplane_model_json_raw` holds raw JSON for aeroplane models.

- **Silver (staging)**  
  Cleansed and standardized staging models.  
  Example: `stg_aeroplane_model` flattens JSON into tabular form.  
  Example: `stg_trip` derives trip duration.

- **Gold (prd)**  
  Analytics-ready **star schema** for self-service in Looker.  
  - Dimensions: `dim_aeroplane`, `dim_customer`, `dim_date`  
  - Facts: `fact_orders`, `fact_trips`

---

## 📘 Data Model ERD

### Source Entities
- `aeroplane_model_json_raw`  
- `aeroplane`  
- `customer_group`  
- `customer`  
- `order`  
- `trip`

### PRD Star Schema
- **Dimensions**: `dim_aeroplane`, `dim_customer`, `dim_date`  
- **Facts**: `fact_orders`, `fact_trips`

*(See `/erd` for diagrams)*

---

### Future Enhancements

- Add dim_route (origin-destination dimension).
- Implement SCD Type 2 snapshots for dim_customer to track customer group changes.
- Add real-time ingestion pipelines for orders.
- Expand fact tables with payment details and loyalty program data.

### 🧑‍💻 Author

Designed and implemented by Adithya K as part of the Bolt assessment.
