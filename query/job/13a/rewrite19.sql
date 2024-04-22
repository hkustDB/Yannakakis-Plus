create or replace view aggJoin5006344487846308490 as (
with aggView8979014297892325233 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView8979014297892325233 where mc.company_type_id=aggView8979014297892325233.v8);
create or replace view aggJoin8509952195001396425 as (
with aggView7438948585507772544 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView7438948585507772544 where miidx.info_type_id=aggView7438948585507772544.v10);
create or replace view aggJoin1230847593014390606 as (
with aggView2343651785126847928 as (select v22, MIN(v29) as v44 from aggJoin8509952195001396425 group by v22)
select id as v22, title as v32, kind_id as v14, v44 from title as t, aggView2343651785126847928 where t.id=aggView2343651785126847928.v22);
create or replace view aggJoin306732280410502042 as (
with aggView6247788855166452137 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView6247788855166452137 where mi.info_type_id=aggView6247788855166452137.v12);
create or replace view aggJoin5473026216917304315 as (
with aggView8252562873716654358 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin5006344487846308490 join aggView8252562873716654358 using(v1));
create or replace view aggJoin8493829213762269085 as (
with aggView4034538441112143392 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32, v44 from aggJoin1230847593014390606 join aggView4034538441112143392 using(v14));
create or replace view aggJoin8298298521011223971 as (
with aggView1901762927427872570 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8493829213762269085 group by v22,v44)
select v22, v24, v44, v45 from aggJoin306732280410502042 join aggView1901762927427872570 using(v22));
create or replace view aggJoin4604900697109918096 as (
with aggView7868889865553012004 as (select v22 from aggJoin5473026216917304315 group by v22)
select v24, v44 as v44, v45 as v45 from aggJoin8298298521011223971 join aggView7868889865553012004 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4604900697109918096;
