create or replace view aggJoin7043624742337944459 as (
with aggView4122973463361704371 as (select id as v40, title as v53 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v40, company_id as v13, company_type_id as v20, note as v31, v53 from movie_companies as mc, aggView4122973463361704371 where mc.movie_id=aggView4122973463361704371.v40 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin8570408177574152183 as (
with aggView4169388783520098463 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40, v13, v20, v31, v53 as v53 from aggJoin7043624742337944459 join aggView4169388783520098463 using(v40));
create or replace view aggJoin773314779865486075 as (
with aggView1388585756205308567 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1388585756205308567 where mi.info_type_id=aggView1388585756205308567.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin8183493593664340324 as (
with aggView2791712441034854122 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select v40, v20, v31, v53 from aggJoin8570408177574152183 join aggView2791712441034854122 using(v13));
create or replace view aggJoin4127920214833419020 as (
with aggView5391776714654345952 as (select id as v20 from company_type as ct)
select v40, v31, v53 from aggJoin8183493593664340324 join aggView5391776714654345952 using(v20));
create or replace view aggJoin6353497525085072819 as (
with aggView5364350290785404416 as (select v40, MIN(v53) as v53 from aggJoin4127920214833419020 group by v40,v53)
select v40, v35, v36, v53 from aggJoin773314779865486075 join aggView5364350290785404416 using(v40));
create or replace view aggJoin5386823968946401183 as (
with aggView7185225174850982087 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin6353497525085072819 group by v40,v53)
select keyword_id as v24, v53, v52 from movie_keyword as mk, aggView7185225174850982087 where mk.movie_id=aggView7185225174850982087.v40);
create or replace view aggJoin2314069804322490741 as (
with aggView2246641618148280893 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin5386823968946401183 join aggView2246641618148280893 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin2314069804322490741;
