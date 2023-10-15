with base_query as (
    select
        MEMBER_CODE,
        ORDER_DATETIME,
        lag(ORDER_DATETIME) OVER (
            partition by MEMBER_CODE
            order by
                ORDER_DATETIME
        ) as LAG_ORDER_DATETIME
    from
        EC_ORDERS
)
select
    min(ORDER_DATETIME) as ORDER_DATE,
    e.MEMBER_CODE as CODE,
    case
        when OPTOUT_TYPE = 0 then '可'
        when OPTOUT_TYPE = 1 then '不可'
        else '不明'
    end as OPTOUT
from
    base_query e
    inner join MEMBER_MST m on e.MEMBER_CODE = m.MEMBER_CODE
where
    ORDER_DATETIME between '2023-07-01 00:00:00'
    and '2023-07-31 23:59:59'
    and LAG_ORDER_DATETIME < datetime(
        date(
            strftime('%Y-%m-%d %H:%M:%S', ORDER_DATETIME, '-1 year')
        ),
        '00:00:00'
    )
group by
    e.MEMBER_CODE,
    LAG_ORDER_DATETIME
order by
    min(ORDER_DATETIME) desc,
    e.MEMBER_CODE desc;

-- select
--     min(ORDER_DATETIME) OVER (
--         partition by MEMBER_CODE
--         order by
--             ORDER_DATETIME
--     ),
--     lag(ORDER_DATETIME) OVER (
--         partition by MEMBER_CODE
--         order by
--             ORDER_DATETIME
--     ),
--     MEMBER_CODE
-- from
--     EC_ORDERS
-- where
--     ORDER_DATETIME between '2023-07-01 00:00:00'
--     and '2023-07-31 23:59:59'
-- order by
--     ORDER_DATETIME,
--     MEMBER_CODE;