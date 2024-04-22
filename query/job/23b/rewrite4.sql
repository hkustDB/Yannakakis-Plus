create or replace view aggJoin7988129338077110790 as (
with aggView5819731039407589685 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView5819731039407589685 where mk.keyword_id=aggView5819731039407589685.v18);
create or replace view aggJoin4168009813934977505 as (
with aggView8273569297862312103 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView8273569297862312103 where mc.company_type_id=aggView8273569297862312103.v14);
create or replace view aggJoin572553694681415407 as (
with aggView974630296677610769 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView974630296677610769 where mi.info_type_id=aggView974630296677610769.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin7081017750646613488 as (
with aggView7459969714070678720 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView7459969714070678720 where cc.status_id=aggView7459969714070678720.v5);
create or replace view aggJoin2685254422708269036 as (
with aggView736662929340676835 as (select v36 from aggJoin7081017750646613488 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView736662929340676835 where t.id=aggView736662929340676835.v36 and production_year>2000);
create or replace view aggJoin1683284857671610242 as (
with aggView2016792769473699213 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin4168009813934977505 join aggView2016792769473699213 using(v7));
create or replace view aggJoin1784518618986368084 as (
with aggView1573525466640139461 as (select v36 from aggJoin7988129338077110790 group by v36)
select v36 from aggJoin1683284857671610242 join aggView1573525466640139461 using(v36));
create or replace view aggJoin8652873862630873848 as (
with aggView9207576821449867901 as (select v36 from aggJoin1784518618986368084 group by v36)
select v36, v37, v21, v40 from aggJoin2685254422708269036 join aggView9207576821449867901 using(v36));
create or replace view aggJoin716662986876000949 as (
with aggView2680851781528166815 as (select v36 from aggJoin572553694681415407 group by v36)
select v37, v21, v40 from aggJoin8652873862630873848 join aggView2680851781528166815 using(v36));
create or replace view aggView2950682432802206244 as select v37, v21 from aggJoin716662986876000949 group by v37,v21;
create or replace view aggJoin8852493527566972817 as (
with aggView2407164078604707536 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView2950682432802206244 join aggView2407164078604707536 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin8852493527566972817;
