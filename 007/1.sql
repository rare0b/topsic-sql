select EMP_CODE CODE,EMP_ENG_NAME "NAME",length(EMP_ENG_NAME) WORD_CNT
from EMP
where length(EMP_ENG_NAME) >= 15
order by length(EMP_ENG_NAME) desc,EMP_CODE;