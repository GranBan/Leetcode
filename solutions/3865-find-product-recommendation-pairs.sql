# Write your MySQL query statement below

with firstp as (
    select pp.user_id, pp.product_id as product1_id, pin.category as product1_category from ProductPurchases pp join ProductInfo pin on pp.product_id = pin.product_id
),
secondp as (
    select pp.user_id, pp.product_id as product2_id, pin.category as product2_category from ProductPurchases pp join ProductInfo pin on pp.product_id = pin.product_id
),
consol as (
    select f.user_id, f.product1_id, s.product2_id, f.product1_category, s.product2_category, count(f.user_id) over (partition by f.product1_id, s.product2_id) as customer_count from firstp f join secondp s on f.user_id = s.user_id where f.product1_id < s.product2_id
)
select distinct c.product1_id, c.product2_id, c.product1_category, c.product2_category, c.customer_count from consol c where customer_count >= 3 order by customer_count desc, product1_id asc, product2_id asc