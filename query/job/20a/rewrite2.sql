create or replace view aggJoin1246855782550404477 as (
with aggView1488233831475798992 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView1488233831475798992 where cc.subject_id=aggView1488233831475798992.v5);
create or replace view aggJoin5905631897753503207 as (
with aggView6139624558390039993 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView6139624558390039993 where ci.person_id=aggView6139624558390039993.v31);
create or replace view aggJoin5921661926899582980 as (
with aggView8892999632243902498 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin1246855782550404477 join aggView8892999632243902498 using(v7));
create or replace view aggJoin4642002576014015542 as (
with aggView1722917270434996766 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1722917270434996766 where t.kind_id=aggView1722917270434996766.v26 and production_year>1950);
create or replace view aggJoin228201091836482393 as (
with aggView443060544376395621 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin5905631897753503207 join aggView443060544376395621 using(v9));
create or replace view aggJoin7149848953584150172 as (
with aggView5865339281680558423 as (select v40 from aggJoin228201091836482393 group by v40)
select v40, v41, v44 from aggJoin4642002576014015542 join aggView5865339281680558423 using(v40));
create or replace view aggJoin7353181548881161001 as (
with aggView7761988197548437245 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView7761988197548437245 where mk.keyword_id=aggView7761988197548437245.v23);
create or replace view aggJoin3972796968639979713 as (
with aggView5144696568432298122 as (select v40 from aggJoin7353181548881161001 group by v40)
select v40 from aggJoin5921661926899582980 join aggView5144696568432298122 using(v40));
create or replace view aggJoin8354284631764846274 as (
with aggView4807754930081947000 as (select v40 from aggJoin3972796968639979713 group by v40)
select v41, v44 from aggJoin7149848953584150172 join aggView4807754930081947000 using(v40));
create or replace view aggView2321143059546029803 as select v41 from aggJoin8354284631764846274 group by v41;
select MIN(v41) as v52 from aggView2321143059546029803;
