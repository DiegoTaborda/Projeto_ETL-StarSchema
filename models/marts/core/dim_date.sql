with date_spine as (
    select
        unnest(generate_series(
            date '2016-01-01',
            date '2019-12-31',
            interval 1 day
        )) as date_day
),

final as (
    select
        date_day,
        extract(year from date_day)  as year,
        extract(month from date_day) as month,
        extract(day from date_day)   as day,
        extract(dow from date_day)   as day_of_week,
        strftime(date_day, '%Y-%m')  as year_month,
        case
            when extract(dow from date_day) in (0, 6) then true
            else false
        end as is_weekend
    from date_spine
)

select * from final