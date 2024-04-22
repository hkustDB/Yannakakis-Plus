create or replace view aggJoin1124815527413010475 as (
with aggView2535636387228481148 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView2535636387228481148 where mc.company_id=aggView2535636387228481148.v13);
create or replace view aggJoin4695196534951936457 as (
with aggView7342027690697508190 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView7342027690697508190 where mi.info_type_id=aggView7342027690697508190.v22 and note LIKE '%internet%');
create or replace view aggJoin7584243182388474614 as (
with aggView7596127890495326146 as (select v40 from aggJoin4695196534951936457 group by v40)
select movie_id as v40, keyword_id as v24 from movie_keyword as mk, aggView7596127890495326146 where mk.movie_id=aggView7596127890495326146.v40);
create or replace view aggJoin1389378948938719124 as (
with aggView7532692044718463416 as (select id as v20 from company_type as ct)
select v40 from aggJoin1124815527413010475 join aggView7532692044718463416 using(v20));
create or replace view aggJoin713400927666924146 as (
with aggView3426361180707620635 as (select v40 from aggJoin1389378948938719124 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView3426361180707620635 where aka_t.movie_id=aggView3426361180707620635.v40);
create or replace view aggJoin7834253986528363879 as (
with aggView1610280551557403890 as (select v40, MIN(v3) as v52 from aggJoin713400927666924146 group by v40)
select id as v40, title as v41, production_year as v44, v52 from title as t, aggView1610280551557403890 where t.id=aggView1610280551557403890.v40 and production_year>1990);
create or replace view aggJoin5775962499720307206 as (
with aggView79329082669169291 as (select v40, MIN(v52) as v52, MIN(v41) as v53 from aggJoin7834253986528363879 group by v40,v52)
select v24, v52, v53 from aggJoin7584243182388474614 join aggView79329082669169291 using(v40));
create or replace view aggJoin2229322920696559442 as (
with aggView7821425477397216632 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin5775962499720307206 join aggView7821425477397216632 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin2229322920696559442;
