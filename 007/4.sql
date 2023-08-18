with summary as (
    select sum(UNITPRICE*SALES_QTY) as sum
    from sales s
    inner join sales_dtl d
    on s.sales_no = d.sales_no
    where s.sales_date between '2023-06-01' and '2023-06-30'
),
sum_per_item as (
    select d.item_code, sum(UNITPRICE*SALES_QTY) as sum_item
    from sales s
    inner join sales_dtl d
    on s.sales_no = d.sales_no
    where s.sales_date between '2023-06-01' and '2023-06-30'
    group by d.item_code
    order by sum(UNITPRICE*SALES_QTY)
)
select round(sum_item / sum *, 1)
from summary s, sum_per_item i;