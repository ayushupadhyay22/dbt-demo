with race_results as (
    select * from {{ ref('stg_race_results') }}
),

qualifying_results as (
    select * from {{ ref('stg_qualifying') }}
),

driver_stats as (
    select
        r.driver_name,
        r.team,
        count(r.race_id) as total_races,
        sum(r.points) as total_points,
        min(r.position) as best_race_finish,
        min(q.qualifying_position) as best_qualifying_position,
        count(case when r.position = 1 then 1 end) as race_wins,
        count(case when r.points > 0 then 1 end) as points_finishes
    from race_results r
    left join qualifying_results q
        on r.race_id = q.race_id
        and r.driver_name = q.driver_name
    group by 1, 2
)

select * from driver_stats
order by total_points desc
