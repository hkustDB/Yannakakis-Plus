create or replace view aggView1640541142329143694 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1076938127351318375 as (
with aggView4832361674337866559 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4832361674337866559 where mi_idx.info_type_id=aggView4832361674337866559.v12 and info<'7.0');
create or replace view aggJoin3268455867748733472 as (
with aggView1362253497004911971 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1362253497004911971 where t.kind_id=aggView1362253497004911971.v17 and production_year>2008);
create or replace view aggView323960285343894791 as select v38, v37 from aggJoin3268455867748733472 group by v38,v37;
create or replace view aggJoin2808953211753617084 as (
with aggView5716376547322971959 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView5716376547322971959 where mi.info_type_id=aggView5716376547322971959.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin8184094789108871246 as (
with aggView4178479805840124311 as (select v37 from aggJoin2808953211753617084 group by v37)
select v37, v32 from aggJoin1076938127351318375 join aggView4178479805840124311 using(v37));
create or replace view aggView5756172056735667358 as select v32, v37 from aggJoin8184094789108871246 group by v32,v37;
create or replace view aggJoin4595261245688705388 as (
with aggView2756136041939195840 as (select v37, MIN(v38) as v51 from aggView323960285343894791 group by v37)
select v32, v37, v51 from aggView5756172056735667358 join aggView2756136041939195840 using(v37));
create or replace view aggJoin6508711827411993057 as (
with aggView4930959384253375443 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin4595261245688705388 group by v37,v51)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView4930959384253375443 where mc.movie_id=aggView4930959384253375443.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8967368837093752183 as (
with aggView6337888103047985227 as (select id as v8 from company_type as ct)
select v37, v1, v23, v51, v50 from aggJoin6508711827411993057 join aggView6337888103047985227 using(v8));
create or replace view aggJoin6391212100334158352 as (
with aggView3280583741594412617 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView3280583741594412617 where mk.keyword_id=aggView3280583741594412617.v14);
create or replace view aggJoin2280559778123930828 as (
with aggView7512635213792762527 as (select v37 from aggJoin6391212100334158352 group by v37)
select v1, v23, v51 as v51, v50 as v50 from aggJoin8967368837093752183 join aggView7512635213792762527 using(v37));
create or replace view aggJoin7667781324573392313 as (
with aggView36155583245375806 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin2280559778123930828 group by v1,v50,v51)
select v2, v51, v50 from aggView1640541142329143694 join aggView36155583245375806 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7667781324573392313;
