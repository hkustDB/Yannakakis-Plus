create or replace view aggJoin107957355597168871 as (
with aggView2210664782329667864 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2210664782329667864 where mc.company_id=aggView2210664782329667864.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3265076807207852814 as (
with aggView322966954888233504 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView322966954888233504 where t.kind_id=aggView322966954888233504.v25 and production_year>2005);
create or replace view aggJoin5091228548056221447 as (
with aggView5614631242977033668 as (select v45, MIN(v46) as v59 from aggJoin3265076807207852814 group by v45)
select movie_id as v45, keyword_id as v22, v59 from movie_keyword as mk, aggView5614631242977033668 where mk.movie_id=aggView5614631242977033668.v45);
create or replace view aggJoin6721093999253397770 as (
with aggView8111565570393434535 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView8111565570393434535 where cc.subject_id=aggView8111565570393434535.v5);
create or replace view aggJoin5146565048857131830 as (
with aggView7941017430593212126 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7941017430593212126 where mi_idx.info_type_id=aggView7941017430593212126.v20 and info<'8.5');
create or replace view aggJoin1129418728421738974 as (
with aggView5456201080458532249 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin107957355597168871 join aggView5456201080458532249 using(v16));
create or replace view aggJoin4325436912828400670 as (
with aggView5545951084524800061 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin6721093999253397770 join aggView5545951084524800061 using(v7));
create or replace view aggJoin2289450914440089636 as (
with aggView8177425458577343664 as (select v45 from aggJoin4325436912828400670 group by v45)
select v45, v31, v57 as v57 from aggJoin1129418728421738974 join aggView8177425458577343664 using(v45));
create or replace view aggJoin141363851232096078 as (
with aggView304074091969170299 as (select v45, MIN(v57) as v57 from aggJoin2289450914440089636 group by v45)
select v45, v40, v57 from aggJoin5146565048857131830 join aggView304074091969170299 using(v45));
create or replace view aggJoin5602779707335702345 as (
with aggView8046716175543222297 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin141363851232096078 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v57, v58 from movie_info as mi, aggView8046716175543222297 where mi.movie_id=aggView8046716175543222297.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1513459060700568684 as (
with aggView4233407529491702453 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v57, v58 from aggJoin5602779707335702345 join aggView4233407529491702453 using(v18));
create or replace view aggJoin2523781047463567942 as (
with aggView7831377934350447320 as (select v45, MIN(v57) as v57, MIN(v58) as v58 from aggJoin1513459060700568684 group by v45)
select v22, v59 as v59, v57, v58 from aggJoin5091228548056221447 join aggView7831377934350447320 using(v45));
create or replace view aggJoin6247589127189994794 as (
with aggView6804873549086475042 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v59, v57, v58 from aggJoin2523781047463567942 join aggView6804873549086475042 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin6247589127189994794;
