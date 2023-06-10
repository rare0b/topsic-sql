select s.PF_CODE "CODE",p.PF_NAME "NAME",
ROUND(cast(s.PROMOTE_MUNICIPALITY as real)/cast(s.MUNICIPALITY_TTL as real)*100,2) "RATIO"
from SDGS s inner join PREFECTURE p
on s.PF_CODE = p.PF_CODE
where s.SURVEY_YEAR = 2022
order by "RATIO" desc, s.PF_CODE;