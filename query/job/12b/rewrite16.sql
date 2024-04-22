create or replace view aggJoin5521794641103593551 as (
with aggView4023496792908639556 as (select id as v29, title as v42 from title as t where production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')))
select movie_id as v29, info_type_id as v21, info as v22, v42 from movie_info as mi, aggView4023496792908639556 where mi.movie_id=aggView4023496792908639556.v29);
create or replace view aggJoin2720340432149374244 as (
with aggView4131829819238471255 as (select id as v21 from info_type as it1 where info= 'budget')
select v29, v22, v42 from aggJoin5521794641103593551 join aggView4131829819238471255 using(v21));
create or replace view aggJoin1297826826003420773 as (
with aggView316194103326590601 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView316194103326590601 where mc.company_id=aggView316194103326590601.v1);
create or replace view aggJoin7306739118919376260 as (
with aggView6555740091760260443 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin1297826826003420773 join aggView6555740091760260443 using(v8));
create or replace view aggJoin1493015064222631048 as (
with aggView6888944468828174366 as (select v29 from aggJoin7306739118919376260 group by v29)
select movie_id as v29, info_type_id as v26 from movie_info_idx as mi_idx, aggView6888944468828174366 where mi_idx.movie_id=aggView6888944468828174366.v29);
create or replace view aggJoin8665494080988015499 as (
with aggView7951741045417390965 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29 from aggJoin1493015064222631048 join aggView7951741045417390965 using(v26));
create or replace view aggJoin77661588969620615 as (
with aggView590156872529668779 as (select v29 from aggJoin8665494080988015499 group by v29)
select v22, v42 as v42 from aggJoin2720340432149374244 join aggView590156872529668779 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin77661588969620615;
