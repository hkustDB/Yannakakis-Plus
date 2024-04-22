create or replace view aggJoin1447545637001459372 as (
with aggView8592174798384549514 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v40, status_id as v7 from complete_cast as cc, aggView8592174798384549514 where cc.subject_id=aggView8592174798384549514.v5);
create or replace view aggJoin6343808261334451339 as (
with aggView6995472855165703316 as (select id as v31 from name as n)
select movie_id as v40, person_role_id as v9 from cast_info as ci, aggView6995472855165703316 where ci.person_id=aggView6995472855165703316.v31);
create or replace view aggJoin868400261327149544 as (
with aggView8895587387727437762 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v40 from aggJoin1447545637001459372 join aggView8895587387727437762 using(v7));
create or replace view aggJoin272303405009354984 as (
with aggView7146328341772336220 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView7146328341772336220 where t.kind_id=aggView7146328341772336220.v26 and production_year>1950);
create or replace view aggJoin7040503878546936916 as (
with aggView4220315916990304178 as (select v40, MIN(v41) as v52 from aggJoin272303405009354984 group by v40)
select v40, v52 from aggJoin868400261327149544 join aggView4220315916990304178 using(v40));
create or replace view aggJoin28743893574616482 as (
with aggView4221005468549494527 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select v40 from aggJoin6343808261334451339 join aggView4221005468549494527 using(v9));
create or replace view aggJoin5983750239933750647 as (
with aggView330175785563526821 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView330175785563526821 where mk.keyword_id=aggView330175785563526821.v23);
create or replace view aggJoin7532521280426525238 as (
with aggView7484589074745841978 as (select v40 from aggJoin5983750239933750647 group by v40)
select v40, v52 as v52 from aggJoin7040503878546936916 join aggView7484589074745841978 using(v40));
create or replace view aggJoin516146359815193685 as (
with aggView4607973862949933656 as (select v40, MIN(v52) as v52 from aggJoin7532521280426525238 group by v40,v52)
select v52 from aggJoin28743893574616482 join aggView4607973862949933656 using(v40));
select MIN(v52) as v52 from aggJoin516146359815193685;
