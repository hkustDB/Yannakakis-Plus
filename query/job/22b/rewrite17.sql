create or replace view aggView1363772628337834526 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin2797820339076827351 as (
with aggView1645749247546081029 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1645749247546081029 where mi_idx.info_type_id=aggView1645749247546081029.v12 and info<'7.0');
create or replace view aggView1504240554968453772 as select v37, v32 from aggJoin2797820339076827351 group by v37,v32;
create or replace view aggJoin7643611527831002200 as (
with aggView5470974168164738211 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView5470974168164738211 where t.kind_id=aggView5470974168164738211.v17 and production_year>2009);
create or replace view aggView1516867927484528873 as select v38, v37 from aggJoin7643611527831002200 group by v38,v37;
create or replace view aggJoin8190644311600888216 as (
with aggView8130675728549064305 as (select v1, MIN(v2) as v49 from aggView1363772628337834526 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView8130675728549064305 where mc.company_id=aggView8130675728549064305.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3791657731594546351 as (
with aggView4837790430985227711 as (select v37, MIN(v32) as v50 from aggView1504240554968453772 group by v37)
select v38, v37, v50 from aggView1516867927484528873 join aggView4837790430985227711 using(v37));
create or replace view aggJoin5555709359089844441 as (
with aggView2154922767617350922 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin8190644311600888216 join aggView2154922767617350922 using(v8));
create or replace view aggJoin2579570874533158010 as (
with aggView631053403554121193 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView631053403554121193 where mi.info_type_id=aggView631053403554121193.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin45568864501231292 as (
with aggView2807692721683772894 as (select v37 from aggJoin2579570874533158010 group by v37)
select v37, v23, v49 as v49 from aggJoin5555709359089844441 join aggView2807692721683772894 using(v37));
create or replace view aggJoin3612712585159502294 as (
with aggView814426429900457665 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView814426429900457665 where mk.keyword_id=aggView814426429900457665.v14);
create or replace view aggJoin5602561183039860957 as (
with aggView4932917382002494752 as (select v37 from aggJoin3612712585159502294 group by v37)
select v37, v23, v49 as v49 from aggJoin45568864501231292 join aggView4932917382002494752 using(v37));
create or replace view aggJoin1125539926183894687 as (
with aggView7441186938479938783 as (select v37, MIN(v49) as v49 from aggJoin5602561183039860957 group by v37,v49)
select v38, v50 as v50, v49 from aggJoin3791657731594546351 join aggView7441186938479938783 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v38) as v51 from aggJoin1125539926183894687;
