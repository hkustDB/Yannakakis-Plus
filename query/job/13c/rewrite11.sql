create or replace view aggView1978261427470553020 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3469907877238422636 as (
with aggView1901351236110146099 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1901351236110146099 where miidx.info_type_id=aggView1901351236110146099.v10);
create or replace view aggView2574217123774317753 as select v22, v29 from aggJoin3469907877238422636 group by v22,v29;
create or replace view aggJoin5564211382434929450 as (
with aggView1844878756293295880 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1844878756293295880 where t.kind_id=aggView1844878756293295880.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggView2647835245824074085 as select v32, v22 from aggJoin5564211382434929450 group by v32,v22;
create or replace view aggJoin5802172005298602269 as (
with aggView4076272569083020993 as (select v1, MIN(v2) as v43 from aggView1978261427470553020 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView4076272569083020993 where mc.company_id=aggView4076272569083020993.v1);
create or replace view aggJoin7613812762715059111 as (
with aggView4247415872879553230 as (select v22, MIN(v32) as v45 from aggView2647835245824074085 group by v22)
select v22, v29, v45 from aggView2574217123774317753 join aggView4247415872879553230 using(v22));
create or replace view aggJoin7592321617251230367 as (
with aggView2796520374300407187 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5802172005298602269 join aggView2796520374300407187 using(v8));
create or replace view aggJoin7371607555054540169 as (
with aggView960992248626618785 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView960992248626618785 where mi.info_type_id=aggView960992248626618785.v12);
create or replace view aggJoin2823896630619352666 as (
with aggView6218403717924938625 as (select v22 from aggJoin7371607555054540169 group by v22)
select v22, v43 as v43 from aggJoin7592321617251230367 join aggView6218403717924938625 using(v22));
create or replace view aggJoin719803490882698842 as (
with aggView4700080373280552965 as (select v22, MIN(v43) as v43 from aggJoin2823896630619352666 group by v22,v43)
select v29, v45 as v45, v43 from aggJoin7613812762715059111 join aggView4700080373280552965 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin719803490882698842;
