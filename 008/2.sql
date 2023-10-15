select c.CUST_CODE CODE,c.CUST_NAME "NAME",count(distinct ORDER_DATE) CNT
from CUSTOMER c
inner join ORDERS o
on c.CUST_CODE = o.CUST_CODE
where o.ORDER_DATE between '2023-07-01' and '2023-07-31'
group by c.CUST_CODE,c.CUST_NAME
order by CNT desc,CODE desc;
