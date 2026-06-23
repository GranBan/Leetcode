# Write your MySQL query statement below

-- most exp pro
-- cheapest pro
-- imbalance ratio

with cte as (
    select store_id, product_name, quantity, price, rank() over (partition by store_id order by price desc) as rn, rank() over (partition by store_id order by price) as rn2, count(1) over (partition by store_id) as num_products from inventory
),
expen as (
    select store_id, product_name as most_exp_product, quantity as most_exp_quantity, price as most_exp_price, num_products from cte where rn = 1 and num_products >= 3
),
cheap as (
    select store_id, product_name as cheapest_product, quantity as cheapest_quantity, price as cheapest_price, num_products from cte where rn2 = 1 and num_products >= 3
),
consol as (
    select e.store_id, e.most_exp_product, c.cheapest_product, e.most_exp_quantity, c.cheapest_quantity, round(c.cheapest_quantity / e.most_exp_quantity, 2) as imbalance_ratio from expen e join cheap c on e.store_id = c.store_id
)
select c.store_id, s.store_name, s.location, c.most_exp_product, c.cheapest_product, c.imbalance_ratio from consol c join stores s on c.store_id = s.store_id where c.most_exp_quantity < c.cheapest_quantity order by 6 desc, 2 asc