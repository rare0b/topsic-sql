select ITEM_POPULAR_RANK "RANK",ITEM_CODE "CODE",ITEM_NAME "NAME"
from ITEM
where SALE_END_DATE is null
order by ITEM_POPULAR_RANK,ITEM_CODE;