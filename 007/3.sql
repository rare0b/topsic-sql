delete from ITEM as i
where not exists (
    select 1
    from STOCK as s
    where s.ITEM_CODE = i.ITEM_CODE
)
or exists (
    select 1
    from STOCK as s
    where s.ITEM_CODE = i.ITEM_CODE
    and LAST_DELIVERY_DATE is not null
    and i.STOCK_MANAGEMENT_TYPE = 1
    and s.ITEM_CODE in (
        select ITEM_CODE
        from STOCK
        group by ITEM_CODE
        having max(LAST_DELIVERY_DATE) < '2023-01-01'
    )
    and s.ACTUAL_AMT = 0
);