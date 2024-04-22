create or replace view aggView4977908477204971482 as select title as v41, id as v40 from title as t where production_year>2000;
create or replace view aggJoin4844251826122630286 as (
with aggView6503416440625882408 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView6503416440625882408 where mk.keyword_id=aggView6503416440625882408.v24);
create or replace view aggJoin7633442874397743538 as (
with aggView6890503035941395067 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView6890503035941395067 where mc.company_id=aggView6890503035941395067.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin443124514114981333 as (
with aggView1507477542065559646 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin7633442874397743538 join aggView1507477542065559646 using(v20));
create or replace view aggJoin6171695740105333314 as (
with aggView3789761560001680461 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView3789761560001680461 where mi.info_type_id=aggView3789761560001680461.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin4264230916858726820 as (
with aggView4705061540482967245 as (select v40 from aggJoin4844251826122630286 group by v40)
select v40, v31 from aggJoin443124514114981333 join aggView4705061540482967245 using(v40));
create or replace view aggJoin127370329429343335 as (
with aggView96800750004748857 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select v40, v31 from aggJoin4264230916858726820 join aggView96800750004748857 using(v40));
create or replace view aggJoin5804753979456092422 as (
with aggView7492344923024794395 as (select v40 from aggJoin127370329429343335 group by v40)
select v40, v35, v36 from aggJoin6171695740105333314 join aggView7492344923024794395 using(v40));
create or replace view aggView6313308633352547796 as select v35, v40 from aggJoin5804753979456092422 group by v35,v40;
create or replace view aggJoin303264189130144095 as (
with aggView2504837733534092509 as (select v40, MIN(v41) as v53 from aggView4977908477204971482 group by v40)
select v35, v53 from aggView6313308633352547796 join aggView2504837733534092509 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin303264189130144095;
