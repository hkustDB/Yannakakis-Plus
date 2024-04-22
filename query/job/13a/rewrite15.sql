create or replace view aggJoin5112425142869407605 as (
with aggView6055049518523158280 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView6055049518523158280 where mc.company_type_id=aggView6055049518523158280.v8);
create or replace view aggJoin1251937656592715508 as (
with aggView7155795608865359249 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView7155795608865359249 where miidx.info_type_id=aggView7155795608865359249.v10);
create or replace view aggJoin6482559881647741155 as (
with aggView7814262995615799227 as (select v22, MIN(v29) as v44 from aggJoin1251937656592715508 group by v22)
select movie_id as v22, info_type_id as v12, info as v24, v44 from movie_info as mi, aggView7814262995615799227 where mi.movie_id=aggView7814262995615799227.v22);
create or replace view aggJoin3355473854872894319 as (
with aggView8430023366052405324 as (select id as v12 from info_type as it2 where info= 'release dates')
select v22, v24, v44 from aggJoin6482559881647741155 join aggView8430023366052405324 using(v12));
create or replace view aggJoin2936600459358322498 as (
with aggView988816573174180481 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin5112425142869407605 join aggView988816573174180481 using(v1));
create or replace view aggJoin4788205197966853764 as (
with aggView1911323273407193394 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1911323273407193394 where t.kind_id=aggView1911323273407193394.v14);
create or replace view aggJoin9079160080859766486 as (
with aggView8029979835571958661 as (select v22, MIN(v32) as v45 from aggJoin4788205197966853764 group by v22)
select v22, v45 from aggJoin2936600459358322498 join aggView8029979835571958661 using(v22));
create or replace view aggJoin6503291101760286310 as (
with aggView4269936521734259530 as (select v22, MIN(v45) as v45 from aggJoin9079160080859766486 group by v22,v45)
select v24, v44 as v44, v45 from aggJoin3355473854872894319 join aggView4269936521734259530 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin6503291101760286310;
