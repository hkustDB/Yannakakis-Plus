create or replace view aggJoin8338301069539870507 as (
with aggView542950607810515129 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView542950607810515129 where mc.company_id=aggView542950607810515129.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin860697574642258206 as (
with aggView7523298342948813296 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin8338301069539870507 join aggView7523298342948813296 using(v8));
create or replace view aggJoin7718386371051769166 as (
with aggView4819585108517818381 as (select v37, MIN(v49) as v49 from aggJoin860697574642258206 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView4819585108517818381 where t.id=aggView4819585108517818381.v37 and production_year>2005);
create or replace view aggJoin1842343162745586870 as (
with aggView8860753936789682834 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin7718386371051769166 join aggView8860753936789682834 using(v17));
create or replace view aggJoin856045138709723464 as (
with aggView748742861478698341 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin1842343162745586870 group by v37,v49)
select movie_id as v37, keyword_id as v14, v49, v51 from movie_keyword as mk, aggView748742861478698341 where mk.movie_id=aggView748742861478698341.v37);
create or replace view aggJoin4702019868618776310 as (
with aggView2517233629520687661 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2517233629520687661 where mi_idx.info_type_id=aggView2517233629520687661.v12 and info<'8.5');
create or replace view aggJoin4878154781320981150 as (
with aggView3427757081021163358 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView3427757081021163358 where mi.info_type_id=aggView3427757081021163358.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8343286112488032406 as (
with aggView3987693135421281374 as (select v37 from aggJoin4878154781320981150 group by v37)
select v37, v32 from aggJoin4702019868618776310 join aggView3987693135421281374 using(v37));
create or replace view aggJoin8528980675899036471 as (
with aggView2083142068847961758 as (select v37, MIN(v32) as v50 from aggJoin8343286112488032406 group by v37)
select v14, v49 as v49, v51 as v51, v50 from aggJoin856045138709723464 join aggView2083142068847961758 using(v37));
create or replace view aggJoin5176947423686295210 as (
with aggView3324082408536203697 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin8528980675899036471 join aggView3324082408536203697 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin5176947423686295210;
