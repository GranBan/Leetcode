# Write your MySQL query statement below

with c as (
    select customer_id,
    sum(transaction_type = 'purchase') over (partition by customer_id) as num_purch,
    sum(transaction_type = 'refund') over (partition by customer_id) as num_ref,
    min(transaction_date) over (partition by customer_id order by transaction_date rows between unbounded preceding and unbounded following) as first_order_date,
    max(transaction_date) over (partition by customer_id order by transaction_date rows between unbounded preceding and unbounded following) as last_order_date
    from customer_transactions
)
select distinct c.customer_id from c where c.num_purch >= 3 and datediff(c.last_order_date, c.first_order_date) >= 30 and num_ref * 5 < num_ref + num_purch order by 1