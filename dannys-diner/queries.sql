-- 1. What is the total amount each customer spent at the restaurant?
select customer_id, sum(price) as total_amt
from sales s
left join menu m
on s.product_id = m.product_id
group by customer_id
order by customer_id;

-- 2. How many days has each customer visited the restaurant?
select customer_id, count(distinct order_date) as visits
from sales 
group by customer_id
order by visits desc;

-- 3. What was the first item from the menu purchased by each customer?
select customer_id, product_id
from (select *,
	dense_rank() over(partition by customer_id
    order by order_date) as rnk
from sales) as t
where rnk = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select product_id, count(product_id) cnt
from sales
group by product_id
order by cnt desc
limit 1;

-- 5. Which item was the most popular for each customer?
select customer_id, product_id
from
(select *,
	dense_rank() over(partition by customer_id
    order by cnt desc) as popular
	from 
		(select customer_id,product_id, count(product_id) as cnt
		from sales
		group by customer_id, product_id
		order by customer_id, product_id desc) t1) t2
where popular=1;

-- 6. Which item was purchased first by the customer after they became a member?
select customer_id,product_id
from
(select *,
	rank() over(partition by customer_id
    order by order_date) as ord_rnk
	from(select s.customer_id, product_id,order_date
		from sales s
		join members m
		on s.customer_id = m.customer_id
		where order_date>=join_date
		order by order_date) t )t2
where ord_rnk=1;

-- 7. Which item was purchased just before the customer became a member?
select customer_id, product_id
from
	(select *,
		dense_rank() over(partition by customer_id
		order by order_date desc) as ord_rnk
	from(select s.customer_id, product_id, order_date
			from sales s
			join members m
			on s.customer_id = m.customer_id
			where order_date < join_date) t) t2
where ord_rnk = 1
;

-- 8. What is the total items and amount spent for each member before they became a member?
select c.customer_id, count(m.product_id) as prd_cnt, sum(price) as tot_amt
from members c
left join sales s
on c.customer_id = s.customer_id
and order_date < join_date
left join menu m
on s.product_id = m.product_id
group by c.customer_id;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
-- how many points would each customer have?
select customer_id,
sum(case
	when product_name='sushi' then price*10*2
    else price*10
end) as points
from sales s
join menu m
on s.product_id = m.product_id
group by customer_id;

-- 10. In the first week after a customer joins the program (including their join date) 
-- they earn 2x points on all items, not just sushi 
-- how many points do customer A and B have at the end of January?
select s.customer_id, s.product_id, price,
	sum(case
		when order_date between join_date and join_date+interval 6 day then price*10*2
        else price*10
	end) as points
from sales s
join members m
on s.customer_id = m.customer_id
join menu mn
on s.product_id = mn.product_id
where order_date between '2021-01-01' and '2021-01-31'
group by customer_id
order by customer_id;

