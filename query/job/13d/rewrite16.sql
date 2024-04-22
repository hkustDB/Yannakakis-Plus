create or replace view aggJoin5919761402569517357 as (
with aggView821294820439282524 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView821294820439282524 where mc.company_id=aggView821294820439282524.v1);
create or replace view aggJoin6762345974227540126 as (
with aggView7245810624272565362 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5919761402569517357 join aggView7245810624272565362 using(v8));
create or replace view aggJoin478377120101254116 as (
with aggView8669470558414922576 as (select v22, MIN(v43) as v43 from aggJoin6762345974227540126 group by v22,v43)
select movie_id as v22, info_type_id as v10, info as v29, v43 from movie_info_idx as miidx, aggView8669470558414922576 where miidx.movie_id=aggView8669470558414922576.v22);
create or replace view aggJoin8703232818111892123 as (
with aggView8495080531606358196 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView8495080531606358196 where t.kind_id=aggView8495080531606358196.v14);
create or replace view aggJoin5996216386326216261 as (
with aggView428355452700767625 as (select v22, MIN(v32) as v45 from aggJoin8703232818111892123 group by v22)
select v22, v10, v29, v43 as v43, v45 from aggJoin478377120101254116 join aggView428355452700767625 using(v22));
create or replace view aggJoin4101756642398541643 as (
with aggView4652680331354689697 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v43, v45 from aggJoin5996216386326216261 join aggView4652680331354689697 using(v10));
create or replace view aggJoin245733909445051388 as (
with aggView3594965912027355173 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v29) as v44 from aggJoin4101756642398541643 group by v22,v43,v45)
select info_type_id as v12, v43, v45, v44 from movie_info as mi, aggView3594965912027355173 where mi.movie_id=aggView3594965912027355173.v22);
create or replace view aggJoin5618297157802579750 as (
with aggView5024454382496767853 as (select id as v12 from info_type as it2 where info= 'release dates')
select v43, v45, v44 from aggJoin245733909445051388 join aggView5024454382496767853 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin5618297157802579750;
