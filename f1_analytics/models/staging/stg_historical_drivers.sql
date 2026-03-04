with source as (
    select * from {{ source('raw_f1', 'f1_historical_drivers') }}
),

renamed as (
    select
        driver_name,
        nationality,
        last_team,
        cast(birth_year as integer) as birth_year,
        cast(debut_year as integer) as debut_year,
        cast(last_active_year as integer) as last_active_year,
        cast(career_length_years as integer) as career_length_years,
        cast(race_wins as integer) as race_wins,
        cast(pole_positions as integer) as pole_positions,
        cast(podiums as integer) as podiums,
        cast(fastest_laps as integer) as fastest_laps,
        cast(championships as integer) as championships,
        cast(estimated_race_starts as integer) as estimated_race_starts,
        cast(win_rate_percent as float) as win_rate_percent,
        cast(podium_rate_percent as float) as podium_rate_percent,
        career_status
    from source
)

select * from renamed
