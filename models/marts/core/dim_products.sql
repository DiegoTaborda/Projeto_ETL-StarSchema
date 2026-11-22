with products as (
    select * from {{ ref('stg_olist__products') }}
),

translation as (
    select * from {{ ref('stg_olist__product_category_translation') }}
),

joined as (
    select
        p.product_id,
        p.category_name,
        coalesce(t.category_name_english, p.category_name, 'unknown') as category_name_english,
        p.name_length,
        p.description_length,
        p.photos_qty,
        p.weight_g,
        p.length_cm,
        p.height_cm,
        p.width_cm
    from products p
    left join translation t
        on p.category_name = t.category_name
)

select * from joined