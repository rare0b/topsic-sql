select
    EMP_CODE as CODE,
    upper(EMP_ENG_NAME) as ENG_NAME
from
    EMP
order by
    EMP_CODE;