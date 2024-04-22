create or replace view aggJoin6043326596669930141 as (
with aggView8873863706526531046 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView8873863706526531046 where mc.company_id=aggView8873863706526531046.v1);
create or replace view aggJoin1980795010437396310 as (
with aggView6774356299547339898 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin6043326596669930141 join aggView6774356299547339898 using(v8));
create or replace view aggJoin7156142254279710081 as (
with aggView7338981567549928702 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView7338981567549928702 where t.kind_id=aggView7338981567549928702.v14);
create or replace view aggJoin8109919478187602426 as (
with aggView690995381949106546 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView690995381949106546 where miidx.info_type_id=aggView690995381949106546.v10);
create or replace view aggJoin8229070370468354230 as (
with aggView2531675250301399770 as (select v22, MIN(v29) as v44 from aggJoin8109919478187602426 group by v22)
select v22, v32, v44 from aggJoin7156142254279710081 join aggView2531675250301399770 using(v22));
create or replace view aggJoin7294951196543583661 as (
with aggView7035704829525899330 as (select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin8229070370468354230 group by v22,v44)
select v22, v43 as v43, v44, v45 from aggJoin1980795010437396310 join aggView7035704829525899330 using(v22));
create or replace view aggJoin7749730318507799090 as (
with aggView1916315204316263411 as (select v22, MIN(v43) as v43, MIN(v44) as v44, MIN(v45) as v45 from aggJoin7294951196543583661 group by v22,v43,v44,v45)
select info_type_id as v12, v43, v44, v45 from movie_info as mi, aggView1916315204316263411 where mi.movie_id=aggView1916315204316263411.v22);
create or replace view aggJoin3074166260315578849 as (
with aggView8112177125806283610 as (select id as v12 from info_type as it2 where info= 'release dates')
select v43, v44, v45 from aggJoin7749730318507799090 join aggView8112177125806283610 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3074166260315578849;
