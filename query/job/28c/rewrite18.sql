create or replace view aggJoin4974965495356345935 as (
with aggView6408686440133175046 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6408686440133175046 where mc.company_id=aggView6408686440133175046.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7042136857300639360 as (
with aggView8769989279630195048 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8769989279630195048 where t.kind_id=aggView8769989279630195048.v25 and production_year>2005);
create or replace view aggJoin7553342290255224971 as (
with aggView5178555622546507351 as (select v45, MIN(v46) as v59 from aggJoin7042136857300639360 group by v45)
select movie_id as v45, keyword_id as v22, v59 from movie_keyword as mk, aggView5178555622546507351 where mk.movie_id=aggView5178555622546507351.v45);
create or replace view aggJoin8310755051374216159 as (
with aggView1969533867868719129 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView1969533867868719129 where cc.subject_id=aggView1969533867868719129.v5);
create or replace view aggJoin2500815015414475339 as (
with aggView6995237760152863644 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6995237760152863644 where mi_idx.info_type_id=aggView6995237760152863644.v20 and info<'8.5');
create or replace view aggJoin836393674347379388 as (
with aggView8300507905182051543 as (select v45, MIN(v40) as v58 from aggJoin2500815015414475339 group by v45)
select v45, v22, v59 as v59, v58 from aggJoin7553342290255224971 join aggView8300507905182051543 using(v45));
create or replace view aggJoin2530248648266828413 as (
with aggView8746445691271684184 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4974965495356345935 join aggView8746445691271684184 using(v16));
create or replace view aggJoin992046657463366499 as (
with aggView7576794202998313181 as (select v45, MIN(v57) as v57 from aggJoin2530248648266828413 group by v45)
select v45, v22, v59 as v59, v58 as v58, v57 from aggJoin836393674347379388 join aggView7576794202998313181 using(v45));
create or replace view aggJoin8820471214309877629 as (
with aggView6004016269790893462 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin8310755051374216159 join aggView6004016269790893462 using(v7));
create or replace view aggJoin3074424631762632891 as (
with aggView5089113373365695819 as (select v45 from aggJoin8820471214309877629 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView5089113373365695819 where mi.movie_id=aggView5089113373365695819.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1916960985227383316 as (
with aggView374691577831551958 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin3074424631762632891 join aggView374691577831551958 using(v18));
create or replace view aggJoin6158373098608105165 as (
with aggView4320731103346872633 as (select v45 from aggJoin1916960985227383316 group by v45)
select v22, v59 as v59, v58 as v58, v57 as v57 from aggJoin992046657463366499 join aggView4320731103346872633 using(v45));
create or replace view aggJoin7767583963401010599 as (
with aggView4871910423134316555 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v59, v58, v57 from aggJoin6158373098608105165 join aggView4871910423134316555 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin7767583963401010599;
