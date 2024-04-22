create or replace view aggJoin1823798859732822431 as (
with aggView1172922341275468784 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView1172922341275468784 where mc.company_type_id=aggView1172922341275468784.v14);
create or replace view aggJoin6791588131641949797 as (
with aggView269552710092844124 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView269552710092844124 where mk.keyword_id=aggView269552710092844124.v18);
create or replace view aggJoin8304603805122436997 as (
with aggView4746830440688358021 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView4746830440688358021 where mi.info_type_id=aggView4746830440688358021.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin3748809365275307245 as (
with aggView2849322823151081427 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2849322823151081427 where cc.status_id=aggView2849322823151081427.v5);
create or replace view aggJoin2913422891145732288 as (
with aggView8080131157040335980 as (select v36 from aggJoin3748809365275307245 group by v36)
select v36 from aggJoin6791588131641949797 join aggView8080131157040335980 using(v36));
create or replace view aggJoin1338850164754001577 as (
with aggView8680698157921889725 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1823798859732822431 join aggView8680698157921889725 using(v7));
create or replace view aggJoin7984669187658925691 as (
with aggView3337980530909871930 as (select v36 from aggJoin1338850164754001577 group by v36)
select v36 from aggJoin2913422891145732288 join aggView3337980530909871930 using(v36));
create or replace view aggJoin774666589033707725 as (
with aggView2681440175278217041 as (select v36 from aggJoin7984669187658925691 group by v36)
select v36, v31, v32 from aggJoin8304603805122436997 join aggView2681440175278217041 using(v36));
create or replace view aggJoin3077372673840438529 as (
with aggView5286023173008084758 as (select v36 from aggJoin774666589033707725 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView5286023173008084758 where t.id=aggView5286023173008084758.v36 and production_year>2000);
create or replace view aggView6390921281826969544 as select v21, v37 from aggJoin3077372673840438529 group by v21,v37;
create or replace view aggJoin652904565382206144 as (
with aggView1874782052241799291 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView6390921281826969544 join aggView1874782052241799291 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin652904565382206144;
