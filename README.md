# bolt_assessment
AirBoltic — Bolt assessment: scalable data model (ERD + Delta SQL), dbt examples &amp; CI/CD design

This repository contains my submission for Bolt's Air Boltic assessment:  
a scalable analytics data model (ERD + SQL), partial implementation (Delta/Databricks/dbt examples),  
and notes on CI/CD best practices.

---

## Repository contents
- `erd/` — Entity Relationship Diagram (PNG + source files).
- `sql/create_tables/` — Delta SQL `CREATE TABLE` statements for core entities:
  - aeroplane_models  
  - aeroplanes  
  - trips  
  - orders  
  - customers  
  - customer_groups  
  - metrics (daily/weekly/monthly aggregates)
- `dbt/` — Example dbt project (staging → core → marts) with basic tests.
- `docs/` — Design rationale, assumptions, and future improvements.
- `part2-ci-cd/` — CI/CD design notes (ideal vs real-world resource-limited setup).

---

## Key design decisions
- **Storage:** S3 + Delta Lake for ACID, compaction, partition pruning, and time travel.
- **Compute:** Databricks Spark SQL for transformations and scale-out processing.
- **Modeling:** Canonical entities normalized; wide marts built for self-serve analytics.
- **Transformations:** dbt used for modularity, tests, and documentation.
- **Data quality:** freshness, uniqueness, referential integrity via dbt tests.
- **Metrics:** Leadership-level daily/weekly/monthly aggregates (L0 metrics) alongside event-level detail.

---

## How to review
1. Open `erd/` for the overview of the data model.  
2. Check `sql/create_tables/` for Delta SQL schema design.  
3. Explore `dbt/` to see transformation and testing patterns.  
4. Read `docs/design_rationale.md` for assumptions and trade-offs.  

---

## Part 2 (CI/CD) — summary
See `part2-ci-cd/README.md` for full details.

- **Ideal setup:** Git-based workflow, automated dbt tests, schema diff checks, multi-env promotion (dev → staging → prod), rollback on failures.  
- **Practical setup:** GitHub Actions for dbt tests, lightweight quality checks, manual promotion gates.  
