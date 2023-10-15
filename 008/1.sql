select member_id ID, score1 - score2 DIFF
from contest_results
where abs(score1 - score2) >= 20
order by diff desc, member_id desc;