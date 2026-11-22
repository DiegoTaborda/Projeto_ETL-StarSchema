with customers as (
    select * from {{ ref('stg_olist__customers') }}
),

deduplicated as (
    select
        customer_unique_id,
        min(customer_id)      as customer_id,
        max(zip_code_prefix)  as zip_code_prefix,
        max(city)             as city,
        max(state)            as state
    from customers
    group by customer_unique_id
)

select * from deduplicated