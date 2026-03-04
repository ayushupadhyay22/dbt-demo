# Formula 1 Analytics (dbt + DuckDB)

A detailed analytics project using **dbt (data build tool)** and **DuckDB** to process the Comprehensive Formula 1 Dataset (2020-2025). The project demonstrates how to ingest raw CSV data, perform transformations in a local warehouse, and generate insights into driver performance.

---

## 🚀 Run It Yourself (Quick Start)

Follow these steps to get the project running on your local machine:

1.  **Clone the Repository**:
    ```bash
    git clone <your-repo-url>
    cd dbt-demo
    ```

2.  **Setup Environment**:
    ```bash
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    ```

3.  **Download Data**:
    - Place your `kaggle.json` in `~/.kaggle/`.
    - Run `./download_dataset.sh`.

4.  **Execute dbt Pipeline**:
    ```bash
    cd f1_analytics
    dbt run --profiles-dir .
    dbt test --profiles-dir .
    ```

5.  **Verify Results**:
    ```bash
    # From project root
    python verify_results.py
    ```

---

## 🏗️ Project Structure

This is the core structure of the repository. Ephemeral files (like databases, logs, and virtual environments) are excluded via `.gitignore`.

```text
.
├── f1_analytics/               # Root of the dbt project
│   ├── models/
│   │   ├── staging/            # Layer 1: Cleaning and type casting raw data
│   │   ├── marts/               # Layer 2: Final analytical models (Aggregations)
│   │   ├── sources.yml          # External CSV source definitions
│   │   └── schema.yml           # Data quality tests (unique, not_null)
│   ├── profiles.yml            # DuckDB connection configuration
│   └── dbt_project.yml         # Main project configuration
├── download_dataset.sh         # Bash script for Kaggle CLI
├── verify_results.py           # Python script to view results from DuckDB
└── requirements.txt            # Python library dependencies
```

---

## 🔑 Fundamentals: What is Required for a dbt Project?

To implement a functional dbt project, five core pillars are required:

1.  **A dbt Adapter**: The connector for your database. We use `dbt-duckdb`.
2.  **`dbt_project.yml`**: The main configuration file that defines the project.
3.  **`profiles.yml`**: Connection details (database path, credentials).
4.  **The Models (SQL)**: Your transformation logic stored in the `models/` folder.
5.  **Sources**: Definitions of where your raw data originates.

---

## 💻 Code Deep Dive

### 🔧 Configuration (.yml)

- **[dbt_project.yml](file:///Users/ayushupadhyay/Documents/GitHub/dbt-demo/f1_analytics/dbt_project.yml)**: 
    - `name: 'f1_analytics'`: Identifies the project.
    - `models: f1_analytics: staging: +materialized: view`: Instructs dbt to build staging files as virtual views for speed.
    - `marts: +materialized: table`: Final analytical models are built as physical tables for performance.

- **[profiles.yml](file:///Users/ayushupadhyay/Documents/GitHub/dbt-demo/f1_analytics/profiles.yml)**: 
    - `type: duckdb`: Specifies the database engine.
    - `path: 'f1_data.duckdb'`: The file where all your project data is stored locally.

- **[sources.yml](file:///Users/ayushupadhyay/Documents/GitHub/dbt-demo/f1_analytics/models/sources.yml)**: 
    - `external_location: "../data/{name}.csv"`: Dynamically maps local CSV files as sources.

- **[schema.yml](file:///Users/ayushupadhyay/Documents/GitHub/dbt-demo/f1_analytics/models/schema.yml)**: 
    - `tests: not_null / unique`: Automated checks for data quality.

### 🔍 Transformation Logic (.sql)

- **Staging Layer (`models/staging/`)**: 
    - These files use **CTEs** to cast raw strings into proper types and rename columns.

- **Marts Layer (`models/marts/`)**: 
    - **[mart_driver_performance.sql](file:///Users/ayushupadhyay/Documents/GitHub/dbt-demo/f1_analytics/models/marts/mart_driver_performance.sql)**: Joins racing and qualifying data to aggregate driver stats.

---

## 🔧 Where to Make Modifications

- **Ingestion**: Modify `download_dataset.sh` and update `f1_analytics/models/sources.yml`.
- **Cleaning/Logic**: Edit files in `f1_analytics/models/staging/`.
- **New Metrics**: Add new `.sql` files in `f1_analytics/models/marts/`.

---

## 📊 Sample Output

| driver_name     | team             | total_points | race_wins |
|:----------------|:-----------------|:-------------|:----------|
| Max Verstappen  | Red Bull Racing  | 393.0        | 8         |
| Charles Leclerc | Ferrari          | 377.0        | 4         |
| Lewis Hamilton  | Mercedes         | 375.0        | 4         |
