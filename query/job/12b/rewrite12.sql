create or replace view aggJoin2071007976446647341 as (
with aggView2619242971554075159 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView2619242971554075159 where mi.info_type_id=aggView2619242971554075159.v21);
create or replace view aggJoin3152707471622248443 as (
with aggView1067646363352194990 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView1067646363352194990 where mc.company_id=aggView1067646363352194990.v1);
create or replace view aggJoin1858622439657878991 as (
with aggView1181353856256264181 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin3152707471622248443 join aggView1181353856256264181 using(v8));
create or replace view aggJoin8664856051713138446 as (
with aggView6268682414240145039 as (select v29 from aggJoin1858622439657878991 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView6268682414240145039 where t.id=aggView6268682414240145039.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin4220849603063149662 as (
with aggView6218750895990050016 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView6218750895990050016 where mi_idx.info_type_id=aggView6218750895990050016.v26);
create or replace view aggJoin4987835049323553623 as (
with aggView1278531238066836276 as (select v29 from aggJoin4220849603063149662 group by v29)
select v29, v30, v33 from aggJoin8664856051713138446 join aggView1278531238066836276 using(v29));
create or replace view aggJoin3913055802887477918 as (
with aggView2363351001530311550 as (select v29, MIN(v30) as v42 from aggJoin4987835049323553623 group by v29)
select v22, v42 from aggJoin2071007976446647341 join aggView2363351001530311550 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin3913055802887477918;
