create or replace view aggView6973032099957560933 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8830005050882195561 as (
with aggView5113934713125824027 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5113934713125824027 where t.kind_id=aggView5113934713125824027.v14);
create or replace view aggView5633110856947835133 as select v32, v22 from aggJoin8830005050882195561 group by v32,v22;
create or replace view aggJoin8497467934301400710 as (
with aggView7897596052688390270 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView7897596052688390270 where mi.info_type_id=aggView7897596052688390270.v12);
create or replace view aggJoin103027015407531683 as (
with aggView681705239391329192 as (select v22 from aggJoin8497467934301400710 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView681705239391329192 where miidx.movie_id=aggView681705239391329192.v22);
create or replace view aggJoin4739302636401054148 as (
with aggView1552565140208903124 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin103027015407531683 join aggView1552565140208903124 using(v10));
create or replace view aggView7352204251855235346 as select v22, v29 from aggJoin4739302636401054148 group by v22,v29;
create or replace view aggJoin7792687369677421163 as (
with aggView4392017501535814670 as (select v22, MIN(v29) as v44 from aggView7352204251855235346 group by v22)
select movie_id as v22, company_id as v1, company_type_id as v8, v44 from movie_companies as mc, aggView4392017501535814670 where mc.movie_id=aggView4392017501535814670.v22);
create or replace view aggJoin1578993994423562579 as (
with aggView5920844962662230506 as (select v22, MIN(v32) as v45 from aggView5633110856947835133 group by v22)
select v1, v8, v44 as v44, v45 from aggJoin7792687369677421163 join aggView5920844962662230506 using(v22));
create or replace view aggJoin1066191405507004436 as (
with aggView8348543453590440526 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v44, v45 from aggJoin1578993994423562579 join aggView8348543453590440526 using(v8));
create or replace view aggJoin4598403995613137780 as (
with aggView975456462088544589 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin1066191405507004436 group by v1,v44,v45)
select v2, v44, v45 from aggView6973032099957560933 join aggView975456462088544589 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4598403995613137780;
