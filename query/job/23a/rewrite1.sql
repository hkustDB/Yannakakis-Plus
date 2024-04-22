create or replace view aggJoin2540843930725771763 as (
with aggView4388759059133440229 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView4388759059133440229 where mc.company_type_id=aggView4388759059133440229.v14);
create or replace view aggJoin1447730896643730013 as (
with aggView4331107009217476192 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView4331107009217476192 where mk.keyword_id=aggView4331107009217476192.v18);
create or replace view aggJoin5296520622521211153 as (
with aggView5957136639019933928 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView5957136639019933928 where mi.info_type_id=aggView5957136639019933928.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin2596596826917940997 as (
with aggView2544800258905225780 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView2544800258905225780 where cc.status_id=aggView2544800258905225780.v5);
create or replace view aggJoin6388590577117757990 as (
with aggView617584201877990667 as (select v36 from aggJoin5296520622521211153 group by v36)
select v36 from aggJoin1447730896643730013 join aggView617584201877990667 using(v36));
create or replace view aggJoin7130617051649287137 as (
with aggView7600464679269576043 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin2540843930725771763 join aggView7600464679269576043 using(v7));
create or replace view aggJoin9004483976834535647 as (
with aggView1354604827081663756 as (select v36 from aggJoin7130617051649287137 group by v36)
select v36 from aggJoin2596596826917940997 join aggView1354604827081663756 using(v36));
create or replace view aggJoin3882394865734805824 as (
with aggView8631640873995098717 as (select v36 from aggJoin9004483976834535647 group by v36)
select v36 from aggJoin6388590577117757990 join aggView8631640873995098717 using(v36));
create or replace view aggJoin1839571941527615243 as (
with aggView7340271074799821308 as (select v36 from aggJoin3882394865734805824 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView7340271074799821308 where t.id=aggView7340271074799821308.v36 and production_year>2000);
create or replace view aggView1610760349716477535 as select v21, v37 from aggJoin1839571941527615243 group by v21,v37;
create or replace view aggJoin8305951694085466841 as (
with aggView2806885892152349230 as (select v21, MIN(v37) as v49 from aggView1610760349716477535 group by v21)
select kind as v22, v49 from kind_type as kt, aggView2806885892152349230 where kt.id=aggView2806885892152349230.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin8305951694085466841;
