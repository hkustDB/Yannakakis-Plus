create or replace view aggJoin4035817959740025242 as (
with aggView6798731213169424611 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView6798731213169424611 where mc.company_id=aggView6798731213169424611.v1);
create or replace view aggJoin3052863369542232047 as (
with aggView753892975682300651 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin4035817959740025242 join aggView753892975682300651 using(v8));
create or replace view aggJoin3804884450688108588 as (
with aggView2008554709884322358 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2008554709884322358 where miidx.info_type_id=aggView2008554709884322358.v10);
create or replace view aggJoin1263466163554558128 as (
with aggView4005973360536973785 as (select v22, MIN(v29) as v44 from aggJoin3804884450688108588 group by v22)
select movie_id as v22, info_type_id as v12, v44 from movie_info as mi, aggView4005973360536973785 where mi.movie_id=aggView4005973360536973785.v22);
create or replace view aggJoin5908992457574843426 as (
with aggView8658615100201126675 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v44 from aggJoin1263466163554558128 join aggView8658615100201126675 using(v12));
create or replace view aggJoin3864119949140857589 as (
with aggView3559869444274468291 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView3559869444274468291 where t.kind_id=aggView3559869444274468291.v14 and title<> '' and ((title LIKE 'Champion%') OR (title LIKE 'Loser%')));
create or replace view aggJoin5281220923930372048 as (
with aggView1109289994669604939 as (select v22, MIN(v32) as v45 from aggJoin3864119949140857589 group by v22)
select v22, v43 as v43, v45 from aggJoin3052863369542232047 join aggView1109289994669604939 using(v22));
create or replace view aggJoin3897866180965088833 as (
with aggView6921853749443925988 as (select v22, MIN(v43) as v43, MIN(v45) as v45 from aggJoin5281220923930372048 group by v22,v45,v43)
select v44 as v44, v43, v45 from aggJoin5908992457574843426 join aggView6921853749443925988 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3897866180965088833;
