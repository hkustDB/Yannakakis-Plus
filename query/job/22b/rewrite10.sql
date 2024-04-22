create or replace view aggJoin1776110580508586675 as (
with aggView2419371221683934018 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView2419371221683934018 where mc.company_id=aggView2419371221683934018.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3612229669971502970 as (
with aggView1768161313718251468 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1768161313718251468 where mi_idx.info_type_id=aggView1768161313718251468.v12 and info<'7.0');
create or replace view aggJoin1226633798699966131 as (
with aggView2928119207188405944 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin1776110580508586675 join aggView2928119207188405944 using(v8));
create or replace view aggJoin8440279700855710005 as (
with aggView2712499602788284257 as (select v37, MIN(v49) as v49 from aggJoin1226633798699966131 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView2712499602788284257 where t.id=aggView2712499602788284257.v37 and production_year>2009);
create or replace view aggJoin7054379932572084479 as (
with aggView6388704311202251145 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin8440279700855710005 join aggView6388704311202251145 using(v17));
create or replace view aggJoin3019662269408498042 as (
with aggView4469813738225552983 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin7054379932572084479 group by v37,v49)
select v37, v32, v49, v51 from aggJoin3612229669971502970 join aggView4469813738225552983 using(v37));
create or replace view aggJoin9181541921579246442 as (
with aggView8883051873181021492 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView8883051873181021492 where mi.info_type_id=aggView8883051873181021492.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin2237977827865356854 as (
with aggView8204820708230312132 as (select v37 from aggJoin9181541921579246442 group by v37)
select v37, v32, v49 as v49, v51 as v51 from aggJoin3019662269408498042 join aggView8204820708230312132 using(v37));
create or replace view aggJoin6471951473301020716 as (
with aggView7463609105175006457 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin2237977827865356854 group by v37,v49,v51)
select keyword_id as v14, v49, v51, v50 from movie_keyword as mk, aggView7463609105175006457 where mk.movie_id=aggView7463609105175006457.v37);
create or replace view aggJoin4541403892556071689 as (
with aggView5734448766464208053 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin6471951473301020716 join aggView5734448766464208053 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4541403892556071689;
