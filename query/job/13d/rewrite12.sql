create or replace view aggJoin7879776907592602350 as (
with aggView3852708772462095531 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView3852708772462095531 where mc.company_id=aggView3852708772462095531.v1);
create or replace view aggJoin6370278739828862464 as (
with aggView1560583638914835090 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin7879776907592602350 join aggView1560583638914835090 using(v8));
create or replace view aggJoin4336806485752974672 as (
with aggView1398571208815728587 as (select v22, MIN(v43) as v43 from aggJoin6370278739828862464 group by v22,v43)
select movie_id as v22, info_type_id as v12, v43 from movie_info as mi, aggView1398571208815728587 where mi.movie_id=aggView1398571208815728587.v22);
create or replace view aggJoin2106029740782437655 as (
with aggView8983189002539826258 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView8983189002539826258 where t.kind_id=aggView8983189002539826258.v14);
create or replace view aggJoin8827199239312184602 as (
with aggView8531796890499518364 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8531796890499518364 where miidx.info_type_id=aggView8531796890499518364.v10);
create or replace view aggJoin6701154168023522662 as (
with aggView5234771237394347794 as (select v22, MIN(v29) as v44 from aggJoin8827199239312184602 group by v22)
select v22, v32, v44 from aggJoin2106029740782437655 join aggView5234771237394347794 using(v22));
create or replace view aggJoin2508980484207403284 as (
with aggView258808548170961051 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin6701154168023522662 group by v22,v44)
select v12, v43 as v43, v44, v45 from aggJoin4336806485752974672 join aggView258808548170961051 using(v22));
create or replace view aggJoin3368299492518849193 as (
with aggView1573406967618641459 as (select id as v12 from info_type as it2 where info= 'release dates')
select v43, v44, v45 from aggJoin2508980484207403284 join aggView1573406967618641459 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3368299492518849193;
