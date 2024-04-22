create or replace view aggJoin6895390864016551644 as (
with aggView3385720003655107226 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView3385720003655107226 where mi.info_type_id=aggView3385720003655107226.v21);
create or replace view aggJoin3534279117556170431 as (
with aggView8739641137165892955 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView8739641137165892955 where mc.company_id=aggView8739641137165892955.v1);
create or replace view aggJoin3029029136170744434 as (
with aggView5552787196819787919 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin3534279117556170431 join aggView5552787196819787919 using(v8));
create or replace view aggJoin114804931424129310 as (
with aggView2589078694948924714 as (select v29 from aggJoin3029029136170744434 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2589078694948924714 where t.id=aggView2589078694948924714.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin3461990252997189298 as (
with aggView6268472916556920341 as (select v29, MIN(v30) as v42 from aggJoin114804931424129310 group by v29)
select movie_id as v29, info_type_id as v26, v42 from movie_info_idx as mi_idx, aggView6268472916556920341 where mi_idx.movie_id=aggView6268472916556920341.v29);
create or replace view aggJoin8060239426650945608 as (
with aggView7083787099290236171 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29, v42 from aggJoin3461990252997189298 join aggView7083787099290236171 using(v26));
create or replace view aggJoin2916171930605290914 as (
with aggView1780622225656162950 as (select v29, MIN(v42) as v42 from aggJoin8060239426650945608 group by v29,v42)
select v22, v42 from aggJoin6895390864016551644 join aggView1780622225656162950 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin2916171930605290914;
