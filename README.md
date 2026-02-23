# NFL Trade Analysis Data Pipeline (dbt + BigQuery)

## 📌 Project Overview
This project demonstrates a modern data engineering workflow using **dbt (data build tool)** and **Google BigQuery**. It transforms raw NFL trade transaction data into a clean, business-ready dimensional model that classifies team team-building strategies (e.g., "Win Now" vs. "Rebuilding") based on asset management.

## 🛠️ Tech Stack
* **Data Warehouse:** Google BigQuery
* **Transformation & Orchestration:** dbt Cloud
* **Version Control:** Git / GitHub
* **Languages:** SQL, YAML

## 🏗️ Architecture (Medallion Approach)
This pipeline follows a standard Medallion (3-tier) architecture to ensure data quality and modularity.

### 1. Staging (`stg_nfl_trades`)
* Reads raw CSV data from BigQuery.
* Implements `SAFE_CAST` for pipeline resilience.
* Standardizes column names and handles the specific grain of the data (one row per asset transferred, not per transaction).

### 2. Intermediate (`int_team_trade_summaries`)
* Aggregates the asset data.
* Calculates the net draft capital and player assets given/received by each NFL team.

### 3. Mart (`fct_nfl_team_behavior`)
* The final business-facing table.
* Applies logic to categorize team behavior based on their net asset movement (e.g., heavily acquiring players while trading away picks is classified as a "Win Now" strategy).

## 🧪 Data Quality & Testing
Automated schema tests are configured in `_models.yml` to run on every build, ensuring pipeline integrity:
* `unique` and `not_null` constraints on primary keys.
* `accepted_values` testing to ensure asset types strictly fall into 'Player', 'Draft Pick', or 'Other/Unknown'.

## 📊 Documentation & Lineage
dbt automatically generates a data catalog containing table descriptions, column-level definitions, and dependency graphs. 

### Data Lineage Graph
*(Below is the visual flow of data from source to the final mart model)*

<img width="1297" height="272" alt="Image" src="https://github.com/user-attachments/assets/4a855aec-c296-4cb3-9cda-2907ecdbec0d" />

### Auto-Generated dbt Catalog
*(Column descriptions and schema test badges)*

<img width="498" height="485" alt="image" src="https://github.com/user-attachments/assets/8f693fa4-38fb-4193-89e5-1300cc2b2089" />

### Cloud Warehouse Materialization (BigQuery)
*(Final production tables cleanly materialized and separated from the development environment)*

<img width="858" height="524" alt="image" src="https://github.com/user-attachments/assets/dfb280ff-a882-4a44-9367-107ef9d988e0" />
<img width="858" height="524" alt="image" src="https://github.com/user-attachments/assets/dfb280ff-a882-4a44-9367-107ef9d988e0" />


### Pipeline Automation & Orchestration
*(Production deployment job configured to automatically build models, run schema tests, and generate documentation)*

![dbt Automated Job Run]([INSERT LINK TO JOB RUN SCREENSHOT HERE])
