create or replace view aggView1367055983363390727 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7043632554790615570 as (
with aggView4813934960859124012 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView4813934960859124012 where mi.info_type_id=aggView4813934960859124012.v12);
create or replace view aggJoin2370328120153402808 as (
with aggView4443004552022433167 as (select v22 from aggJoin7043632554790615570 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView4443004552022433167 where miidx.movie_id=aggView4443004552022433167.v22);
create or replace view aggJoin6077112331123546686 as (
with aggView3812384089063545235 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin2370328120153402808 join aggView3812384089063545235 using(v10));
create or replace view aggView5977465570775267978 as select v22, v29 from aggJoin6077112331123546686 group by v22,v29;
create or replace view aggJoin8991775551524830059 as (
with aggView9220292222645857687 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView9220292222645857687 where t.kind_id=aggView9220292222645857687.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggView4984260107246617233 as select v22, v32 from aggJoin8991775551524830059 group by v22,v32;
create or replace view aggJoin385148651633496224 as (
with aggView1225239929397150376 as (select v22, MIN(v29) as v44 from aggView5977465570775267978 group by v22)
select v22, v32, v44 from aggView4984260107246617233 join aggView1225239929397150376 using(v22));
create or replace view aggJoin8787214287553231927 as (
with aggView9078353612272278987 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin385148651633496224 group by v22,v44)
select company_id as v1, company_type_id as v8, v44, v45 from movie_companies as mc, aggView9078353612272278987 where mc.movie_id=aggView9078353612272278987.v22);
create or replace view aggJoin1502726631303438540 as (
with aggView9122312056752645438 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v44, v45 from aggJoin8787214287553231927 join aggView9122312056752645438 using(v8));
create or replace view aggJoin4450729847129526088 as (
with aggView5431776979155298743 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin1502726631303438540 group by v1,v44,v45)
select v2, v44, v45 from aggView1367055983363390727 join aggView5431776979155298743 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4450729847129526088;
