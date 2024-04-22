create or replace view aggJoin4274951508761101252 as (
with aggView4756837882561212935 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView4756837882561212935 where mc.company_id=aggView4756837882561212935.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5204351451662704654 as (
with aggView5012862740981769379 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4274951508761101252 join aggView5012862740981769379 using(v8));
create or replace view aggJoin856006013418478687 as (
with aggView3975202041160562745 as (select v37, MIN(v49) as v49 from aggJoin5204351451662704654 group by v37,v49)
select movie_id as v37, keyword_id as v14, v49 from movie_keyword as mk, aggView3975202041160562745 where mk.movie_id=aggView3975202041160562745.v37);
create or replace view aggJoin6038129420669618618 as (
with aggView7147494864564805335 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView7147494864564805335 where t.kind_id=aggView7147494864564805335.v17 and production_year>2005);
create or replace view aggJoin1191818077894769804 as (
with aggView3469350665708243063 as (select v37, MIN(v38) as v51 from aggJoin6038129420669618618 group by v37)
select movie_id as v37, info_type_id as v12, info as v32, v51 from movie_info_idx as mi_idx, aggView3469350665708243063 where mi_idx.movie_id=aggView3469350665708243063.v37 and info<'8.5');
create or replace view aggJoin6165202770936381800 as (
with aggView5927641880791946741 as (select id as v12 from info_type as it2 where info= 'rating')
select v37, v32, v51 from aggJoin1191818077894769804 join aggView5927641880791946741 using(v12));
create or replace view aggJoin2260382846633572252 as (
with aggView4344812151062621830 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin6165202770936381800 group by v37,v51)
select v37, v14, v49 as v49, v51, v50 from aggJoin856006013418478687 join aggView4344812151062621830 using(v37));
create or replace view aggJoin6025035928785269358 as (
with aggView5653370325584347708 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView5653370325584347708 where mi.info_type_id=aggView5653370325584347708.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3319697557083194418 as (
with aggView6587861276307945442 as (select v37 from aggJoin6025035928785269358 group by v37)
select v14, v49 as v49, v51 as v51, v50 as v50 from aggJoin2260382846633572252 join aggView6587861276307945442 using(v37));
create or replace view aggJoin1629824067770436606 as (
with aggView5995376496411121808 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin3319697557083194418 join aggView5995376496411121808 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1629824067770436606;
