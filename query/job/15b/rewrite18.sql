create or replace view aggJoin2079418557423286309 as (
with aggView8465389885786847004 as (select id as v40, title as v53 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView8465389885786847004 where mk.movie_id=aggView8465389885786847004.v40);
create or replace view aggJoin4238600383732011365 as (
with aggView5358424115420333614 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5358424115420333614 where mi.info_type_id=aggView5358424115420333614.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin1041552188209950178 as (
with aggView8513160373419925480 as (select v40, MIN(v35) as v52 from aggJoin4238600383732011365 group by v40)
select movie_id as v40, v52 from aka_title as aka_t, aggView8513160373419925480 where aka_t.movie_id=aggView8513160373419925480.v40);
create or replace view aggJoin8458758002500245902 as (
with aggView8119718184490517699 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8119718184490517699 where mc.company_id=aggView8119718184490517699.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4170897281511612548 as (
with aggView6709713425821739870 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin8458758002500245902 join aggView6709713425821739870 using(v20));
create or replace view aggJoin3980564956594093643 as (
with aggView4522053314313620096 as (select v40, MIN(v52) as v52 from aggJoin1041552188209950178 group by v40,v52)
select v40, v24, v53 as v53, v52 from aggJoin2079418557423286309 join aggView4522053314313620096 using(v40));
create or replace view aggJoin5417218398393739493 as (
with aggView7408202715730732531 as (select v40 from aggJoin4170897281511612548 group by v40)
select v24, v53 as v53, v52 as v52 from aggJoin3980564956594093643 join aggView7408202715730732531 using(v40));
create or replace view aggJoin2061148467858871391 as (
with aggView5536188331148168927 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin5417218398393739493 join aggView5536188331148168927 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin2061148467858871391;
