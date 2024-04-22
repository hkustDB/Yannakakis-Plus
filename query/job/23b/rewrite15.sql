create or replace view aggJoin8694331037815220151 as (
with aggView1807281572990830352 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView1807281572990830352 where t.kind_id=aggView1807281572990830352.v21 and production_year>2000);
create or replace view aggJoin5628688360945328775 as (
with aggView2129966832713204650 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin8694331037815220151 group by v36,v48)
select movie_id as v36, status_id as v5, v48, v49 from complete_cast as cc, aggView2129966832713204650 where cc.movie_id=aggView2129966832713204650.v36);
create or replace view aggJoin1366337744764818831 as (
with aggView1800032519893274893 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView1800032519893274893 where mc.company_type_id=aggView1800032519893274893.v14);
create or replace view aggJoin3983427525823134828 as (
with aggView8521422081003965669 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView8521422081003965669 where mi.info_type_id=aggView8521422081003965669.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin8610211299528987893 as (
with aggView7503252515142323574 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView7503252515142323574 where mk.keyword_id=aggView7503252515142323574.v18);
create or replace view aggJoin8070630178765169018 as (
with aggView1619796043780502923 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select v36, v48, v49 from aggJoin5628688360945328775 join aggView1619796043780502923 using(v5));
create or replace view aggJoin1589043593752531413 as (
with aggView4374866239815429390 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1366337744764818831 join aggView4374866239815429390 using(v7));
create or replace view aggJoin4150695753466635876 as (
with aggView6881992352828696731 as (select v36 from aggJoin1589043593752531413 group by v36)
select v36, v48 as v48, v49 as v49 from aggJoin8070630178765169018 join aggView6881992352828696731 using(v36));
create or replace view aggJoin7579760939303610066 as (
with aggView7521360783418814520 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4150695753466635876 group by v36,v48,v49)
select v36, v31, v32, v48, v49 from aggJoin3983427525823134828 join aggView7521360783418814520 using(v36));
create or replace view aggJoin4337097818831053121 as (
with aggView3041820416620691716 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin7579760939303610066 group by v36,v48,v49)
select v48, v49 from aggJoin8610211299528987893 join aggView3041820416620691716 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin4337097818831053121;
