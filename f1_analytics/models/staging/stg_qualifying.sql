with source as (
    select * from {{ source('raw_f1', 'f1_qualifying_results_2024') }}
),

renamed as (
    select
        cast(race_id as integer) as race_id,
        race_name,
        circuit,
        cast(qualifying_position as integer) as qualifying_position,
        driver_name,
        team,
        nationality,
        cast(car_number as integer) as car_number,
        q1_time,
        q2_time,
        q3_time,
        best_time,
        gap_to_pole,
        eliminated_in
    from source
)

select * from renamed
