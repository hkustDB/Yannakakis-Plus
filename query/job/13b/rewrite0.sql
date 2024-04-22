create or replace view aggView708089149431485750 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6173810411801521782 as (
with aggView9107215625686837186 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView9107215625686837186 where mi.info_type_id=aggView9107215625686837186.v12);
create or replace view aggJoin1484952016507619363 as (
with aggView2024912860278861698 as (select v22 from aggJoin6173810411801521782 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView2024912860278861698 where t.id=aggView2024912860278861698.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin4094203018009856971 as (
with aggView6782402915007006549 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView6782402915007006549 where miidx.info_type_id=aggView6782402915007006549.v10);
create or replace view aggView1421946603777211143 as select v22, v29 from aggJoin4094203018009856971 group by v22,v29;
create or replace view aggJoin7163947297423112868 as (
with aggView345588509421575206 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin1484952016507619363 join aggView345588509421575206 using(v14));
create or replace view aggView4911626808985917430 as select v22, v32 from aggJoin7163947297423112868 group by v22,v32;
create or replace view aggJoin6869460848873363829 as (
with aggView2079292406289307802 as (select v22, MIN(v32) as v45 from aggView4911626808985917430 group by v22)
select v22, v29, v45 from aggView1421946603777211143 join aggView2079292406289307802 using(v22));
create or replace view aggJoin1330443307722007612 as (
with aggView4240358223675911011 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin6869460848873363829 group by v22,v45)
select company_id as v1, company_type_id as v8, v45, v44 from movie_companies as mc, aggView4240358223675911011 where mc.movie_id=aggView4240358223675911011.v22);
create or replace view aggJoin3855833460580746462 as (
with aggView9001269703043218639 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v45, v44 from aggJoin1330443307722007612 join aggView9001269703043218639 using(v8));
create or replace view aggJoin171849424404899309 as (
with aggView2678211178801329739 as (select v1, MIN(v45) as v45, MIN(v44) as v44 from aggJoin3855833460580746462 group by v1,v44,v45)
select v2, v45, v44 from aggView708089149431485750 join aggView2678211178801329739 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin171849424404899309;
