create or replace view aggJoin2588468530844645120 as (
with aggView759751702388705830 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView759751702388705830 where mk.keyword_id=aggView759751702388705830.v24);
create or replace view aggJoin921818682349482306 as (
with aggView4956299736919002539 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView4956299736919002539 where mc.company_id=aggView4956299736919002539.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin6384614745296966386 as (
with aggView602159667401675509 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40 from aggJoin2588468530844645120 join aggView602159667401675509 using(v40));
create or replace view aggJoin6126787510026952491 as (
with aggView5781944994809275172 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin921818682349482306 join aggView5781944994809275172 using(v20));
create or replace view aggJoin8334376725607732180 as (
with aggView5815383441292803549 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView5815383441292803549 where mi.info_type_id=aggView5815383441292803549.v22 and note LIKE '%internet%');
create or replace view aggJoin1052364369147849665 as (
with aggView5910820443215847178 as (select v35, v40 from aggJoin8334376725607732180 group by v35,v40)
select v40, v35 from aggView5910820443215847178 where v35 LIKE 'USA:% 200%');
create or replace view aggJoin7706249792162346937 as (
with aggView3953939186448909134 as (select v40 from aggJoin6384614745296966386 group by v40)
select v40, v31 from aggJoin6126787510026952491 join aggView3953939186448909134 using(v40));
create or replace view aggJoin3649294152294659008 as (
with aggView6562977401596348874 as (select v40 from aggJoin7706249792162346937 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView6562977401596348874 where t.id=aggView6562977401596348874.v40 and production_year>2000);
create or replace view aggView2574025847529404876 as select v41, v40 from aggJoin3649294152294659008 group by v41,v40;
create or replace view aggJoin7117853254545516387 as (
with aggView7992527920745674107 as (select v40, MIN(v35) as v52 from aggJoin1052364369147849665 group by v40)
select v41, v52 from aggView2574025847529404876 join aggView7992527920745674107 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin7117853254545516387;
