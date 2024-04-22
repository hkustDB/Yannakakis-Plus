create or replace view aggJoin8394710674379392373 as (
with aggView3628316360058675026 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView3628316360058675026 where cc.subject_id=aggView3628316360058675026.v5);
create or replace view aggJoin1660762921181025904 as (
with aggView2013977842619878838 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView2013977842619878838 where ci.person_id=aggView2013977842619878838.v31);
create or replace view aggJoin1084435543330042354 as (
with aggView8031740311812963150 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin8394710674379392373 join aggView8031740311812963150 using(v7));
create or replace view aggJoin3910291498945949401 as (
with aggView1448759428402497547 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1448759428402497547 where t.kind_id=aggView1448759428402497547.v26 and production_year>1950);
create or replace view aggJoin1133926432685490716 as (
with aggView1228785846838743237 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin1660762921181025904 join aggView1228785846838743237 using(v9));
create or replace view aggJoin5560997831562123671 as (
with aggView6112947283358748394 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView6112947283358748394 where mk.keyword_id=aggView6112947283358748394.v23);
create or replace view aggJoin2733181023241409380 as (
with aggView7935818281606277404 as (select v40 from aggJoin5560997831562123671 group by v40)
select v40 from aggJoin1084435543330042354 join aggView7935818281606277404 using(v40));
create or replace view aggJoin8945565812687796636 as (
with aggView2433889163925006249 as (select v40 from aggJoin2733181023241409380 group by v40)
select v40 from aggJoin1133926432685490716 join aggView2433889163925006249 using(v40));
create or replace view aggJoin6251851744198519211 as (
with aggView8047775308584105179 as (select v40 from aggJoin8945565812687796636 group by v40)
select v41, v44 from aggJoin3910291498945949401 join aggView8047775308584105179 using(v40));
create or replace view aggView3507586635790822394 as select v41 from aggJoin6251851744198519211 group by v41;
select MIN(v41) as v52 from aggView3507586635790822394;
