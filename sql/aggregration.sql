SELECT * FROM orders;

SELECT * FROM orders  where order_status = 'COMPLETE' or order_status = 'CLOSED';

SELECT * FROM orders  where order_status in ('COMPLETE' , 'CLOSED') group by order_status;

SELECT count(*) FROM orders  where order_status in ('COMPLETE' , 'CLOSED');

SELECT DISTINCT order_status FROM orders  ;

SELECT DISTINCT order_status FROM orders ORDER BY 1 ;


SELECT DISTINCT order_date FROM orders;

SELECT count(DISTINCT order_date) FROM orders;

SELECT sum(order_item_subtotal) FROM order_items WHERE order_item_order_id=2;

SELECT * FROM orders;

SELECT order_status,count(*) as order_count FROM orders GROUP BY 1 ORDER BY 2 DESC;

SELECT order_date,count(*) as order_count FROM orders GROUP BY 1 ORDER BY 2 DESC;

SELECT to_char(order_date,'mm-yyyy') as month,count(*) as order_count FROM orders GROUP BY 1 ORDER BY 1 ASC;

Select order_item_order_id, round(sum(order_item_subtotal)::numeric,2) as total from order_items GROUP BY order_item_order_id ORDER BY 1

SELECT order_status,count(*) as order_count FROM orders GROUP BY 1 HAVING count(*) > 10000 and count(*) < 20000 ORDER BY 2 DESC;








