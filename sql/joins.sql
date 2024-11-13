select * 
from orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id


select o.* ,oi.order_item_quantity
from orders as o
JOIN order_items as oi
ON o.order_id = oi.order_item_order_id


select count(DISTINCT order_id) from orders;
select  DISTINCT order_item_order_id from order_items;

select count(DISTINCT order_item_order_id) from order_items;


select o.order_id , o.order_date,
oi.order_item_id,
oi.order_item_product_id,
oi.order_item_subtotal 
from orders as o
LEFT OUTER JOIN order_items as oi
ON o.order_id = oi.order_item_order_id order by order_id



SELECT  o.order_date,
        oi.order_item_product_id,
	    round(sum(oi.order_item_subtotal)::numeric,2) as revenue
FROM orders as o
JOIN order_items as oi
ON oi.order_item_order_id = o.order_id
where o.order_status in ('COMPLETE','CLOSED') 
Group by o.order_date,oi.order_item_product_id 
order by o.order_date, revenue DESC;

-- Views

create or replace view order_details_view 
as 
select o.*, oi.order_item_product_id, oi.order_item_subtotal
from orders as o 
JOIN order_items as oi 
ON o.order_id = oi.order_item_order_id

select * from order_details_view

create or replace view order_details_view 
as 
select o.*, oi.order_item_product_id, oi.order_item_subtotal, oi.order_item_quantity
from orders as o 
JOIN order_items as oi 
ON o.order_id = oi.order_item_order_id


-- CTE
WITH order_details_cte
as 
(select o.*, oi.order_item_product_id, oi.order_item_subtotal, oi.order_item_quantity
from orders as o 
JOIN order_items as oi 
ON o.order_id = oi.order_item_order_id )

SELECT * from order_details_cte where order_status in ('CLOSED')



-- wrong AND condition, to fetch product not sold in 2014-01
select * from products as p 
left outer join order_details_view as odv
on p.product_id = odv.order_item_product_id where odv.order_item_product_id is null
and to_char(odv.order_date::TIMESTAMP,'yyyy-MM') = '2014-01'


-- Correct query as above, 
-- Porduts not sold in 2014-01
select * from products as p 
left outer join order_details_view as odv
on p.product_id = odv.order_item_product_id 
and to_char(odv.order_date::TIMESTAMP,'yyyy-MM') = '2014-01'
where odv.order_item_product_id is null










