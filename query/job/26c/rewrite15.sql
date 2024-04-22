create or replace view aggJoin3777142402129881387 as (
with aggView214535619202546344 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView214535619202546344 where ci.person_role_id=aggView214535619202546344.v9);
create or replace view aggJoin2114999243944446960 as (
with aggView5698460289145185745 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView5698460289145185745 where cc.status_id=aggView5698460289145185745.v7);
create or replace view aggJoin1961054033851404735 as (
with aggView6473829757088371885 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin2114999243944446960 join aggView6473829757088371885 using(v5));
create or replace view aggJoin1264219067382344307 as (
with aggView7268054035160031716 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView7268054035160031716 where mi_idx.info_type_id=aggView7268054035160031716.v23);
create or replace view aggJoin8598974438450128488 as (
with aggView4899017873367410193 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4899017873367410193 where t.kind_id=aggView4899017873367410193.v28 and production_year>2000);
create or replace view aggJoin1510031734042929355 as (
with aggView7071044527136807901 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView7071044527136807901 where mk.keyword_id=aggView7071044527136807901.v25);
create or replace view aggJoin3306160700498182748 as (
with aggView6741354329514011922 as (select v47 from aggJoin1510031734042929355 group by v47)
select v47, v48, v51 from aggJoin8598974438450128488 join aggView6741354329514011922 using(v47));
create or replace view aggJoin8304474714772853969 as (
with aggView4967508497638593097 as (select v47, MIN(v48) as v61 from aggJoin3306160700498182748 group by v47)
select v47, v33, v61 from aggJoin1264219067382344307 join aggView4967508497638593097 using(v47));
create or replace view aggJoin583755174105912173 as (
with aggView3065735862396905740 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin8304474714772853969 group by v47,v61)
select v38, v47, v59 as v59, v61, v60 from aggJoin3777142402129881387 join aggView3065735862396905740 using(v47));
create or replace view aggJoin9180816630655962658 as (
with aggView3552843674778337000 as (select v47 from aggJoin1961054033851404735 group by v47)
select v38, v59 as v59, v61 as v61, v60 as v60 from aggJoin583755174105912173 join aggView3552843674778337000 using(v47));
create or replace view aggJoin5158437309718034862 as (
with aggView7441109595193262138 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin9180816630655962658 join aggView7441109595193262138 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin5158437309718034862;
