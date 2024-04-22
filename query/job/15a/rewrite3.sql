create or replace view aggView2111695890660360230 as select title as v41, id as v40 from title as t where production_year>2000;
create or replace view aggJoin8602215161076591011 as (
with aggView5314499741199209280 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView5314499741199209280 where mk.keyword_id=aggView5314499741199209280.v24);
create or replace view aggJoin5345051413672760472 as (
with aggView8263124983625304628 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8263124983625304628 where mc.company_id=aggView8263124983625304628.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin8932693475890449241 as (
with aggView4304609965075039874 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin5345051413672760472 join aggView4304609965075039874 using(v20));
create or replace view aggJoin2117127323569302634 as (
with aggView6226724392436548434 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView6226724392436548434 where mi.info_type_id=aggView6226724392436548434.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin4424477444193926664 as (
with aggView8011269418089947001 as (select v40 from aggJoin8932693475890449241 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView8011269418089947001 where aka_t.movie_id=aggView8011269418089947001.v40);
create or replace view aggJoin7903768757667250097 as (
with aggView334881689512044238 as (select v40 from aggJoin4424477444193926664 group by v40)
select v40 from aggJoin8602215161076591011 join aggView334881689512044238 using(v40));
create or replace view aggJoin5300828084210598634 as (
with aggView82614472520799930 as (select v40 from aggJoin7903768757667250097 group by v40)
select v40, v35, v36 from aggJoin2117127323569302634 join aggView82614472520799930 using(v40));
create or replace view aggView7694760183086864636 as select v35, v40 from aggJoin5300828084210598634 group by v35,v40;
create or replace view aggJoin475094520570981770 as (
with aggView9010970859009775794 as (select v40, MIN(v41) as v53 from aggView2111695890660360230 group by v40)
select v35, v53 from aggView7694760183086864636 join aggView9010970859009775794 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin475094520570981770;
