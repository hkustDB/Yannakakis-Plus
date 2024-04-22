create or replace view aggJoin6252021925580597044 as (
with aggView7505643988847944820 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7505643988847944820 where mc.company_id=aggView7505643988847944820.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin102033223687115628 as (
with aggView645853083061148928 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView645853083061148928 where mk.keyword_id=aggView645853083061148928.v22);
create or replace view aggJoin8828274962094849832 as (
with aggView8077189139736637611 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView8077189139736637611 where mi.info_type_id=aggView8077189139736637611.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8535425284162333641 as (
with aggView5879734589436022748 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5879734589436022748 where cc.status_id=aggView5879734589436022748.v7);
create or replace view aggJoin5082668741334645734 as (
with aggView5909554851531468782 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8535425284162333641 join aggView5909554851531468782 using(v5));
create or replace view aggJoin5938663050698025739 as (
with aggView709586000783462791 as (select v45 from aggJoin5082668741334645734 group by v45)
select v45 from aggJoin102033223687115628 join aggView709586000783462791 using(v45));
create or replace view aggJoin7943943682912137600 as (
with aggView7337250396168445472 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin6252021925580597044 join aggView7337250396168445472 using(v16));
create or replace view aggJoin7199078147083410108 as (
with aggView1800793240425532714 as (select v45, MIN(v57) as v57 from aggJoin7943943682912137600 group by v45,v57)
select id as v45, title as v46, kind_id as v25, production_year as v49, v57 from title as t, aggView1800793240425532714 where t.id=aggView1800793240425532714.v45 and production_year>2000);
create or replace view aggJoin7824090899412356422 as (
with aggView6806210149481403310 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49, v57 from aggJoin7199078147083410108 join aggView6806210149481403310 using(v25));
create or replace view aggJoin2237848517080146245 as (
with aggView4888413701040601093 as (select v45, MIN(v57) as v57, MIN(v46) as v59 from aggJoin7824090899412356422 group by v45,v57)
select v45, v35, v57, v59 from aggJoin8828274962094849832 join aggView4888413701040601093 using(v45));
create or replace view aggJoin1503377670733497246 as (
with aggView6682190331407912082 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin2237848517080146245 group by v45,v59,v57)
select v45, v57, v59 from aggJoin5938663050698025739 join aggView6682190331407912082 using(v45));
create or replace view aggJoin6930802299633100628 as (
with aggView7738674595497325485 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7738674595497325485 where mi_idx.info_type_id=aggView7738674595497325485.v20 and info<'8.5');
create or replace view aggJoin4489759351543213506 as (
with aggView9174843389814208922 as (select v45, MIN(v40) as v58 from aggJoin6930802299633100628 group by v45)
select v57 as v57, v59 as v59, v58 from aggJoin1503377670733497246 join aggView9174843389814208922 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin4489759351543213506;
