select d.ITEM_CODE CODE, i.ITEM_NAME "NAME",
       SUM(d.UNITPRICE*d.ORDER_QTY) TOTAL_AMT
from ORDERS o
inner join ORDERS_DTL d
on o.ORDER_NO = d.ORDER_NO
inner join ITEM i
on d.ITEM_CODE = i.ITEM_CODE
where o.ORDER_DATE between '2023-05-14' and '2023-05-20'
group by d.ITEM_CODE, i.ITEM_NAME
order by SUM(d.UNITPRICE*d.ORDER_QTY) desc, i.ITEM_CODE desc
limit 5;