create or replace view aggView2954379641693723025 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1500654258453972448 as (
with aggView7659517627736102244 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7659517627736102244 where mi_idx.info_type_id=aggView7659517627736102244.v12 and info<'7.0');
create or replace view aggView460010961886602215 as select v32, v37 from aggJoin1500654258453972448 group by v32,v37;
create or replace view aggJoin1871579449544657279 as (
with aggView2881669427794670659 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView2881669427794670659 where t.kind_id=aggView2881669427794670659.v17 and production_year>2008);
create or replace view aggView6306903951772299840 as select v38, v37 from aggJoin1871579449544657279 group by v38,v37;
create or replace view aggJoin9217784279057516202 as (
with aggView823501789558699036 as (select v37, MIN(v32) as v50 from aggView460010961886602215 group by v37)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50 from movie_companies as mc, aggView823501789558699036 where mc.movie_id=aggView823501789558699036.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4036445653344020799 as (
with aggView1114099371527670331 as (select v1, MIN(v2) as v49 from aggView2954379641693723025 group by v1)
select v37, v8, v23, v50 as v50, v49 from aggJoin9217784279057516202 join aggView1114099371527670331 using(v1));
create or replace view aggJoin5638828634335873170 as (
with aggView6162204382056020829 as (select id as v8 from company_type as ct)
select v37, v23, v50, v49 from aggJoin4036445653344020799 join aggView6162204382056020829 using(v8));
create or replace view aggJoin8298282998794747037 as (
with aggView2501646792613394945 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2501646792613394945 where mi.info_type_id=aggView2501646792613394945.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin4537413775723647901 as (
with aggView6629614399812167817 as (select v37 from aggJoin8298282998794747037 group by v37)
select movie_id as v37, keyword_id as v14 from movie_keyword as mk, aggView6629614399812167817 where mk.movie_id=aggView6629614399812167817.v37);
create or replace view aggJoin1275725777545388326 as (
with aggView6752730134287658262 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v37 from aggJoin4537413775723647901 join aggView6752730134287658262 using(v14));
create or replace view aggJoin5535081705679791353 as (
with aggView5939715021791998025 as (select v37 from aggJoin1275725777545388326 group by v37)
select v37, v23, v50 as v50, v49 as v49 from aggJoin5638828634335873170 join aggView5939715021791998025 using(v37));
create or replace view aggJoin9099914748886148216 as (
with aggView9040739573579036417 as (select v37, MIN(v50) as v50, MIN(v49) as v49 from aggJoin5535081705679791353 group by v37,v49,v50)
select v38, v50, v49 from aggView6306903951772299840 join aggView9040739573579036417 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin9099914748886148216;
