create or replace view aggJoin7240695261399292557 as (
with aggView6872987395406227319 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView6872987395406227319 where mc.company_type_id=aggView6872987395406227319.v8);
create or replace view aggJoin2833369705875505929 as (
with aggView7466240878826031355 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView7466240878826031355 where miidx.info_type_id=aggView7466240878826031355.v10);
create or replace view aggJoin1533951717269423422 as (
with aggView568654426323720400 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView568654426323720400 where mi.info_type_id=aggView568654426323720400.v12);
create or replace view aggJoin4415124672048394373 as (
with aggView7048664632735438111 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin7240695261399292557 join aggView7048664632735438111 using(v1));
create or replace view aggJoin3220491167597717963 as (
with aggView8717299038270751226 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView8717299038270751226 where t.kind_id=aggView8717299038270751226.v14);
create or replace view aggJoin6093952937281253846 as (
with aggView5066206692462560891 as (select v22, MIN(v32) as v45 from aggJoin3220491167597717963 group by v22)
select v22, v29, v45 from aggJoin2833369705875505929 join aggView5066206692462560891 using(v22));
create or replace view aggJoin7164133639734300665 as (
with aggView6812393963666086400 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin6093952937281253846 group by v22,v45)
select v22, v24, v45, v44 from aggJoin1533951717269423422 join aggView6812393963666086400 using(v22));
create or replace view aggJoin1081169423212612433 as (
with aggView3439355897206005866 as (select v22 from aggJoin4415124672048394373 group by v22)
select v24, v45 as v45, v44 as v44 from aggJoin7164133639734300665 join aggView3439355897206005866 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1081169423212612433;
