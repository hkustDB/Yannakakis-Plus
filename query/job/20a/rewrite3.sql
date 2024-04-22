create or replace view aggJoin6895084730361651318 as (
with aggView4401996533491198842 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView4401996533491198842 where cc.subject_id=aggView4401996533491198842.v5);
create or replace view aggJoin3697410627760759560 as (
with aggView6169448789442254954 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView6169448789442254954 where ci.person_id=aggView6169448789442254954.v31);
create or replace view aggJoin3196905287663489800 as (
with aggView9056743726773776821 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin6895084730361651318 join aggView9056743726773776821 using(v7));
create or replace view aggJoin6016213260249282040 as (
with aggView1875975409514292652 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView1875975409514292652 where t.kind_id=aggView1875975409514292652.v26 and production_year>1950);
create or replace view aggJoin9148846965590534678 as (
with aggView6293397811958653037 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin3697410627760759560 join aggView6293397811958653037 using(v9));
create or replace view aggJoin323112417297485533 as (
with aggView5851761984392070350 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView5851761984392070350 where mk.keyword_id=aggView5851761984392070350.v23);
create or replace view aggJoin5748455576204215308 as (
with aggView844095623355245435 as (select v40 from aggJoin323112417297485533 group by v40)
select v40 from aggJoin9148846965590534678 join aggView844095623355245435 using(v40));
create or replace view aggJoin5095897808120329831 as (
with aggView8222673939518371111 as (select v40 from aggJoin5748455576204215308 group by v40)
select v40 from aggJoin3196905287663489800 join aggView8222673939518371111 using(v40));
create or replace view aggJoin6104956986770038508 as (
with aggView1744324064218100821 as (select v40 from aggJoin5095897808120329831 group by v40)
select v41, v44 from aggJoin6016213260249282040 join aggView1744324064218100821 using(v40));
create or replace view aggView3632836218453992953 as select v41 from aggJoin6104956986770038508 group by v41;
select MIN(v41) as v52 from aggView3632836218453992953;
