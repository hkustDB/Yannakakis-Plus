create or replace view aggJoin8321081831121674272 as (
with aggView8555448231392202972 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView8555448231392202972 where cc.subject_id=aggView8555448231392202972.v5);
create or replace view aggJoin681405927762216468 as (
with aggView8622807573429418255 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView8622807573429418255 where ci.person_id=aggView8622807573429418255.v31);
create or replace view aggJoin8315516872855636358 as (
with aggView6690218959901417647 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin8321081831121674272 join aggView6690218959901417647 using(v7));
create or replace view aggJoin567440397083417875 as (
with aggView3373892483156987451 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView3373892483156987451 where t.kind_id=aggView3373892483156987451.v26 and production_year>1950);
create or replace view aggJoin858352022166235128 as (
with aggView743705739503331412 as (select v40 from aggJoin8315516872855636358 group by v40)
select movie_id as v40, keyword_id as v23 from movie_keyword as mk, aggView743705739503331412 where mk.movie_id=aggView743705739503331412.v40);
create or replace view aggJoin6455980082866179698 as (
with aggView6818584564325072192 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin681405927762216468 join aggView6818584564325072192 using(v9));
create or replace view aggJoin5474565942600990377 as (
with aggView5968909195454025913 as (select v40 from aggJoin6455980082866179698 group by v40)
select v40, v41, v44 from aggJoin567440397083417875 join aggView5968909195454025913 using(v40));
create or replace view aggJoin2448699954331780780 as (
with aggView5909617846816684856 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select v40 from aggJoin858352022166235128 join aggView5909617846816684856 using(v23));
create or replace view aggJoin3652047882914442389 as (
with aggView277573037716949811 as (select v40 from aggJoin2448699954331780780 group by v40)
select v41, v44 from aggJoin5474565942600990377 join aggView277573037716949811 using(v40));
create or replace view aggView3747895269051996384 as select v41 from aggJoin3652047882914442389 group by v41;
select MIN(v41) as v52 from aggView3747895269051996384;
