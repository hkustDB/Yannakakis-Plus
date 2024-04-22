create or replace view aggView6199731457078849984 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin9077903313227560448 as (
with aggView8783974202791902817 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8783974202791902817 where t.kind_id=aggView8783974202791902817.v17 and production_year>2005);
create or replace view aggView1862337845869994450 as select v38, v37 from aggJoin9077903313227560448 group by v38,v37;
create or replace view aggJoin574159329100984099 as (
with aggView1740452730871060429 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1740452730871060429 where mi_idx.info_type_id=aggView1740452730871060429.v12 and info<'8.5');
create or replace view aggView1252111535963217193 as select v37, v32 from aggJoin574159329100984099 group by v37,v32;
create or replace view aggJoin5234699222431289156 as (
with aggView6807999677691206078 as (select v37, MIN(v38) as v51 from aggView1862337845869994450 group by v37)
select v37, v32, v51 from aggView1252111535963217193 join aggView6807999677691206078 using(v37));
create or replace view aggJoin4143712905362993473 as (
with aggView6881659798206589021 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin5234699222431289156 group by v37,v51)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView6881659798206589021 where mc.movie_id=aggView6881659798206589021.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8165994995034374022 as (
with aggView2215141139335150574 as (select id as v8 from company_type as ct)
select v37, v1, v23, v51, v50 from aggJoin4143712905362993473 join aggView2215141139335150574 using(v8));
create or replace view aggJoin8277496282341633803 as (
with aggView7735782934401562305 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7735782934401562305 where mi.info_type_id=aggView7735782934401562305.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7320402166587355202 as (
with aggView2074646684289221375 as (select v37 from aggJoin8277496282341633803 group by v37)
select v37, v1, v23, v51 as v51, v50 as v50 from aggJoin8165994995034374022 join aggView2074646684289221375 using(v37));
create or replace view aggJoin2176099254311352254 as (
with aggView7912967019798827663 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView7912967019798827663 where mk.keyword_id=aggView7912967019798827663.v14);
create or replace view aggJoin683562685463011481 as (
with aggView1705986815857764625 as (select v37 from aggJoin2176099254311352254 group by v37)
select v1, v23, v51 as v51, v50 as v50 from aggJoin7320402166587355202 join aggView1705986815857764625 using(v37));
create or replace view aggJoin5665784806188757882 as (
with aggView4810053154956248024 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin683562685463011481 group by v1,v51,v50)
select v2, v51, v50 from aggView6199731457078849984 join aggView4810053154956248024 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5665784806188757882;
