with source as (
    select * from {{ source('raw_f1', 'f1_2024_race_results') }}
),

renamed as (
    select
        cast(race_id as integer) as race_id,
        race_name,
        circuit,
        city,
        country,
        cast(circuit_length_km as float) as circuit_length_km,
        cast(total_laps as integer) as total_laps,
        cast(position as integer) as position,
        driver_name,
        team,
        nationality,
        cast(car_number as integer) as car_number,
        race_time,
        cast(points as float) as points,
        fastest_lap,
        pole_position
    from source
)

select * from renamed
