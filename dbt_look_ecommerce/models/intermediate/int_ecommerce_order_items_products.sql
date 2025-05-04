WITH products AS (
    SELECT
        product_id,
        department      AS product_department,
        cost            AS product_cost,
        retail_price    AS product_retail_price,

    FROM
     {{ ref('stg_ecommerce_products') }}
)

SELECT
    -- IDs
    oi.order_item_id,
    oi.order_id,
    oi.user_id,
    oi.product_id,

    -- Order item data
    oi.item_sale_price,

    -- Product data
    p.product_department,
    p.product_cost,
    p.product_retail_price,

    -- Calculate fields
    oi.item_sale_price     - p.product_cost     AS item_profit,
    p.product_retail_price - oi.item_sale_price AS item_discount

FROM
    {{ ref('stg_ecommerce_order_items') }} AS oi
LEFT JOIN
    products AS p
ON  oi.product_id = p.product_id
