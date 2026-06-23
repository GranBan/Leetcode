# Write your MySQL query statement below

select p.product_id, round(coalesce(1.00 * sum(p.price * u.units) / sum(units), 0), 2) as average_price from Prices p left join UnitsSold u on p.product_id = u.product_id and u.purchase_date between p.start_date and p.end_date group by 1