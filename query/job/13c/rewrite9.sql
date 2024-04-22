create or replace view aggView5789357903905163012 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin840758685121339258 as (
with aggView3227615659149044555 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView3227615659149044555 where miidx.info_type_id=aggView3227615659149044555.v10);
create or replace view aggView5119053504019568300 as select v22, v29 from aggJoin840758685121339258 group by v22,v29;
create or replace view aggJoin3359411640491734323 as (
with aggView3331613664947866277 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView3331613664947866277 where mi.info_type_id=aggView3331613664947866277.v12);
create or replace view aggJoin5750040204478995562 as (
with aggView6850309603293905307 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView6850309603293905307 where t.kind_id=aggView6850309603293905307.v14 and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin6435418743198379603 as (
with aggView7387401340170789153 as (select v22 from aggJoin3359411640491734323 group by v22)
select v22, v32 from aggJoin5750040204478995562 join aggView7387401340170789153 using(v22));
create or replace view aggJoin7301338146004361250 as (
with aggView5164577448677708207 as (select v32, v22 from aggJoin6435418743198379603 group by v32,v22)
select v22, v32 from aggView5164577448677708207 where v32<> '');
create or replace view aggJoin5185142751949652756 as (
with aggView5308981014251788405 as (select v1, MIN(v2) as v43 from aggView5789357903905163012 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5308981014251788405 where mc.company_id=aggView5308981014251788405.v1);
create or replace view aggJoin4504886614905917299 as (
with aggView4531258964090516000 as (select v22, MIN(v32) as v45 from aggJoin7301338146004361250 group by v22)
select v22, v8, v43 as v43, v45 from aggJoin5185142751949652756 join aggView4531258964090516000 using(v22));
create or replace view aggJoin8090086899900252691 as (
with aggView8690270964848586230 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43, v45 from aggJoin4504886614905917299 join aggView8690270964848586230 using(v8));
create or replace view aggJoin5175301047189569330 as (
with aggView2588446148711427350 as (select v22, MIN(v43) as v43, MIN(v45) as v45 from aggJoin8090086899900252691 group by v22,v45,v43)
select v29, v43, v45 from aggView5119053504019568300 join aggView2588446148711427350 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin5175301047189569330;
