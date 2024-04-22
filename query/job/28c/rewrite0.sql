create or replace view aggView1089827438683482826 as select id as v9, name as v10 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1867790694304953391 as (
with aggView7745301363450712675 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7745301363450712675 where t.kind_id=aggView7745301363450712675.v25 and production_year>2005);
create or replace view aggJoin2279162678626550934 as (
with aggView5543294487040263521 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5543294487040263521 where cc.subject_id=aggView5543294487040263521.v5);
create or replace view aggJoin1298337939248440335 as (
with aggView7102899674491302333 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7102899674491302333 where mi_idx.info_type_id=aggView7102899674491302333.v20);
create or replace view aggJoin2589189050595543578 as (
with aggView8329330263887752043 as (select v40, v45 from aggJoin1298337939248440335 group by v40,v45)
select v45, v40 from aggView8329330263887752043 where v40<'8.5');
create or replace view aggJoin2495824860989657044 as (
with aggView6415017918900075108 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin2279162678626550934 join aggView6415017918900075108 using(v7));
create or replace view aggJoin7026711447508576324 as (
with aggView3325704352811162194 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView3325704352811162194 where mk.keyword_id=aggView3325704352811162194.v22);
create or replace view aggJoin1075062688696082069 as (
with aggView8797617958012510833 as (select v45 from aggJoin7026711447508576324 group by v45)
select v45 from aggJoin2495824860989657044 join aggView8797617958012510833 using(v45));
create or replace view aggJoin8821407565675366383 as (
with aggView5346588494549362713 as (select v45 from aggJoin1075062688696082069 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView5346588494549362713 where mi.movie_id=aggView5346588494549362713.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2366781215260683256 as (
with aggView261833247219954272 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin8821407565675366383 join aggView261833247219954272 using(v18));
create or replace view aggJoin5805497342576101302 as (
with aggView7711840732676073877 as (select v45 from aggJoin2366781215260683256 group by v45)
select v45, v46, v49 from aggJoin1867790694304953391 join aggView7711840732676073877 using(v45));
create or replace view aggView6946745504486367543 as select v46, v45 from aggJoin5805497342576101302 group by v46,v45;
create or replace view aggJoin4959830056156684294 as (
with aggView5632515065756293890 as (select v9, MIN(v10) as v57 from aggView1089827438683482826 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView5632515065756293890 where mc.company_id=aggView5632515065756293890.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4238547671443197879 as (
with aggView227373183141039576 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4959830056156684294 join aggView227373183141039576 using(v16));
create or replace view aggJoin5677881111649302820 as (
with aggView7848658774677083443 as (select v45, MIN(v57) as v57 from aggJoin4238547671443197879 group by v45,v57)
select v45, v40, v57 from aggJoin2589189050595543578 join aggView7848658774677083443 using(v45));
create or replace view aggJoin8440105461046862372 as (
with aggView8906110083730052804 as (select v45, MIN(v57) as v57, MIN(v40) as v58 from aggJoin5677881111649302820 group by v45,v57)
select v46, v57, v58 from aggView6946745504486367543 join aggView8906110083730052804 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin8440105461046862372;
