create or replace view aggView8035919396332657185 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8317058352594522708 as (
with aggView4262444086881705173 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4262444086881705173 where t.kind_id=aggView4262444086881705173.v14);
create or replace view aggJoin3400439081157177354 as (
with aggView9029011802820752446 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView9029011802820752446 where miidx.info_type_id=aggView9029011802820752446.v10);
create or replace view aggView1317919512959417843 as select v22, v29 from aggJoin3400439081157177354 group by v22,v29;
create or replace view aggJoin4385191826659853655 as (
with aggView290452359717721013 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView290452359717721013 where mi.info_type_id=aggView290452359717721013.v12);
create or replace view aggJoin688939188909556047 as (
with aggView1898748241065868561 as (select v22 from aggJoin4385191826659853655 group by v22)
select v22, v32 from aggJoin8317058352594522708 join aggView1898748241065868561 using(v22));
create or replace view aggView3761520709325062592 as select v32, v22 from aggJoin688939188909556047 group by v32,v22;
create or replace view aggJoin8497849497371129461 as (
with aggView5532201353747762216 as (select v22, MIN(v29) as v44 from aggView1317919512959417843 group by v22)
select movie_id as v22, company_id as v1, company_type_id as v8, v44 from movie_companies as mc, aggView5532201353747762216 where mc.movie_id=aggView5532201353747762216.v22);
create or replace view aggJoin4916355615864753330 as (
with aggView4767627136021295671 as (select v1, MIN(v2) as v43 from aggView8035919396332657185 group by v1)
select v22, v8, v44 as v44, v43 from aggJoin8497849497371129461 join aggView4767627136021295671 using(v1));
create or replace view aggJoin1229281904252279895 as (
with aggView8416411750914968864 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v44, v43 from aggJoin4916355615864753330 join aggView8416411750914968864 using(v8));
create or replace view aggJoin2121853320670143695 as (
with aggView6733106296082442605 as (select v22, MIN(v44) as v44, MIN(v43) as v43 from aggJoin1229281904252279895 group by v22,v43,v44)
select v32, v44, v43 from aggView3761520709325062592 join aggView6733106296082442605 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin2121853320670143695;
