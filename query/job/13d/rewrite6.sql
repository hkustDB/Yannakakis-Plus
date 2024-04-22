create or replace view aggView8261522933374926132 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin2649992296761279649 as (
with aggView478573836237093560 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView478573836237093560 where t.kind_id=aggView478573836237093560.v14);
create or replace view aggView6067220331071173436 as select v32, v22 from aggJoin2649992296761279649 group by v32,v22;
create or replace view aggJoin6412073857899360618 as (
with aggView1015694005638628862 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1015694005638628862 where miidx.info_type_id=aggView1015694005638628862.v10);
create or replace view aggView4844725401503059128 as select v22, v29 from aggJoin6412073857899360618 group by v22,v29;
create or replace view aggJoin6841009089572288651 as (
with aggView1122140654405425504 as (select v22, MIN(v29) as v44 from aggView4844725401503059128 group by v22)
select v32, v22, v44 from aggView6067220331071173436 join aggView1122140654405425504 using(v22));
create or replace view aggJoin4177683954065040704 as (
with aggView5504054461749054080 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin6841009089572288651 group by v22,v44)
select movie_id as v22, company_id as v1, company_type_id as v8, v44, v45 from movie_companies as mc, aggView5504054461749054080 where mc.movie_id=aggView5504054461749054080.v22);
create or replace view aggJoin3311442356727030654 as (
with aggView4547780830917988296 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v1, v44, v45 from aggJoin4177683954065040704 join aggView4547780830917988296 using(v8));
create or replace view aggJoin5881006931816733122 as (
with aggView921652110579676250 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView921652110579676250 where mi.info_type_id=aggView921652110579676250.v12);
create or replace view aggJoin3218311623382033205 as (
with aggView3405930619479759208 as (select v22 from aggJoin5881006931816733122 group by v22)
select v1, v44 as v44, v45 as v45 from aggJoin3311442356727030654 join aggView3405930619479759208 using(v22));
create or replace view aggJoin101336543291275357 as (
with aggView1198341722235180657 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin3218311623382033205 group by v1,v44,v45)
select v2, v44, v45 from aggView8261522933374926132 join aggView1198341722235180657 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin101336543291275357;
