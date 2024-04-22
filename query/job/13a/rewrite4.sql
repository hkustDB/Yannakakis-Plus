create or replace view aggJoin603361228242207585 as (
with aggView2920804235403639830 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView2920804235403639830 where mc.company_type_id=aggView2920804235403639830.v8);
create or replace view aggJoin2330496641835061147 as (
with aggView1846331722986911623 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1846331722986911623 where miidx.info_type_id=aggView1846331722986911623.v10);
create or replace view aggView5701257466945441167 as select v22, v29 from aggJoin2330496641835061147 group by v22,v29;
create or replace view aggJoin6919421487218307699 as (
with aggView5744714155779902641 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView5744714155779902641 where mi.info_type_id=aggView5744714155779902641.v12);
create or replace view aggView3573493817314285712 as select v24, v22 from aggJoin6919421487218307699 group by v24,v22;
create or replace view aggJoin9029289273596961891 as (
with aggView3912259593012882217 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin603361228242207585 join aggView3912259593012882217 using(v1));
create or replace view aggJoin1191361175372043838 as (
with aggView5273979787970994107 as (select v22 from aggJoin9029289273596961891 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView5273979787970994107 where t.id=aggView5273979787970994107.v22);
create or replace view aggJoin2172785668061502048 as (
with aggView2786793186278588762 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin1191361175372043838 join aggView2786793186278588762 using(v14));
create or replace view aggView2485990745205874457 as select v22, v32 from aggJoin2172785668061502048 group by v22,v32;
create or replace view aggJoin5133089083336877956 as (
with aggView4821460198696753445 as (select v22, MIN(v24) as v43 from aggView3573493817314285712 group by v22)
select v22, v29, v43 from aggView5701257466945441167 join aggView4821460198696753445 using(v22));
create or replace view aggJoin5977137510527116753 as (
with aggView4694379028501896992 as (select v22, MIN(v43) as v43, MIN(v29) as v44 from aggJoin5133089083336877956 group by v22,v43)
select v32, v43, v44 from aggView2485990745205874457 join aggView4694379028501896992 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin5977137510527116753;
