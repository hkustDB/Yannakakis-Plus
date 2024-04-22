create or replace view aggJoin2596201918041865992 as (
with aggView49425811479473614 as (select id as v31, name as v52 from name as n)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView49425811479473614 where ci.person_id=aggView49425811479473614.v31);
create or replace view aggJoin6728446442898769917 as (
with aggView6238869709572193761 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin2596201918041865992 join aggView6238869709572193761 using(v9));
create or replace view aggJoin8508721085671701762 as (
with aggView7157710778843871960 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView7157710778843871960 where t.kind_id=aggView7157710778843871960.v26 and production_year>2000);
create or replace view aggJoin5886997023748727496 as (
with aggView5675553089237537772 as (select v40, MIN(v41) as v53 from aggJoin8508721085671701762 group by v40)
select movie_id as v40, subject_id as v5, status_id as v7, v53 from complete_cast as cc, aggView5675553089237537772 where cc.movie_id=aggView5675553089237537772.v40);
create or replace view aggJoin2951637361323241755 as (
with aggView1835504147564342160 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40, v5, v53 from aggJoin5886997023748727496 join aggView1835504147564342160 using(v7));
create or replace view aggJoin8572596579821910000 as (
with aggView3007662415063641121 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView3007662415063641121 where mk.keyword_id=aggView3007662415063641121.v23);
create or replace view aggJoin3845949751218238421 as (
with aggView5918294618202741971 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40, v53 from aggJoin2951637361323241755 join aggView5918294618202741971 using(v5));
create or replace view aggJoin1996721484920145950 as (
with aggView8389372380720522935 as (select v40, MIN(v53) as v53 from aggJoin3845949751218238421 group by v40,v53)
select v40, v53 from aggJoin8572596579821910000 join aggView8389372380720522935 using(v40));
create or replace view aggJoin748806444760777746 as (
with aggView8270893759061187285 as (select v40, MIN(v53) as v53 from aggJoin1996721484920145950 group by v40,v53)
select v52 as v52, v53 from aggJoin6728446442898769917 join aggView8270893759061187285 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin748806444760777746;
