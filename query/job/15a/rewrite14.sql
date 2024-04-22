create or replace view aggJoin3163569007808013852 as (
with aggView5894900451966115526 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5894900451966115526 where mk.keyword_id=aggView5894900451966115526.v24);
create or replace view aggJoin3609658288665317224 as (
with aggView3236306239495502169 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView3236306239495502169 where mc.company_id=aggView3236306239495502169.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin2516495309009642093 as (
with aggView6953180379302948853 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView6953180379302948853 where t.id=aggView6953180379302948853.v40 and production_year>2000);
create or replace view aggJoin4059373535041810380 as (
with aggView8544931450698029860 as (select v40, MIN(v41) as v53 from aggJoin2516495309009642093 group by v40)
select v40, v53 from aggJoin3163569007808013852 join aggView8544931450698029860 using(v40));
create or replace view aggJoin1909460673704138389 as (
with aggView8087987694734771112 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin3609658288665317224 join aggView8087987694734771112 using(v20));
create or replace view aggJoin1481746336706901156 as (
with aggView916502882816553295 as (select v40 from aggJoin1909460673704138389 group by v40)
select movie_id as v40, info_type_id as v22, info as v35, note as v36 from movie_info as mi, aggView916502882816553295 where mi.movie_id=aggView916502882816553295.v40 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin1398211450478282141 as (
with aggView6515450790183713993 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36 from aggJoin1481746336706901156 join aggView6515450790183713993 using(v22));
create or replace view aggJoin3562007703525618426 as (
with aggView877445887860840203 as (select v40, MIN(v35) as v52 from aggJoin1398211450478282141 group by v40)
select v53 as v53, v52 from aggJoin4059373535041810380 join aggView877445887860840203 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin3562007703525618426;
