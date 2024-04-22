create or replace view aggJoin5956878772690346562 as (
with aggView5430263628311195746 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView5430263628311195746 where mc.company_type_id=aggView5430263628311195746.v14);
create or replace view aggJoin6605322290210310185 as (
with aggView1781549787830118245 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView1781549787830118245 where mi.info_type_id=aggView1781549787830118245.v16 and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%');
create or replace view aggJoin1674869418972924772 as (
with aggView5810290045139184939 as (select v36 from aggJoin6605322290210310185 group by v36)
select v36, v7 from aggJoin5956878772690346562 join aggView5810290045139184939 using(v36));
create or replace view aggJoin6643115695518818562 as (
with aggView6894822678170393070 as (select id as v18 from keyword as k)
select movie_id as v36 from movie_keyword as mk, aggView6894822678170393070 where mk.keyword_id=aggView6894822678170393070.v18);
create or replace view aggJoin8655900061346608326 as (
with aggView979946291754993624 as (select v36 from aggJoin6643115695518818562 group by v36)
select v36, v7 from aggJoin1674869418972924772 join aggView979946291754993624 using(v36));
create or replace view aggJoin8764511274802661011 as (
with aggView5816397731454186155 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView5816397731454186155 where cc.status_id=aggView5816397731454186155.v5);
create or replace view aggJoin5555822754631834077 as (
with aggView5938269935787262333 as (select v36 from aggJoin8764511274802661011 group by v36)
select v36, v7 from aggJoin8655900061346608326 join aggView5938269935787262333 using(v36));
create or replace view aggJoin436843278522107098 as (
with aggView6893205767000606427 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin5555822754631834077 join aggView6893205767000606427 using(v7));
create or replace view aggJoin7763269968782345598 as (
with aggView5577949446214568553 as (select v36 from aggJoin436843278522107098 group by v36)
select title as v37, kind_id as v21, production_year as v40 from title as t, aggView5577949446214568553 where t.id=aggView5577949446214568553.v36 and production_year>2000);
create or replace view aggView8544779643845727078 as select v21, v37 from aggJoin7763269968782345598 group by v21,v37;
create or replace view aggJoin4572819822679786579 as (
with aggView8131343653103890580 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select v37, v48 from aggView8544779643845727078 join aggView8131343653103890580 using(v21));
select MIN(v48) as v48,MIN(v37) as v49 from aggJoin4572819822679786579;
