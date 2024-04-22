create or replace view aggJoin2028001743589828287 as (
with aggView6871888933213542989 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView6871888933213542989 where mc.company_id=aggView6871888933213542989.v1);
create or replace view aggJoin3554968227366686286 as (
with aggView622145940265474545 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2028001743589828287 join aggView622145940265474545 using(v8));
create or replace view aggJoin2936618003816194970 as (
with aggView6236216834346812073 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView6236216834346812073 where t.kind_id=aggView6236216834346812073.v14);
create or replace view aggJoin8263768285758029912 as (
with aggView5794697900470931247 as (select v22, MIN(v32) as v45 from aggJoin2936618003816194970 group by v22)
select v22, v43 as v43, v45 from aggJoin3554968227366686286 join aggView5794697900470931247 using(v22));
create or replace view aggJoin8447195765821407378 as (
with aggView5043367248169780360 as (select v22, MIN(v43) as v43, MIN(v45) as v45 from aggJoin8263768285758029912 group by v22,v43,v45)
select movie_id as v22, info_type_id as v12, v43, v45 from movie_info as mi, aggView5043367248169780360 where mi.movie_id=aggView5043367248169780360.v22);
create or replace view aggJoin6981510040763822122 as (
with aggView7376086710548472581 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v43, v45 from aggJoin8447195765821407378 join aggView7376086710548472581 using(v12));
create or replace view aggJoin7361491340647341406 as (
with aggView1906998931207037699 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1906998931207037699 where miidx.info_type_id=aggView1906998931207037699.v10);
create or replace view aggJoin5577146189678879416 as (
with aggView5350455241487098025 as (select v22, MIN(v29) as v44 from aggJoin7361491340647341406 group by v22)
select v43 as v43, v45 as v45, v44 from aggJoin6981510040763822122 join aggView5350455241487098025 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5577146189678879416;
