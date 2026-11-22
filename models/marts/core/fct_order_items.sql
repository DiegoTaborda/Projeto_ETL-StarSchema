with order_items as (
    select * from {{ ref('stg_olist__order_items') }}
),

orders as (
    select * from {{ ref('stg_olist__orders') }}
),

customers as (
    select * from {{ ref('stg_olist__customers') }}
),

joined as (
    select
        oi.order_id,
        oi.order_item_id,
        oi.order_id || '-' || oi.order_item_id as order_item_sk,
        c.customer_unique_id,
        oi.product_id,
        oi.seller_id,
        cast(o.purchased_at as date) as date_day,
        o.order_status,
        oi.price,
        oi.freight_value
    from order_items oi
    left join orders o
        on oi.order_id = o.order_id
    left join customers c
        on o.customer_id = c.customer_id
)

select * from joined