SELECT* FROM shopping_behavior.customer LIMIT 10;

select Gender ,sum(`Purchase Amount (USD)`)as revenue 
from customer 
group by Gender;

--Discount user who still spent above average

select `Customer ID`,`Purchase Amount (USD)`
from customer
where `Discount Applied`= 'Yes'
and `Purchase Amount (USD)` > (select avg(`Purchase Amount (USD)`) from customer)
order by `Purchase Amount (USD)` desc; 

--Top 5 products by review rating

Select `Item Purchased`, round(avg(`Review Rating`),2 )as avg_rating
from customer
group by `Item Purchased`
order by avg_rating desc
limit 5;

--Average purchase 
select `Shipping Type`,round(avg(`PurchaseAmount(USD)`,2)as avg_purchase
from customer
where `Shipping Tyoe` in ('Standard','Express')
group by `Shipping Type`;

--Subscriber vs non subscriber

select `Subscription Status`,
   count(*) as customers,
   round(avg(`Purchase Amount (USD)`),2)as avg_spend,
sum(`Purchase Amount(USD)`) as total_revenue
from customer
group by `Subscription Status`;

--top 5 products by discount percentage

select `Item Purchased`,
        round(100 * sum(case when `Discount Applied` ='Yes' then 1 else 0 end)/ count (*) ,2) as discount_pct
 from customer 
 group by `Item Purchased`
 order by discount_pct desc
 limit 5;

--segment :New ,Returning,Loyal

with segments as(
     select `Customer ID`,
            case when `Previous Purchases` <=1 then 'New' 
				 when `Previous Purchases` between 2 and 10 then 'Returning'
			     else 'loyal' end as segment
		from customer
)
select segment, count (*) as customers
from segments 
group by segments;

--Top 3 most purchased products per category

  with ranked as (
     select Category, `Item Purchased`, count (*) as orders,
               row_number() over (partition by category order by count (*) desc as rnk
from customer
group by Category, `Item Purchased`
)
        Select * from ranked where rnk <=3;
  
  --Do repeat buyers (more than 5 purchases)
  
  select case when `Previous Purchases` > 5 then 'Repeat (>5)' else 'Not repeat(<=5)' end as buyer _type,
		count (*) as customers,
		sum(case when `Subscription Status` = 'Yes' then 1 else 0 end) as subscribers,
        round (100 * sum(case when `Subscription Status`= 'Yes' then 1 else 0 end) / count (*),2) as subcribe_pct
        from customer 
        group by buyer_type;

--Revenue contribution by age group
Describe customer;
show databases;
use shopping_behavior;
show tables;
Select* from customer limit 10;
select
     case
           when Age between 18 and 25 then 
           '18-25'
            when Age between 26 and 35 then
            '26-35'
            when Age between 36 and 45 then
            '36-45'
            when Age between 46 and 55 then 
            '46-55'
            else '56+' 
            end as age_group,
			sum(`Purchase Amount (USD)`) as revenue,
            round(100 * sum(`Purchase Amount (USD)`) / (select sum(`Purchase Amount (USD)`) from customer),2) as pct_of_total
from customer 
group by age_group
order by revenue desc;

select sum(`Purchase Amount (USD)`)
from customer;




