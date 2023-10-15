with pre_query as(
    select
        PF_CODE,
        AGE,
        CASE
            WHEN GENDER_CODE = '20' THEN 'MALE'
            WHEN GENDER_CODE = '30' THEN 'FEMALE'
            ELSE NULL
        END GENDER,
        SUM(
            CASE
                WHEN CATEGORY_CODE = '10' THEN AVERAGE_VALUE
                ELSE NULL
            end
        ) "HEIGHT",
        SUM(
            CASE
                WHEN CATEGORY_CODE = '20' THEN AVERAGE_VALUE
                ELSE NULL
            end
        ) "WEIGHT"
    from
        SCHOOL_HEALTH
    where
        survey_year = '2019'
    group by
        PF_CODE,
        AGE,
        GENDER_CODE
),
avg_query as(
    select
        AGE,
        GENDER,
        round(avg(HEIGHT), 1) H_AVG,
        round(avg(WEIGHT), 1) W_AVG
    from
        pre_query
    group by
        AGE,
        GENDER
),
h_count_query as(
    select
        p.age,
        p.gender,
        cast(count(*) as real) h_cnt
    from
        pre_query p
        inner join
            avg_query a
        on  p.age = a.age
        and p.gender = a.gender
    where
        p.height >= a.H_AVG
    group by
        p.age,
        p.gender
),
w_count_query as(
    select
        p.age,
        p.gender,
        cast(count(*) as real) w_cnt
    from
        pre_query p
        inner join
            avg_query a
        on  p.age = a.age
        and p.gender = a.gender
    where
        p.weight >= a.W_AVG
    group by
        p.age,
        p.gender
),
h_all_count_query as (
    select
        p.age,
        p.gender,
        cast(count(*) as real) h_all_cnt
    from
        pre_query p
        inner join
            avg_query a
        on  p.age = a.age
        and p.gender = a.gender
    where
        p.height is not null
    group by
        p.age,
        p.gender
),
w_all_count_query as (
    select
        p.age,
        p.gender,
        cast(count(*) as real) w_all_cnt
    from
        pre_query p
        inner join
            avg_query a
        on  p.age = a.age
        and p.gender = a.gender
    where
        p.weight is not null
    group by
        p.age,
        p.gender
)
select
    a.AGE AGE,
    a.GENDER GENDER,
    a.H_AVG,
    round(h.h_cnt * 100.0 / lh.h_all_cnt, 1) || '%' H_PER,
    a.W_AVG,
    round(w.w_cnt * 100.0 / lw.w_all_cnt, 1) || '%' W_PER
from
    avg_query a
    inner join
        h_count_query h
    on  a.age = h.age
    and a.gender = h.gender
    inner join
        w_count_query w
    on  a.age = w.age
    and a.gender = w.gender
    inner join
        h_all_count_query lh
    on  a.age = lh.age
    and a.gender = lh.gender
    inner join
        w_all_count_query lw
    on  a.age = lw.age
    and a.gender = lw.gender
order by age desc, gender
;