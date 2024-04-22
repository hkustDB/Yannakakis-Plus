create or replace view aggJoin1748643658637199133 as (
with aggView8399424745863360656 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView8399424745863360656 where mc.company_id=aggView8399424745863360656.v1);
create or replace view aggJoin3292227704741413442 as (
with aggView5611725364683937679 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin1748643658637199133 join aggView5611725364683937679 using(v8));
create or replace view aggJoin4281418135992162772 as (
with aggView5335357332952847080 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView5335357332952847080 where miidx.info_type_id=aggView5335357332952847080.v10);
create or replace view aggJoin5334324098050015974 as (
with aggView3381584442389357248 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView3381584442389357248 where mi.info_type_id=aggView3381584442389357248.v12);
create or replace view aggJoin4426265540707264479 as (
with aggView1614432631151300651 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1614432631151300651 where t.kind_id=aggView1614432631151300651.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin1442115074288604262 as (
with aggView7479204582685724436 as (select v22, MIN(v32) as v45 from aggJoin4426265540707264479 group by v22)
select v22, v29, v45 from aggJoin4281418135992162772 join aggView7479204582685724436 using(v22));
create or replace view aggJoin988717066222434526 as (
with aggView1081596667124918294 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin1442115074288604262 group by v22,v45)
select v22, v45, v44 from aggJoin5334324098050015974 join aggView1081596667124918294 using(v22));
create or replace view aggJoin6541193154418519516 as (
with aggView6347454950415471164 as (select v22, MIN(v43) as v43 from aggJoin3292227704741413442 group by v22,v43)
select v45 as v45, v44 as v44, v43 from aggJoin988717066222434526 join aggView6347454950415471164 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin6541193154418519516;
