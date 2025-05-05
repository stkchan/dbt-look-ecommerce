{{ config(severity = 'warn') }}

WITH order_details AS (
    SELECT
        order_id,
        COUNT(*) AS num_of_items_in_ordered
    
    FROM
        {{ ref('stg_ecommerce_order_items') }}

    GROUP BY
        1
)

SELECT
    o.order_id,
    o.num_of_item,
    od.num_of_items_in_ordered

FROM
    {{ ref('stg_ecommerce_order') }} AS o
FULL OUTER JOIN
    order_details                    AS od
USING(order_id)

WHERE
        o.order_id IS NULL
    OR  od.order_id IS NULL
    OR  o.num_of_itemd != od.num_of_items_in_ordered