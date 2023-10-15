with min_access_log as (
    select
        min(LOGIN_DATETIME) as first_login
    from
        ACCESS_LOG
    group by
        MEMBER_CODE
)
select
    SUBSTR(first_login, 1, 10) FIRST_LOGIN,
    count(*) as MEMBER_CNT
from
    min_access_log
where
    first_login between '2023-08-01 00:00:00'
    and '2023-08-31 23:59:59'
group by
    SUBSTR(first_login, 1, 10)
order by
    first_login desc;