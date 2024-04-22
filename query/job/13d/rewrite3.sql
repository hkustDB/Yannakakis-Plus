create or replace view aggView7429919338569406311 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3973109287814705356 as (
with aggView2369533653994728784 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView2369533653994728784 where t.kind_id=aggView2369533653994728784.v14);
create or replace view aggJoin6873511098868271678 as (
with aggView2175013569335474739 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2175013569335474739 where miidx.info_type_id=aggView2175013569335474739.v10);
create or replace view aggView2407120558389233950 as select v22, v29 from aggJoin6873511098868271678 group by v22,v29;
create or replace view aggJoin9194974610660696954 as (
with aggView609981796186102455 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView609981796186102455 where mi.info_type_id=aggView609981796186102455.v12);
create or replace view aggJoin5302371026985670039 as (
with aggView5960988588373814938 as (select v22 from aggJoin9194974610660696954 group by v22)
select v22, v32 from aggJoin3973109287814705356 join aggView5960988588373814938 using(v22));
create or replace view aggView3095433052317040265 as select v32, v22 from aggJoin5302371026985670039 group by v32,v22;
create or replace view aggJoin3320672322759521656 as (
with aggView2088897807115205333 as (select v22, MIN(v29) as v44 from aggView2407120558389233950 group by v22)
select v32, v22, v44 from aggView3095433052317040265 join aggView2088897807115205333 using(v22));
create or replace view aggJoin5284974186580687511 as (
with aggView2809723904024058632 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin3320672322759521656 group by v22,v44)
select company_id as v1, company_type_id as v8, v44, v45 from movie_companies as mc, aggView2809723904024058632 where mc.movie_id=aggView2809723904024058632.v22);
create or replace view aggJoin1503045876872307413 as (
with aggView2262334972591427884 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v44, v45 from aggJoin5284974186580687511 join aggView2262334972591427884 using(v8));
create or replace view aggJoin3398299014588339254 as (
with aggView8817748357190635604 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin1503045876872307413 group by v1,v44,v45)
select v2, v44, v45 from aggView7429919338569406311 join aggView8817748357190635604 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3398299014588339254;
