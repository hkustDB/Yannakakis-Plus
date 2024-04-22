create or replace view aggJoin3331875076812579880 as (
with aggView4796983519162777264 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView4796983519162777264 where t.kind_id=aggView4796983519162777264.v21 and production_year>2000);
create or replace view aggJoin8169253817770063289 as (
with aggView6592174687605518633 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin3331875076812579880 group by v36,v48)
select movie_id as v36, company_id as v7, company_type_id as v14, v48, v49 from movie_companies as mc, aggView6592174687605518633 where mc.movie_id=aggView6592174687605518633.v36);
create or replace view aggJoin5101153109100985711 as (
with aggView856535917524549945 as (select id as v14 from company_type as ct)
select v36, v7, v48, v49 from aggJoin8169253817770063289 join aggView856535917524549945 using(v14));
create or replace view aggJoin269760734115613291 as (
with aggView997471733904184258 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView997471733904184258 where mi.info_type_id=aggView997471733904184258.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin7472121984535736927 as (
with aggView3216830859492409459 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView3216830859492409459 where mk.keyword_id=aggView3216830859492409459.v18);
create or replace view aggJoin6218122127839340912 as (
with aggView5319123051573766199 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView5319123051573766199 where cc.status_id=aggView5319123051573766199.v5);
create or replace view aggJoin5290079804315974201 as (
with aggView1362760457142109882 as (select v36 from aggJoin6218122127839340912 group by v36)
select v36, v31, v32 from aggJoin269760734115613291 join aggView1362760457142109882 using(v36));
create or replace view aggJoin2112861082594323073 as (
with aggView3341361507232897941 as (select v36 from aggJoin5290079804315974201 group by v36)
select v36, v7, v48 as v48, v49 as v49 from aggJoin5101153109100985711 join aggView3341361507232897941 using(v36));
create or replace view aggJoin7967443365689571275 as (
with aggView4215139073817068252 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36, v48, v49 from aggJoin2112861082594323073 join aggView4215139073817068252 using(v7));
create or replace view aggJoin2381297437457741219 as (
with aggView6104816493273848562 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin7967443365689571275 group by v36,v49,v48)
select v48, v49 from aggJoin7472121984535736927 join aggView6104816493273848562 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin2381297437457741219;
