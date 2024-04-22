create or replace view aggView6657642841601869222 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin6695395701791487334 as (
with aggView8313563521419691497 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView8313563521419691497 where mi_idx.info_type_id=aggView8313563521419691497.v12 and info<'7.0');
create or replace view aggView6039509924855175130 as select v32, v37 from aggJoin6695395701791487334 group by v32,v37;
create or replace view aggJoin5574392428686910160 as (
with aggView6882758672364200706 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6882758672364200706 where t.kind_id=aggView6882758672364200706.v17 and production_year>2008);
create or replace view aggJoin1698697760967301566 as (
with aggView9210333517983006927 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView9210333517983006927 where mi.info_type_id=aggView9210333517983006927.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin8780101146451588399 as (
with aggView957514992119757564 as (select v37 from aggJoin1698697760967301566 group by v37)
select v37, v38, v41 from aggJoin5574392428686910160 join aggView957514992119757564 using(v37));
create or replace view aggJoin3497275346584947410 as (
with aggView4564795159413358528 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView4564795159413358528 where mk.keyword_id=aggView4564795159413358528.v14);
create or replace view aggJoin4230271614939603326 as (
with aggView8716169337131063492 as (select v37 from aggJoin3497275346584947410 group by v37)
select v37, v38, v41 from aggJoin8780101146451588399 join aggView8716169337131063492 using(v37));
create or replace view aggView3794450192795318503 as select v38, v37 from aggJoin4230271614939603326 group by v38,v37;
create or replace view aggJoin8185079300964516475 as (
with aggView4643876852084914707 as (select v37, MIN(v32) as v50 from aggView6039509924855175130 group by v37)
select v38, v37, v50 from aggView3794450192795318503 join aggView4643876852084914707 using(v37));
create or replace view aggJoin8464919108385945168 as (
with aggView6520260148450370353 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin8185079300964516475 group by v37,v50)
select company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView6520260148450370353 where mc.movie_id=aggView6520260148450370353.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7653205437048246780 as (
with aggView5757858125719472865 as (select id as v8 from company_type as ct)
select v1, v23, v50, v51 from aggJoin8464919108385945168 join aggView5757858125719472865 using(v8));
create or replace view aggJoin5539451203647000557 as (
with aggView5042680087958217843 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin7653205437048246780 group by v1,v50,v51)
select v2, v50, v51 from aggView6657642841601869222 join aggView5042680087958217843 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5539451203647000557;
