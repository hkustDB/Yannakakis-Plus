create or replace view aggView8507066478990546125 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin17768533684975162 as (
with aggView8116917005244235850 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView8116917005244235850 where miidx.info_type_id=aggView8116917005244235850.v10);
create or replace view aggJoin1292105508390404999 as (
with aggView4684422006798633395 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView4684422006798633395 where mi.info_type_id=aggView4684422006798633395.v12);
create or replace view aggJoin2632988060537978184 as (
with aggView106381089743835820 as (select v22 from aggJoin1292105508390404999 group by v22)
select v22, v29 from aggJoin17768533684975162 join aggView106381089743835820 using(v22));
create or replace view aggView6107014971812997036 as select v22, v29 from aggJoin2632988060537978184 group by v22,v29;
create or replace view aggJoin1534012811837098876 as (
with aggView1291496374957436393 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1291496374957436393 where t.kind_id=aggView1291496374957436393.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView1916042160853774545 as select v32, v22 from aggJoin1534012811837098876 group by v32,v22;
create or replace view aggJoin2806229658492141475 as (
with aggView6050830016016315375 as (select v1, MIN(v2) as v43 from aggView8507066478990546125 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView6050830016016315375 where mc.company_id=aggView6050830016016315375.v1);
create or replace view aggJoin6825326701185377600 as (
with aggView4377548840836640863 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2806229658492141475 join aggView4377548840836640863 using(v8));
create or replace view aggJoin8313183008843637081 as (
with aggView6940823032868530264 as (select v22, MIN(v43) as v43 from aggJoin6825326701185377600 group by v22,v43)
select v22, v29, v43 from aggView6107014971812997036 join aggView6940823032868530264 using(v22));
create or replace view aggJoin3856890540038391732 as (
with aggView6955546012426860723 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin8313183008843637081 group by v22,v43)
select v32, v43, v44 from aggView1916042160853774545 join aggView6955546012426860723 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin3856890540038391732;
