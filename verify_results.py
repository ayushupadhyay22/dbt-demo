import duckdb

# Connect to the DuckDB database created by dbt
con = duckdb.connect('f1_analytics/f1_data.duckdb')

# Query the mart_driver_performance model
print("--- Driver Performance Stats (Top 5) ---")
# con.sql Returns a Relation object which has the show() method
con.sql("SELECT driver_name, team, total_points, race_wins FROM main.mart_driver_performance LIMIT 5").show()

print("\n--- Model Build Verification ---")
con.sql("SELECT table_name, table_type FROM information_schema.tables WHERE table_schema = 'main'").show()

con.close()
