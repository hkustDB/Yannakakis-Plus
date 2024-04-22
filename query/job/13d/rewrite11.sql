create or replace view aggView6770611758534325488 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8305470540711197130 as (
with aggView8698881374745323220 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView8698881374745323220 where t.kind_id=aggView8698881374745323220.v14);
create or replace view aggView2476435987282158932 as select v32, v22 from aggJoin8305470540711197130 group by v32,v22;
create or replace view aggJoin9071755404465875082 as (
with aggView291305747165675901 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView291305747165675901 where miidx.info_type_id=aggView291305747165675901.v10);
create or replace view aggView5587456653464768651 as select v22, v29 from aggJoin9071755404465875082 group by v22,v29;
create or replace view aggJoin1385083953789963852 as (
with aggView8873132203021258671 as (select v22, MIN(v32) as v45 from aggView2476435987282158932 group by v22)
select v22, v29, v45 from aggView5587456653464768651 join aggView8873132203021258671 using(v22));
create or replace view aggJoin4844177649842812255 as (
with aggView8732904236369377209 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin1385083953789963852 group by v22,v45)
select movie_id as v22, company_id as v1, company_type_id as v8, v45, v44 from movie_companies as mc, aggView8732904236369377209 where mc.movie_id=aggView8732904236369377209.v22);
create or replace view aggJoin6630330907266016413 as (
with aggView6884577843339567479 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v1, v45, v44 from aggJoin4844177649842812255 join aggView6884577843339567479 using(v8));
create or replace view aggJoin5747528024747906634 as (
with aggView6105296607646378180 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView6105296607646378180 where mi.info_type_id=aggView6105296607646378180.v12);
create or replace view aggJoin5008972951837649620 as (
with aggView6025287882389777948 as (select v22 from aggJoin5747528024747906634 group by v22)
select v1, v45 as v45, v44 as v44 from aggJoin6630330907266016413 join aggView6025287882389777948 using(v22));
create or replace view aggJoin6345439376336106965 as (
with aggView7842813365869109753 as (select v1, MIN(v45) as v45, MIN(v44) as v44 from aggJoin5008972951837649620 group by v1,v44,v45)
select v2, v45, v44 from aggView6770611758534325488 join aggView7842813365869109753 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin6345439376336106965;
