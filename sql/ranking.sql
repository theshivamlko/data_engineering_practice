
-- CTAS
create table order_count_by_status AS
select order_status, count(*) as order_count 
from orders where true GROUP by 1

select * from order_count_by_status

create table daily_product_revenue AS
select o.order_date, oi.order_item_product_id,
round(sum(oi.order_item_subtotal)::numeric,2) as order_revenue
from orders as o 
JOIN order_items as oi 
on o.order_id=oi.order_item_order_id
where o.order_status in ('COMPLETE','CLOSED')
Group by 1,2

select order_date from daily_product_revenue group by 1 order by 1


SELECT to_char(dr.order_date::timestamp,'yyyy-MM') as order_month, 
dr.order_date, dr.order_revenue, 

sum(order_revenue) OVER (PARTITION BY to_char(dr.order_date::timestamp,'yyyy-MM')) as order_monthly_revenue 

from daily_product_revenue as dr
ORDER by 2


SELECT dr.*, 
sum(order_revenue) OVER (PARTITION BY 1) as total_order_revenue 
from daily_product_revenue as dr
ORDER by 1

select count(*) as total FROM daily_product_revenue;
select *  FROM daily_product_revenue order by order_date,order_revenue desc;

-- RANK() OVER

SELECT dr.order_date,dr.order_item_product_id,dr.order_revenue,
rank() over (order by dr.order_revenue desc) as rnk,
dense_rank() over (order by dr.order_revenue desc) as drnk
from daily_product_revenue as dr
where dr.order_date ='2014-01-01 00:00:00.0'
order by order_revenue desc


SELECT dr.order_date,dr.order_item_product_id,dr.order_revenue,
rank() over (PARTITION BY dr.order_date order by dr.order_revenue desc) as rnk,
dense_rank() over (PARTITION by dr.order_date order by dr.order_revenue desc) as drnk
from daily_product_revenue as dr
where dr.order_date ='2014-01-01 00:00:00.0'
order by order_revenue desc













