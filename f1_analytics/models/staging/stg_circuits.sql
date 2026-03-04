with source as (
    select * from {{ source('raw_f1', 'f1_circuits_metadata') }}
),

renamed as (
    select
        circuit_name,
        city,
        country,
        cast(circuit_length_km as float) as circuit_length_km,
        cast(total_laps as integer) as total_laps,
        cast(number_of_turns as integer) as number_of_turns,
        lap_record,
        lap_record_holder,
        cast(lap_record_year as integer) as lap_record_year,
        cast(drs_zones as integer) as drs_zones,
        cast(first_f1_race as integer) as first_f1_race,
        circuit_type,
        cast(elevation_change_m as float) as elevation_change_m,
        cast(race_distance_km as float) as race_distance_km
    from source
)

select * from renamed
