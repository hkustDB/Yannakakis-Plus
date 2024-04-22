create or replace view aggJoin147223630759352956 as (
with aggView4567170445717291845 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, info_type_id as v22, info as v35, note as v36, v53 from movie_info as mi, aggView4567170445717291845 where mi.movie_id=aggView4567170445717291845.v40 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggJoin6961558723980211138 as (
with aggView2600479412420742058 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView2600479412420742058 where mc.company_id=aggView2600479412420742058.v13);
create or replace view aggJoin5521960774708981238 as (
with aggView8650996584237854555 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView8650996584237854555 where mk.keyword_id=aggView8650996584237854555.v24);
create or replace view aggJoin2899358791930758443 as (
with aggView5532924110816072195 as (select id as v20 from company_type as ct)
select v40 from aggJoin6961558723980211138 join aggView5532924110816072195 using(v20));
create or replace view aggJoin2373737831603674872 as (
with aggView6062538967032296572 as (select v40 from aggJoin2899358791930758443 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView6062538967032296572 where aka_t.movie_id=aggView6062538967032296572.v40);
create or replace view aggJoin5917359525242723318 as (
with aggView2175319606619669141 as (select v40 from aggJoin2373737831603674872 group by v40)
select v40, v22, v35, v36, v53 as v53 from aggJoin147223630759352956 join aggView2175319606619669141 using(v40));
create or replace view aggJoin6062952018784029114 as (
with aggView1940322717470827423 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36, v53 from aggJoin5917359525242723318 join aggView1940322717470827423 using(v22));
create or replace view aggJoin6907543531010759403 as (
with aggView8879662464203067739 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin6062952018784029114 group by v40,v53)
select v53, v52 from aggJoin5521960774708981238 join aggView8879662464203067739 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin6907543531010759403;
