create or replace view aggView4065266711111644780 as select name as v2, id as v1 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7374926407670760011 as (
with aggView4887946736358532106 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView4887946736358532106 where mi.info_type_id=aggView4887946736358532106.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1491064504721011883 as (
with aggView22443360281779918 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView22443360281779918 where mk.keyword_id=aggView22443360281779918.v14);
create or replace view aggJoin8877343505847819260 as (
with aggView7520940102850601380 as (select v37 from aggJoin7374926407670760011 group by v37)
select id as v37, title as v38, kind_id as v17, production_year as v41 from title as t, aggView7520940102850601380 where t.id=aggView7520940102850601380.v37 and production_year>2005);
create or replace view aggJoin2333621452862768300 as (
with aggView2971888397911744740 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2971888397911744740 where mi_idx.info_type_id=aggView2971888397911744740.v12 and info<'8.5');
create or replace view aggView5783152888948550775 as select v32, v37 from aggJoin2333621452862768300 group by v32,v37;
create or replace view aggJoin866263518007927119 as (
with aggView5698918276166083045 as (select v37 from aggJoin1491064504721011883 group by v37)
select v37, v38, v17, v41 from aggJoin8877343505847819260 join aggView5698918276166083045 using(v37));
create or replace view aggJoin4727393244378220151 as (
with aggView1549733464156431359 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41 from aggJoin866263518007927119 join aggView1549733464156431359 using(v17));
create or replace view aggView3741034017191081175 as select v37, v38 from aggJoin4727393244378220151 group by v37,v38;
create or replace view aggJoin4981636700946034199 as (
with aggView388689457942975044 as (select v1, MIN(v2) as v49 from aggView4065266711111644780 group by v1)
select movie_id as v37, company_type_id as v8, v49 from movie_companies as mc, aggView388689457942975044 where mc.company_id=aggView388689457942975044.v1);
create or replace view aggJoin5940396706303424063 as (
with aggView6424526787718368063 as (select v37, MIN(v32) as v50 from aggView5783152888948550775 group by v37)
select v37, v8, v49 as v49, v50 from aggJoin4981636700946034199 join aggView6424526787718368063 using(v37));
create or replace view aggJoin8290500535200111142 as (
with aggView2932641981165227979 as (select id as v8 from company_type as ct)
select v37, v49, v50 from aggJoin5940396706303424063 join aggView2932641981165227979 using(v8));
create or replace view aggJoin6173019780810516544 as (
with aggView8268232784134794261 as (select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8290500535200111142 group by v37,v50,v49)
select v38, v49, v50 from aggView3741034017191081175 join aggView8268232784134794261 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin6173019780810516544;
