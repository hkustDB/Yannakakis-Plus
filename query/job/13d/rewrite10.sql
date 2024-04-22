create or replace view aggView3930327237200556998 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3488723340220655861 as (
with aggView431343941331586273 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView431343941331586273 where t.kind_id=aggView431343941331586273.v14);
create or replace view aggJoin7290067242025100837 as (
with aggView1197655278559248142 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView1197655278559248142 where mi.info_type_id=aggView1197655278559248142.v12);
create or replace view aggJoin6375646121037580547 as (
with aggView5599370144281852604 as (select v22 from aggJoin7290067242025100837 group by v22)
select v22, v32 from aggJoin3488723340220655861 join aggView5599370144281852604 using(v22));
create or replace view aggView2432835984092441078 as select v32, v22 from aggJoin6375646121037580547 group by v32,v22;
create or replace view aggJoin8375730021966843753 as (
with aggView1380060204900866975 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1380060204900866975 where miidx.info_type_id=aggView1380060204900866975.v10);
create or replace view aggView2014857398061047388 as select v22, v29 from aggJoin8375730021966843753 group by v22,v29;
create or replace view aggJoin3329982726953487402 as (
with aggView8995465647794331195 as (select v1, MIN(v2) as v43 from aggView3930327237200556998 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView8995465647794331195 where mc.company_id=aggView8995465647794331195.v1);
create or replace view aggJoin7504494125738811991 as (
with aggView2245810751110881179 as (select v22, MIN(v32) as v45 from aggView2432835984092441078 group by v22)
select v22, v29, v45 from aggView2014857398061047388 join aggView2245810751110881179 using(v22));
create or replace view aggJoin3279742727645842609 as (
with aggView5972465869039110668 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin3329982726953487402 join aggView5972465869039110668 using(v8));
create or replace view aggJoin4672127811043208233 as (
with aggView7754555785847832470 as (select v22, MIN(v43) as v43 from aggJoin3279742727645842609 group by v22,v43)
select v29, v45 as v45, v43 from aggJoin7504494125738811991 join aggView7754555785847832470 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin4672127811043208233;
