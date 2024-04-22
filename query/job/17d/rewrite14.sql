create or replace view aggJoin6722410512493876861 as (
with aggView4259799158343723095 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView4259799158343723095 where ci.person_id=aggView4259799158343723095.v26);
create or replace view aggJoin1581441462245915546 as (
with aggView3156533850125025470 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3156533850125025470 where mc.company_id=aggView3156533850125025470.v20);
create or replace view aggJoin5266895987163458693 as (
with aggView7238310967436443960 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7238310967436443960 where mk.keyword_id=aggView7238310967436443960.v25);
create or replace view aggJoin1780235699052160945 as (
with aggView2417668791891124600 as (select id as v3 from title as t)
select v3 from aggJoin1581441462245915546 join aggView2417668791891124600 using(v3));
create or replace view aggJoin6517432717592517582 as (
with aggView2609131685310248530 as (select v3 from aggJoin1780235699052160945 group by v3)
select v3 from aggJoin5266895987163458693 join aggView2609131685310248530 using(v3));
create or replace view aggJoin5338797636594343382 as (
with aggView8389962190776443238 as (select v3 from aggJoin6517432717592517582 group by v3)
select v47 as v47 from aggJoin6722410512493876861 join aggView8389962190776443238 using(v3));
select MIN(v47) as v47 from aggJoin5338797636594343382;
