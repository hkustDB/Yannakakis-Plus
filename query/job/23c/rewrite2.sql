create or replace view aggJoin8696666725111551944 as (
with aggView5682198069262626471 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5682198069262626471 where mi.info_type_id=aggView5682198069262626471.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2394816268943909788 as (
with aggView7874089847462822314 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView7874089847462822314 where mc.company_type_id=aggView7874089847462822314.v14);
create or replace view aggJoin175951404358028869 as (
with aggView1189651877302084411 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView1189651877302084411 where mk.keyword_id=aggView1189651877302084411.v18);
create or replace view aggJoin6358327160204189976 as (
with aggView339318182644732595 as (select v36 from aggJoin8696666725111551944 group by v36)
select movie_id as v36, status_id as v5 from complete_cast as cc, aggView339318182644732595 where cc.movie_id=aggView339318182644732595.v36);
create or replace view aggJoin6162425539100946300 as (
with aggView202043779308581930 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2394816268943909788 join aggView202043779308581930 using(v7));
create or replace view aggJoin6717541289373310440 as (
with aggView4948971953923594824 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36 from aggJoin6358327160204189976 join aggView4948971953923594824 using(v5));
create or replace view aggJoin5701460320876702607 as (
with aggView5829606902000502803 as (select v36 from aggJoin6162425539100946300 group by v36)
select v36 from aggJoin6717541289373310440 join aggView5829606902000502803 using(v36));
create or replace view aggJoin6853351673343134285 as (
with aggView8248339603348078393 as (select v36 from aggJoin5701460320876702607 group by v36)
select v36 from aggJoin175951404358028869 join aggView8248339603348078393 using(v36));
create or replace view aggJoin8978420419532487330 as (
with aggView9145038421389927669 as (select v36 from aggJoin6853351673343134285 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView9145038421389927669 where t.id=aggView9145038421389927669.v36 and production_year>1990);
create or replace view aggView4621730765104437313 as select v37, v21 from aggJoin8978420419532487330 group by v37,v21;
create or replace view aggJoin4937150380562050039 as (
with aggView890206427257337802 as (select id as v21, kind as v48 from kind_type as kt where kind IN ('movie','tv movie','video movie','video game'))
select v37, v48 from aggView4621730765104437313 join aggView890206427257337802 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin4937150380562050039;
